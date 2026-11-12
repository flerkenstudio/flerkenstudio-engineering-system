---
name: testing-qa
description: Creates test strategies and verifies behavior through unit, integration, end-to-end, and regression tests.
---

# Testing and QA

## Procedure
1. Translate requirements into observable acceptance criteria.
2. Identify critical paths, invariants, boundaries, roles, tenants, and failure modes.
3. Select the right level: unit for isolated logic, integration for boundaries, end-to-end for critical user journeys.
4. Prefer deterministic fixtures and controlled clocks/randomness.
5. Cover happy path, invalid input, empty/boundary values, authorization, concurrency, retries, and regressions.
6. Avoid tests that merely duplicate implementation details or mock the behavior under test.
7. Run focused tests first, then relevant full suites, lint, type checks, and build.
8. Report exact commands, pass/fail/skip counts, and environmental limitations.

## Test plan output
- Requirement-to-test mapping
- Test layers and tools
- Fixtures and setup
- Negative and edge cases
- Execution results
- Known gaps and risk

Never weaken an assertion or delete a failing test simply to get a green run without explaining and approving the behavior change.
