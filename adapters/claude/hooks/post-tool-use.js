#!/usr/bin/env node
// FAES Claude Code PostToolUse hook (Write|Edit matcher).
// Warns Claude when a just-written file contains likely secrets. Exit 2 surfaces stderr to Claude.
'use strict';
const { spawnSync } = require('node:child_process');
const path = require('node:path');

let input = '';
process.stdin.on('data', (c) => (input += c));
process.stdin.on('end', () => {
  let file = '';
  try { const ti = JSON.parse(input || '{}').tool_input ?? {}; file = String(ti.file_path ?? ti.path ?? ''); } catch { process.exit(0); }
  if (!file) process.exit(0);
  const g = spawnSync(process.execPath, [path.join(__dirname, 'faes-secret-guard.mjs'), '--path', file], { encoding: 'utf8' });
  if (g.status === 1) {
    process.stderr.write(`FAES secret guard: ${file} appears to contain a secret. Move it to an environment variable or secret manager and rotate it if real.\n${g.stderr}`);
    process.exit(2);
  }
  process.exit(0);
});
