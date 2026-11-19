#!/usr/bin/env node
// FAES Claude Code PreToolUse hook (Bash matcher).
// Blocks `git commit` / `git push` when staged changes contain likely secrets.
// Uses TruffleHog if installed, otherwise the bundled offline guard. Exit 2 blocks and tells Claude why.
'use strict';
const { spawnSync } = require('node:child_process');
const path = require('node:path');

let input = '';
process.stdin.on('data', (c) => (input += c));
process.stdin.on('end', () => {
  let cmd = '';
  try { cmd = String(JSON.parse(input || '{}').tool_input?.command ?? ''); } catch { process.exit(0); }
  if (!/\bgit\s+(commit|push)\b/.test(cmd)) process.exit(0);

  const th = spawnSync('trufflehog', ['git', 'file://.', '--since-commit', 'HEAD', '--results=verified,unknown', '--fail', '--no-update', '--trust-local-git-config'], { encoding: 'utf8' });
  if (!th.error) {
    if (th.status === 0) process.exit(0);
    process.stderr.write(`FAES secret guard (TruffleHog) blocked this command: findings or scan error.\n${(th.stdout || '') + (th.stderr || '')}\nRotate real credentials first, then remove them from code.\n`);
    process.exit(2);
  }
  const g = spawnSync(process.execPath, [path.join(__dirname, 'faes-secret-guard.mjs'), '--staged'], { encoding: 'utf8' });
  if (g.status === 0) process.exit(0);
  process.stderr.write(`FAES secret guard blocked this command.\n${g.stderr || g.stdout || ''}`);
  process.exit(g.status === 1 ? 2 : 0); // guard runtime errors do not block work
});
