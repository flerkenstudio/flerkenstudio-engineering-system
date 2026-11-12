---
name: code-review
description: Reviews proposed code changes for correctness, maintainability, regressions, security, and test quality.
---

# Code review

## Review priorities
1. Correctness and user-visible behavior
2. Security, privacy, authorization and tenant isolation
3. Data integrity, migrations and concurrency
4. Reliability, failure handling and idempotency
5. Performance where supported by evidence
6. Maintainability, clarity and consistency
7. Test quality and coverage of changed behavior

## Procedure
- Read the task/acceptance criteria and inspect the diff in context.
- Trace affected call paths and data flows; inspect adjacent code only as needed.
- Look for bugs, not stylistic preferences. Respect repository conventions.
- Verify tests actually exercise behavior and include failure cases.
- Do not report speculative concerns as confirmed vulnerabilities.
- Do not modify code during a review unless asked to fix findings.

## Finding format
For each finding provide severity (Critical/High/Medium/Low/Informational), file and line, concrete scenario, impact, and recommended fix. Lead with actionable findings. If none are found, state review scope and remaining limitations rather than saying the code is perfect.
