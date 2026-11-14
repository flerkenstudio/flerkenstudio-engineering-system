---
name: ponytail-audit
description: Performs a read-only, risk-ranked audit of a whole repository for correctness, security, scale, test gaps, performance, and unnecessary complexity.
---

# Ponytail repository audit

Perform a read-only audit. Do not change files, install dependencies, run destructive commands, or expose secrets.

## Map the repository
1. Read README, manifests, dependency lists, build/deploy configuration, entry points, routes/handlers/jobs/CLI commands, and tests.
2. Identify runtime, architecture, persistence, integrations, authentication, and operational assumptions from evidence.
3. Trace critical end-to-end flows, prioritizing user input, money, authentication/authorization, tenant boundaries, file handling, external calls, and data writes.
4. State the expected workload assumption. If the repository is large, go deepest where failure has the greatest impact and name areas not inspected.

## Audit priorities
1. Bugs and edge cases: empty/zero/boundary values, rounding, time zones, inconsistent rules, broken callers.
2. Security and data integrity: injection, weak randomness, secrets, missing authorization, swallowed errors, unsafe write order, missing transaction/backup/recovery.
3. Scale and concurrency: races, per-process state, unbounded growth, N+1 queries, repeated work, unsuitable algorithmic complexity.
4. Missing tests for risky logic: branches, parsers, money, security, data writes, concurrency.
5. Material performance problems; do not speculate without evidence.
6. Complexity: dead code (after reference search), unused config/flags, duplicate helpers, avoidable dependencies, one-implementation interfaces, pass-through wrappers, speculative features, functions/classes mixing unrelated jobs.

## Evidence rules
- Every finding needs a concrete scenario, impact, and location.
- Search the whole relevant tree, including tests, fixtures, configuration, and dynamic/string references, before calling code unused.
- Distinguish confirmed findings, assumptions, and unknowns.
- Do not flag documented shortcuts unless the stated limit is already exceeded.
- Never recommend cutting validation, security, accessibility, data-loss protection, or required behavior for brevity.

## Report
Start with `What this repo does:` and the workload assumption. Group numbered findings into **Must fix**, **Should fix**, and **Nice to have**. Include at most 20 findings; say how many lower-priority findings were omitted. Each finding needs location, scenario, impact, and smallest safe fix. End with a one-line verdict, any evidence-based simplification estimate (only if countable), and `Not checked:`. If no findings, state exactly what was inspected and that the audit is not a guarantee of defect-free software.
