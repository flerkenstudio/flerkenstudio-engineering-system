#!/usr/bin/env node
// FAES secret guard: zero-dependency, offline, pattern-based fallback for secret scanning.
// Prefer TruffleHog (see skills/secret-scanning). This script never validates credentials and
// never prints full secret values.
//
// Usage:
//   node faes-secret-guard.mjs --staged            scan added lines of the staged git diff
//   node faes-secret-guard.mjs --path <file|dir>   scan files (repeatable)
//   node faes-secret-guard.mjs --staged --json     machine-readable output
// Exit codes: 0 clean, 1 findings, 2 usage/runtime error.
// Suppress a known-safe line by adding the text "faes-secret-ignore" on that line.

import { execFileSync } from 'node:child_process';
import { readdirSync, readFileSync, statSync } from 'node:fs';
import { join, basename } from 'node:path';

export const RULES = [
  { id: 'aws-access-key-id', re: /\b(AKIA|ASIA)[0-9A-Z]{16}\b/ },
  { id: 'github-token', re: /\b(ghp|gho|ghu|ghs|ghr)_[A-Za-z0-9]{36,}\b/ },
  { id: 'github-fine-grained-pat', re: /\bgithub_pat_[A-Za-z0-9_]{50,}\b/ },
  { id: 'slack-token', re: /\bxox[abprs]-[A-Za-z0-9-]{10,}\b/ },
  { id: 'stripe-live-key', re: /\b[sr]k_live_[A-Za-z0-9]{20,}\b/ },
  { id: 'google-api-key', re: /\bAIza[0-9A-Za-z_-]{35}\b/ },
  { id: 'anthropic-api-key', re: /\bsk-ant-[A-Za-z0-9_-]{20,}\b/ },
  { id: 'openai-api-key', re: /\bsk-(proj-)?[A-Za-z0-9_-]{32,}\b/ },
  { id: 'private-key-block', re: /-----BEGIN (RSA |EC |DSA |OPENSSH |PGP |ENCRYPTED )?PRIVATE KEY( BLOCK)?-----/ },
  { id: 'jwt', re: /\beyJ[A-Za-z0-9_-]{10,}\.eyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}\b/ },
  {
    id: 'credential-assignment',
    re: /\b(password|passwd|secret|api[_-]?key|access[_-]?token|auth[_-]?token|client[_-]?secret)\b\s*[:=]\s*["']([^"'\s]{12,})["']/i,
    group: 2,
    entropy: 3.2,
  },
];

const PLACEHOLDER = /(example|placeholder|changeme|your[_-]?|xxxx|<[^>]+>|\$\{|process\.env|os\.environ|dummy|sample|test)/i;
const SKIP_DIRS = new Set(['.git', 'node_modules', 'dist', 'build', '.venv', 'vendor', '__pycache__']);
const SKIP_EXT = /\.(png|jpe?g|gif|webp|ico|pdf|zip|gz|tar|woff2?|ttf|mp4|mov|lock)$/i;
const MAX_BYTES = 1_000_000;

export function entropy(s) {
  const counts = new Map();
  for (const c of s) counts.set(c, (counts.get(c) ?? 0) + 1);
  let h = 0;
  for (const n of counts.values()) {
    const p = n / s.length;
    h -= p * Math.log2(p);
  }
  return h;
}

export function redact(v) {
  return v.length <= 4 ? '****' : `${v.slice(0, 4)}${'*'.repeat(Math.min(12, v.length - 4))}`;
}

export function scanText(text, label) {
  const findings = [];
  text.split(/\r?\n/).forEach((line, i) => {
    if (line.includes('faes-secret-ignore')) return;
    for (const rule of RULES) {
      const m = rule.re.exec(line);
      if (!m) continue;
      const value = m[rule.group ?? 0];
      if (rule.entropy && (entropy(value) < rule.entropy || PLACEHOLDER.test(value))) continue;
      findings.push({ rule: rule.id, file: label, line: i + 1, preview: redact(value) });
      break;
    }
  });
  return findings;
}

function scanStaged() {
  const diff = execFileSync('git', ['diff', '--cached', '-U0', '--no-color', '--diff-filter=ACMR'], {
    encoding: 'utf8',
    maxBuffer: 64 * 1024 * 1024,
  });
  const findings = [];
  let file = '';
  let lineNo = 0;
  for (const raw of diff.split('\n')) {
    if (raw.startsWith('+++ b/')) { file = raw.slice(6); continue; }
    const hunk = /^@@ -\d+(?:,\d+)? \+(\d+)/.exec(raw);
    if (hunk) { lineNo = Number(hunk[1]) - 1; continue; }
    if (raw.startsWith('+') && !raw.startsWith('+++')) {
      lineNo += 1;
      if (SKIP_EXT.test(file)) continue;
      for (const f of scanText(raw.slice(1), file)) findings.push({ ...f, line: lineNo });
    }
  }
  return findings;
}

function walk(p, out) {
  const st = statSync(p);
  if (st.isDirectory()) {
    if (SKIP_DIRS.has(basename(p))) return;
    for (const e of readdirSync(p)) walk(join(p, e), out);
  } else if (st.isFile() && st.size <= MAX_BYTES && !SKIP_EXT.test(p)) {
    out.push(p);
  }
}

function scanPaths(paths) {
  const files = [];
  for (const p of paths) walk(p, files);
  return files.flatMap((f) => scanText(readFileSync(f, 'utf8'), f));
}

function main(argv) {
  const paths = [];
  let staged = false;
  let json = false;
  for (let i = 0; i < argv.length; i++) {
    if (argv[i] === '--staged') staged = true;
    else if (argv[i] === '--json') json = true;
    else if (argv[i] === '--path' && argv[i + 1]) paths.push(argv[++i]);
    else { console.error(`Unknown or incomplete option: ${argv[i]}`); return 2; }
  }
  if (!staged && paths.length === 0) { console.error('Usage: --staged | --path <file|dir> [--json]'); return 2; }
  let findings;
  try {
    findings = [...(staged ? scanStaged() : []), ...scanPaths(paths)];
  } catch (e) {
    console.error(`faes-secret-guard error: ${e.message}`);
    return 2;
  }
  if (json) console.log(JSON.stringify({ findings }, null, 2));
  else if (findings.length === 0) console.log('faes-secret-guard: no secrets matched (heuristic scan; not a guarantee).');
  else {
    console.error(`faes-secret-guard: ${findings.length} potential secret(s):`);
    for (const f of findings) console.error(`  ${f.file}:${f.line}  ${f.rule}  ${f.preview}`);
    console.error('Rotate real credentials first, then remove them from code. Add "faes-secret-ignore" to a line only for confirmed false positives.');
  }
  return findings.length ? 1 : 0;
}

import { fileURLToPath } from 'node:url';
if (process.argv[1] && fileURLToPath(import.meta.url) === process.argv[1]) process.exit(main(process.argv.slice(2)));
