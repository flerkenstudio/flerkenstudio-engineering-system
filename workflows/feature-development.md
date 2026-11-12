# Workflow: Feature development

1. Read the issue/PRD and relevant project instructions/skills.
2. Inspect affected code, tests, API contracts, schema, and history as needed.
3. Write observable acceptance criteria and identify security/data invariants.
4. Identify the smallest vertical slice and propose a concise plan.
5. Add or update tests for expected behavior and key failure cases.
6. Implement the minimum change, following existing patterns.
7. Review diff for unrelated changes, secrets, compatibility, accessibility and error handling.
8. Run focused tests, then relevant lint/typecheck/build/full suite.
9. Update docs/migrations/release notes when needed.
10. Report changed files, commands/results, risks and manual verification still required.

Do not deploy or perform destructive data changes as part of this workflow without explicit approval.
