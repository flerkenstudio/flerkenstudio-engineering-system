# Workflow: New project

1. **Discover**: confirm product idea, users, problem, constraints, target platforms, budget, team and launch scope.
2. **Clarify**: separate facts, assumptions, open questions and approved decisions. Ask only questions that materially affect scope or architecture.
3. **PRD**: draft goals, non-goals, user roles, journeys, requirements, acceptance criteria, metrics and risks.
4. **Stack selection**: compare viable options against team skills, ecosystem, cost, security, hosting, scale and maintainability. Do not default to one stack.
5. **Architecture**: define modules, trust boundaries, data flows, persistence, integrations, failure modes and deployment model.
6. **Data/API**: draft schema, constraints, migrations and API contracts. Review authorization and tenant isolation early.
7. **Plan**: break MVP into vertical slices with dependencies and testable outcomes.
8. **Scaffold**: create only approved structure and tooling. Keep secrets out of repo.
9. **Validate**: run a minimal end-to-end slice and CI checks.
10. **Handoff**: summarize decisions, assumptions, risks, next milestones and verification evidence.

Approval gates: PRD scope, architecture/stack, data model, and any paid infrastructure or external services.
