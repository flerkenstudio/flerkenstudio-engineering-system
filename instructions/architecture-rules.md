# Architecture rules

1. Discover the current architecture before proposing a new one.
2. Prefer a modular monolith for early products unless scale, team boundaries, or independent deployment justify services.
3. Separate domain/business rules from framework and transport details when that separation reduces coupling.
4. Define module ownership and dependency direction; avoid cyclic dependencies.
5. Keep APIs explicit and version changes deliberately.
6. Model synchronous and asynchronous workflows, retries, timeouts, idempotency, and partial failure.
7. Document major decisions as ADRs with context, options, decision, consequences, and status.
8. Design for operability: structured logs, metrics, traces where appropriate, health checks, and runbooks.
9. Avoid claiming scalability without workload assumptions, bottleneck analysis, and evidence.
10. Choose technology based on product constraints, team capability, operational cost, ecosystem maturity, and security—not fashion.
