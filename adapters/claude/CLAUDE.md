# Claude Code Engineering Guidelines (FAES v2.0.0)

This project follows the **FlerkenStudio AI Engineering System (FAES v2.0.0)** principles.

## Core Rules

1. **Think Before Coding:** Restate assumptions, scope, acceptance criteria, and risks before implementing non-trivial changes.
2. **Simplicity First (Ponytail):** Smallest complete solution over premature abstractions. Avoid speculative interfaces or configuration.
3. **Surgical Edits:** Keep changes focused on the requested outcome. Do not refactor unrelated code.
4. **Goal-Driven Verification:** Every change must have a verification step (unit test, integration test, or direct execution). Never claim an unrun test passed.
5. **Security & Boundary Validation:** Validate untrusted inputs, use parameterized queries, never expose secrets, and enforce server-side authorization.
6. **Zero-Slop UI Craft:** Respect existing design patterns. No unnecessary redesigns, gradients, or emoji badges.

## Skills

FAES skills are available under `.claude/skills/`. Reference specific skills when undertaking domain-specific work (`testing-qa`, `security-review`, `backend-engineering`, etc.).
