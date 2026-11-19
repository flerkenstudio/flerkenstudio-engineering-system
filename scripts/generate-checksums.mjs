#!/usr/bin/env node
// Regenerates SHA256SUMS.txt for every tracked-style file in the repository.
import { createHash } from 'node:crypto';
import { readdirSync, readFileSync, statSync, writeFileSync } from 'node:fs';
import { join, relative, sep } from 'node:path';
import { fileURLToPath } from 'node:url';

const ROOT = join(fileURLToPath(new URL('.', import.meta.url)), '..');
const SKIP = new Set(['.git', 'node_modules']);
const OUT = 'SHA256SUMS.txt';

export function listFiles(dir = ROOT, out = []) {
  for (const e of readdirSync(dir).sort()) {
    if (SKIP.has(e)) continue;
    const p = join(dir, e);
    if (statSync(p).isDirectory()) listFiles(p, out);
    else if (relative(ROOT, p) !== OUT) out.push(relative(ROOT, p).split(sep).join('/'));
  }
  return out;
}

export function sha256(file) {
  return createHash('sha256').update(readFileSync(join(ROOT, file))).digest('hex');
}

if (process.argv[1] && fileURLToPath(import.meta.url) === process.argv[1]) {
  const lines = listFiles().map((f) => `${sha256(f)}  ${f}`);
  writeFileSync(join(ROOT, OUT), lines.join('\n') + '\n');
  console.log(`Wrote ${OUT} with ${lines.length} entries.`);
}
