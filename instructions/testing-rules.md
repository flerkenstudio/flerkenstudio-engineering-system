# Testing rules

- Derive tests from acceptance criteria, invariants, and failure modes.
- Unit-test pure domain logic; integration-test persistence, queues, external adapters, and API boundaries; use end-to-end tests for critical user journeys.
- Include positive, negative, boundary, authorization, tenant-isolation, and regression cases.
- Prefer deterministic tests; control time, randomness, network, and external dependencies.
- Avoid brittle tests coupled to implementation details.
- Do not mock the behavior that the test is intended to verify.
- Run focused tests after each change and the full relevant suite before completion.
- Report skipped/flaky tests honestly; do not hide failures or weaken assertions just to pass CI.
