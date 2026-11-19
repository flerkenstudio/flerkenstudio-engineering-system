# Workflow: Secret scanning

1. Confirm authorization and scope: staged diff, working tree, PR range, or full history.
2. Run `secret-scanning`: TruffleHog if installed, else `scripts/faes-secret-guard.mjs --staged`.
3. Classify each result: verified (live), unknown, unverified. Never print full secret values.
4. **Revoke or rotate first.** Then remove from code and load from env/secret manager.
5. Rewrite git history only with explicit approval; it is destructive and affects collaborators.
6. Add prevention: pre-commit hook (`templates/project-starter/.pre-commit-config.yaml`) and CI (`templates/project-starter/.github/workflows/secret-scan.yml`).
7. Report exactly what was scanned, the command, counts by status, actions taken, and residual risk.
