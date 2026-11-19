#!/usr/bin/env node
// FAES repository self-check. Zero dependencies, Node >= 18. Exit 1 on any error.
import { existsSync, readFileSync, readdirSync, statSync } from 'node:fs';
import { dirname, join, relative, resolve, sep } from 'node:path';
import { fileURLToPath } from 'node:url';
import { listFiles, sha256 } from './generate-checksums.mjs';

const ROOT = join(fileURLToPath(new URL('.', import.meta.url)), '..');
const errors = [];
const warnings = [];
const err = (m) => errors.push(m);
const read = (p) => readFileSync(join(ROOT, p), 'utf8').replace(/^﻿/, '');

// 1. Version consistency
const version = read('VERSION').trim();
if (!/^\d+\.\d+\.\d+$/.test(version)) err(`VERSION is not semver: ${version}`);
const expectInFile = (file, re, label) => {
  const m = re.exec(read(file));
  if (!m) err(`${file}: missing ${label}`);
  else if (m[1] !== version) err(`${file}: ${label} is ${m[1]}, expected ${version}`);
};
expectInFile('README.md', /\*\*Version:\*\*\s*(\S+)/, 'Version');
expectInFile('AGENTS.md', /\*\*FAES version:\*\*\s*(\S+)/, 'FAES version');
expectInFile('CHANGELOG.md', /^##\s+(\d+\.\d+\.\d+)/m, 'top changelog heading');
expectInFile('integrations/ecc/integration.json', /"faes_version":\s*"([^"]+)"/, 'faes_version');

// 2. Skills: frontmatter, name == directory, indexed
const skillsDir = join(ROOT, 'skills');
const skills = readdirSync(skillsDir).filter((d) => statSync(join(skillsDir, d)).isDirectory());
const index = read('skills/README.md');
for (const s of skills) {
  const f = `skills/${s}/SKILL.md`;
  if (!existsSync(join(ROOT, f))) { err(`${f}: missing`); continue; }
  const fm = /^---\r?\n([\s\S]*?)\r?\n---/.exec(read(f));
  if (!fm) { err(`${f}: no YAML frontmatter`); continue; }
  const name = /^name:\s*(.+)$/m.exec(fm[1])?.[1]?.trim().replace(/^["']|["']$/g, '');
  if (name !== s) err(`${f}: frontmatter name "${name}" != directory "${s}"`);
  if (!/^description:\s*\S+/m.test(fm[1])) err(`${f}: missing description`);
  if (!index.includes('`' + s + '`')) err(`skills/README.md: skill "${s}" not indexed`);
}

// 3. Integration metadata
for (const d of readdirSync(join(ROOT, 'integrations'))) {
  const f = `integrations/${d}/integration.json`;
  if (!existsSync(join(ROOT, f))) continue;
  let j;
  try { j = JSON.parse(read(f)); } catch (e) { err(`${f}: invalid JSON (${e.message})`); continue; }
  const commit = j.upstream?.pinnedCommit;
  if (commit && !/^[0-9a-f]{40}$/.test(commit)) err(`${f}: pinnedCommit is not a 40-hex SHA`);
  if (j.skillPath && !existsSync(join(ROOT, j.skillPath))) err(`${f}: skillPath not found: ${j.skillPath}`);
}
for (const f of ['adapters/claude/hooks.json', 'adapters/claude/adapter.json', 'adapters/antigravity/hooks.json']) {
  try { JSON.parse(read(f)); } catch (e) { err(`${f}: invalid JSON (${e.message})`); }
}

// 4. Internal Markdown links (own files only; vendored upstream docs are skipped)
const VENDORED = ['skills/security-audit/', 'skills/unslop/'];
const mdFiles = listFiles().filter((f) => f.endsWith('.md') && !VENDORED.some((v) => f.startsWith(v)));
const linkRe = /\[[^\]]*\]\(([^)\s]+)(?:\s+"[^"]*")?\)/g;
for (const f of mdFiles) {
  const text = read(f).replace(/```[\s\S]*?```/g, '');
  for (const m of text.matchAll(linkRe)) {
    let target = m[1];
    if (/^(https?:|mailto:|#|<)/.test(target)) continue;
    target = decodeURIComponent(target.split('#')[0]);
    if (!target) continue;
    const abs = resolve(ROOT, dirname(f), target);
    if (!abs.startsWith(ROOT + sep) && abs !== ROOT) continue;
    if (!existsSync(abs)) err(`${f}: broken link -> ${m[1]}`);
  }
}

// 5. Hook script syntax
for (const f of ['adapters/claude/hooks/pre-tool-use.js', 'adapters/claude/hooks/post-tool-use.js']) {
  if (!existsSync(join(ROOT, f))) err(`${f}: missing`);
}
if (read('scripts/faes-secret-guard.mjs') !== read('adapters/claude/hooks/faes-secret-guard.mjs'))
  err('adapters/claude/hooks/faes-secret-guard.mjs differs from scripts/faes-secret-guard.mjs (keep copies identical)');

// 6. Checksums
if (!existsSync(join(ROOT, 'SHA256SUMS.txt'))) err('SHA256SUMS.txt missing (run scripts/generate-checksums.mjs)');
else {
  const listed = new Map();
  for (const line of read('SHA256SUMS.txt').split(/\r?\n/).filter(Boolean)) {
    const m = /^([0-9a-f]{64})\s+(.+)$/.exec(line);
    if (!m) { err(`SHA256SUMS.txt: malformed line: ${line.slice(0, 60)}`); continue; }
    listed.set(m[2].replace(/\\/g, '/'), m[1]);
  }
  const actual = new Set(listFiles());
  for (const [f, h] of listed) {
    if (!actual.has(f)) err(`SHA256SUMS.txt: lists missing file ${f}`);
    else if (sha256(f) !== h) err(`SHA256SUMS.txt: hash mismatch ${f}`);
  }
  for (const f of actual) if (!listed.has(f)) err(`SHA256SUMS.txt: file not listed ${f}`);
}

for (const w of warnings) console.warn('warn:', w);
if (errors.length) {
  console.error(`FAES validation failed (${errors.length}):`);
  for (const e of errors) console.error('  -', e);
  process.exit(1);
}
console.log(`FAES ${version} validation passed: ${skills.length} skills, ${mdFiles.length} markdown files checked.`);
