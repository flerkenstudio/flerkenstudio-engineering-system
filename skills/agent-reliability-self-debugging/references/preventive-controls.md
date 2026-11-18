# ARSD Preventive Controls

Use controls proportionate to the demonstrated failure. Do not introduce infrastructure or dependencies merely because they are listed here.

| Failure pattern | Preventive control | Verification signal | Common mistake to avoid |
|---|---|---|---|
| Test command waits indefinitely | Finite timeout at test, subprocess, and CI-job boundaries where supported | A stuck test fails within a documented bound and identifies the test | Assuming every runner has the same timeout feature installed |
| Unit tests depend on live services | Mock external boundaries; keep explicitly marked integration tests | Unit tests pass offline; integration tests report environment requirements | Skipping or deleting all integration tests |
| Retry loop hides a persistent failure | Bounded attempts, backoff, total deadline, and useful terminal error | Retry count and final cause are visible | Infinite retry or retrying non-idempotent writes blindly |
| Flaky shared test state | Isolated fixtures, unique temporary resources, deterministic clocks/randomness | Repeated and parallel runs do not share mutable state | Over-mocking the behavior being tested |
| Build output locked | Single build owner, process awareness, verified output cleanup procedure | No overlapping writer; repeatable clean build | Deleting generated directories while a process is active |
| Background task cancellation | Explicit lifecycle states, task IDs, logs, cancellation checks, idempotency/checkpoints where needed | Restart/resume behavior is tested and duplicates are detectable | Assuming tool cancellation killed every child process |
| Lost agent-session context | Persist concise task status, last completed step, command, logs, and next safe action | A fresh session can resume without guessing | Claiming invisible/background work continued |
| Poor observability | Structured logs, timestamps, correlation/task IDs, useful error context | Failure can be traced across command and process boundaries | Logging secrets or excessive private data |
| Environmental drift | Document runtime/tool versions and reproducible environment setup | Local and CI checks use documented entry points | Treating an environment workaround as a code fix |
| Recovery creates new risk | Reversible actions, backups for stateful changes, explicit approval gates | Recovery steps and rollback are testable | Disabling security controls or changing production state to get a green test |

## Operational guardrails

- Prefer one authoritative test/build process per working tree unless the tool explicitly supports concurrency.
- Keep unit, integration, and E2E test suites separately addressable.
- Mark network-dependent tests explicitly and document the service, credentials, and environment needed; do not put secrets in test output.
- Use unique temporary directories and reliable fixture/process cleanup.
- Make long-running work observable through progress, status, timestamps, and logs.
- Make retryable jobs idempotent before enabling automatic retries.
- Keep a short recovery runbook near the system it describes.
