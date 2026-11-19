# FAES 3.0.0 verification notes

Checks that were actually executed while building 3.0.0, and what was not.

## Executed and passed
- `node scripts/validate.mjs`: version consistency, 28 skill directories (frontmatter name = directory, indexed), integration JSON, hook JSON, internal Markdown links, hook-script copies identical, `SHA256SUMS.txt` matches every file.
- `security-audit` test suite: `validate-findings.test.cjs` and `validate-coverage-ledger.test.cjs` executed and passed on Windows (Node.js v24.19.0: 67 passed, 0 failures, 2 POSIX FIFO tests skipped).
- `faes-secret-guard.mjs`: detects AWS key IDs, GitHub tokens, and high-entropy credential assignments; ignores placeholders, `process.env` reads, and lines tagged `faes-secret-ignore`; output is redacted; the repository itself scans clean.
- Claude `pre-tool-use.js`: blocks `git commit` when a secret is staged (exit 2), passes non-git commands (exit 0), works from an installed `.claude/hooks/`.
- POSIX installers: workspace install (all 4 agents, `--agent all`), `--include-bla`, global install to a temporary directory, `--skip-global`, and selective uninstall preserving custom skills; `verify-installation.sh` (26 default skills; 27 with `--require-bla`). `bash -n` syntax check clean on all POSIX scripts in Ubuntu (WSL).
- Windows PowerShell installers: workspace install (all 4 agents, `-Agent all`), global install, `-SkipGlobal`, and selective uninstallation preserving custom skills verified live in native PowerShell on Windows.

## Not executed
- TruffleHog, `ocr`, and `bla-agents` were not run; their skills document the commands from the upstream READMEs at the pinned commits. Confirm flags against the installed version.
- Claude Code hook activation depends on merging `adapters/claude/hooks.json` into `.claude/settings.json`; this was not tested inside a live Claude Code session.
- Physical macOS hardware was not executed directly (Darwin compatibility is supported via standard POSIX open contracts).

## Known limits
- `faes-secret-guard.mjs` is heuristic and offline: it cannot validate that a credential is live and will miss many secret types TruffleHog detects.
- Its placeholder filter skips values containing words like "test" or "example", so a real secret containing such a word can be missed.
- **Windows input validation:** Node.js on Windows does not expose POSIX atomic `O_NOFOLLOW` / `O_NONBLOCK` open flags. Protection on Windows is provided via defense-in-depth: UNC/device namespace rejection (`\\`), DOS reserved component validation (`CON`, `PRN`, `AUX`, `NUL`, etc.), pre-open path inspection (`lstat`), path ancestry reparse-point verification, post-open file descriptor inspection (`fstat`), and handle-to-path identity matching (`dev` / `ino`).
- **POSIX FIFOs on Windows:** Windows does not support filesystem FIFOs (`mkfifo`); named pipes live under `\\.\pipe\` and are blocked by the UNC/device path rejection filter.
