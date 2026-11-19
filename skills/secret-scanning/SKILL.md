---
name: secret-scanning
description: Detects, validates, and remediates leaked credentials in code, git history, CI, and config using TruffleHog as an external tool plus a zero-dependency fallback guard. Use before commits/releases, after a suspected leak, or when setting up secret scanning.
---

# Secret scanning

TruffleHog (https://github.com/trufflesecurity/trufflehog, AGPL-3.0) is used **only as an installed external binary or its official GitHub Action/Docker image**. FAES never vendors or copies TruffleHog source. If it is not installed, use the built-in fallback (`scripts/faes-secret-guard.mjs`) and say that coverage is reduced.

## When to use
- Before a commit, push, or release; when onboarding a repository; after a suspected leak.
- When adding CI or pre-commit protection.
- Do not use it to scan systems, buckets, chats, or accounts you are not authorized to scan.

## Workflow
1. **Scope:** confirm what is in scope (working tree, staged diff, full git history, a PR range) and that scanning is authorized.
2. **Pick the scan** (prefer the narrowest that answers the question):
   - Pre-commit (upstream-recommended; only for your own trusted repo): `trufflehog git file://. --since-commit HEAD --results=verified,unknown --fail --trust-local-git-config`
   - PR / CI range: `trufflehog git file://. --since-commit <base> --branch <head> --results=verified,unknown --fail`
   - Working tree files: `trufflehog filesystem <path> --results=verified,unknown`
   - Full history (slower): `trufflehog git file://. --results=verified,unknown`
3. **Fallback if the binary is absent:** `node scripts/faes-secret-guard.mjs --staged` (pattern-based, no network, no validation). Report that results are heuristic.
4. **Triage each finding:** `verified` = live credential (treat as an incident), `unknown` = could not be verified (investigate), `unverified` = pattern match only (likely false positive but check). Record detector, file, commit, and whether it is live.
5. **Remediate in this order:**
   1. **Revoke/rotate** the credential at the provider first. Removing it from git does not make it safe.
   2. Remove it from the working tree and load it from an environment variable or secret manager.
   3. Only then consider history rewrite (needs explicit user approval; coordinate with collaborators; it is destructive).
   4. Add prevention: `.gitignore` for env files, pre-commit hook, CI scan (see `workflows/secret-scanning.md`).
6. **Report:** scope, command run, counts by status, findings (without printing secret values), actions taken, residual risk.

## Safety rules
- Never print, log, or paste a full secret. Redact to the first 4 characters at most.
- `--results=verified` makes outbound requests to providers to test the credential. Say so, and do not use it on credentials you have no right to test.
- Local git config can be malicious: leave TruffleHog's default (clone before scan) enabled; use `--trust-local-git-config` only for trusted repositories.
- Do not commit `.env` files, key material, or scan output that contains secrets.
- Never claim a repository is "clean" from a partial scan; state exactly what was scanned.
