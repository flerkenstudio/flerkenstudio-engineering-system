# Workflow: Bug fixing

1. Capture expected vs actual behavior, environment, steps to reproduce, frequency and impact.
2. Inspect logs/stack traces safely; redact secrets and personal data.
3. Reproduce with a minimal failing test or documented reproduction where practical.
4. Trace root cause rather than patching only the visible symptom.
5. Assess blast radius, data corruption, security impact and backward compatibility.
6. Implement a minimal fix and regression test.
7. Run focused tests and adjacent regression suites.
8. Review migration/backfill needs if existing data is affected; get approval before destructive repair.
9. Report root cause, fix, verification, affected versions and any manual recovery steps.
