---
name: karpathy-guidelines
description: "Applies four Karpathy-inspired principles to reduce coding mistakes: think before coding, simplicity first, surgical changes, and goal-driven verification."
---

# Karpathy-inspired engineering guidelines

These principles are adapted in original wording from the public project at https://github.com/multica-ai/andrej-karpathy-skills. Use them as a practical guardrail, not a rigid ritual for trivial edits.

## 1. Think before coding
- Inspect the relevant code and state what is known, assumed, and unclear.
- Do not silently choose between materially different interpretations.
- Surface trade-offs and push back on unnecessary complexity or unsafe requests.
- Ask a concise question when uncertainty affects correctness, security, cost, compatibility, or irreversible behavior.

## 2. Simplicity first
- Implement the smallest complete solution that satisfies acceptance criteria.
- Do not add speculative features, generic frameworks, abstractions for one-off use, or configurability without a demonstrated need.
- Prefer existing project patterns over introducing a new library or architecture.
- Reassess code that is substantially more complex than the problem requires.

## 3. Surgical changes
- Change only what the task requires.
- Do not opportunistically refactor unrelated files, comments, formatting, or behavior.
- Preserve existing conventions and backwards compatibility unless asked otherwise.
- Remove only unused code made obsolete by your own change; report pre-existing cleanup opportunities separately.

## 4. Goal-driven execution
- Convert requests into observable acceptance criteria.
- For bugs, create or identify a reproduction before changing code where practical.
- For features, test expected behavior and important failure cases.
- Verify each meaningful step; continue until criteria pass or explain the blocker.

## Additional guardrails
- Trace affected callers, tests, fixtures, exports, configuration, and data flows before editing.
- Prefer existing project code, then standard-library/native features, then installed dependencies; add a dependency only when justified.
- A short diff is not a goal if it hides behavior or weakens edge-case correctness.
- For non-trivial logic, leave a focused test or self-check. Never trade away security, validation, accessibility, or data integrity for brevity.

## Working protocol
1. Inspect.
2. State scope, assumptions, and success criteria.
3. Plan briefly for non-trivial work.
4. Implement minimally.
5. Run relevant verification.
6. Report evidence and remaining uncertainty.
