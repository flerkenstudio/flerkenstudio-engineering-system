# Workflow: Security audit

Pick the depth that matches the request. Do not run a full audit for a small question.

| Request | Use |
|---|---|
| Review a diff or PR for security | `security-review` |
| Check for leaked credentials | `secret-scanning` |
| Full / comprehensive / end-to-end audit, pen-test, or report artifacts | `security-audit` (6-phase, source-first) |
| Hardening a release you own | `release-hardening` (optional) after the above |

Full audit sequence:
1. Run `secret-scanning` on the target first; secrets found change severity and scope.
2. Run `security-audit` in full audit mode. Output goes outside the target repository.
3. Run its validators (`validate-coverage-ledger.cjs`, `validate-findings.cjs`) as the skill instructs.
4. Triage `confirmed`, `needs_validation`, and `rejected` separately; never promote `needs_validation` to a finding without evidence.
5. Fix in small, reviewed changes; re-run the relevant phase on changed source.
6. Run only inside an OS-enforced sandbox if target code must be executed; otherwise report the blocker.
