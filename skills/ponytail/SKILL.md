---
name: ponytail
description: Applies a simplicity-first engineering mode to coding, bug fixes, refactors, and dependency choices. Use when asked for the simplest solution, less code, YAGNI, or Ponytail principles.
argument-hint: "[lite|full|ultra|off]"
---

# Ponytail — simplicity-first engineering

Use the smallest complete solution that meets the user's requirements. Be economical with code, never careless with correctness. This skill complements `karpathy-guidelines`; it does not replace FAES security, architecture, testing, or product rules.

## Modes
- **lite:** Implement the requested scope. Briefly mention a simpler alternative only if it materially matters.
- **full (default):** Apply the complete workflow below.
- **ultra:** Before implementation, challenge unnecessary scope and propose a smaller option. Do not silently remove user-requested requirements; obtain approval for material scope reductions.
- **off:** Do not apply this optional simplicity mode for the current task; all FAES safety, security, and quality requirements still apply.

Treat a mode as applying to the current task/session only where the host supports that behavior. Do not claim persistent mode state or lifecycle hooks unless the host actually provides them.

## Before editing
1. Read the task and inspect the relevant implementation.
2. Trace affected callers, tests, fixtures, configuration, exports, and data flows.
3. Identify what could break, be exposed, or be lost.
4. State material assumptions and acceptance criteria; ask if ambiguity changes correctness, security, cost, compatibility, or irreversible behavior.

## Choose the smallest complete solution
Use the first option that fully meets the requirements:
1. Omit features, options, and flexibility nobody requested.
2. Reuse an existing helper, component, service, or project convention.
3. Prefer standard-library or native platform capability when it fits the existing project.
4. Reuse an installed dependency; do not add a dependency for a few lines of ordinary functionality.
5. Otherwise implement the minimum clear, maintainable code that works.

- Do not create one-use abstractions, pass-through wrappers, speculative factories, generic frameworks, or configuration for hypothetical future needs.
- Preserve the existing architecture and interfaces unless change is necessary and approved.
- Prefer deletion over addition only when behavior and safety remain intact.
- Do not compress code into cryptic one-liners. Readability and edge-case correctness beat line count.
- Bug fix: find all callers and address the root cause at the appropriate shared layer.
- When moving or merging code, preserve its validation and error handling.
- Between equally small options, choose the one with safer edge-case behavior.
- A non-trivial new branch, loop, parser, money/security/data-write path, or new script/app needs a focused test or self-check. Trivial edits may not need one.
- A known, accepted limitation may be marked `shortcut: <limitation>, <when to upgrade>`. This is not permission to defer security, data integrity, or explicitly requested behavior.

## Never cut
Trust-boundary validation, authorization, security, accessibility, error handling that prevents data loss, reliability required by the task, or any user-approved requirement.

## Finish
Verify the acceptance criteria. Report what was implemented, what was deliberately omitted, checks actually run, checks not run, and material remaining risks. Never claim measured code/time/cost savings without before/after evidence.
