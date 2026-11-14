---
name: ponytail-review
description: Reviews a change for correctness, security, real workload risks, missing tests, performance regressions, and unnecessary complexity. Use for focused diff or pull-request reviews.
---

# Ponytail change review

This skill complements FAES `code-review`: retain its correctness, security, privacy, data-integrity, and test priorities, while adding a deliberate simplicity/YAGNI pass. Review only; do not edit code unless the user asks for fixes.

## Scope and understanding
1. Review the target named by the user: working tree, staged diff, branch, pull request, or files. If unspecified, inspect uncommitted changes; if none, ask whether to review the last commit or another target.
2. Read the diff and relevant surrounding code, callers, callees, tests, fixtures, configuration, and documentation.
3. Trace input → processing → persistence/integrations → output for affected flows.
4. Infer expected load only from repository evidence; state assumptions and unknowns.

## Check in priority order
1. Incorrect behavior, crashes, edge cases, broken callers, compatibility.
2. Security, privacy, authorization, tenant isolation, secrets, injection, data loss, unsafe write ordering, missing transactions.
3. Concurrency and expected-load failures: races, unbounded memory, N+1 queries, repeated work, process-local state used across workers.
4. Risky changed logic without a focused test.
5. Material performance regressions supported by evidence.
6. Unnecessary code: dead code (only after searching references), unused options, duplicated helpers, new dependencies replacing native/existing capability, speculative abstractions, needless wrappers, unrelated refactors.

## Evidence rules
- Every finding needs a concrete input or operating condition and a real consequence.
- Re-check the relevant code and caller before reporting.
- Do not report style preference or speculative concerns as defects.
- A documented `shortcut:` limitation is not a finding unless actual requirements/load exceed it.
- Suggest the smallest safe fix; do not recommend removing safeguards.

## Output
Start with `What this change does:` in 2–3 plain-English sentences. Group numbered findings, omitting empty groups:
- **Must fix:** correctness, security, data loss, compatibility, or expected-load failures.
- **Should fix:** risky changed logic without tests, real performance issues, or meaningful unnecessary complexity.
- **Nice to have:** small optional simplifications.

Each finding includes: title and file/line; concrete scenario; impact; smallest safe fix. End with `Verdict: Ship.` or the specific findings to fix first, plus `Not checked:` for material checks that could not be performed. If no findings, state review scope and limitations; do not claim the code is perfect.
