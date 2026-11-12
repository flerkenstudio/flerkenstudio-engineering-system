# Database rules

- Identify entities, ownership, cardinality, lifecycle, invariants, and access patterns before schema design.
- Use primary keys, foreign keys, unique constraints, not-null constraints, and check constraints to enforce invariants where feasible.
- Define timestamp and timezone semantics explicitly; store instants consistently (commonly UTC) and convert at presentation boundaries.
- Use decimal/numeric types for money; never floating point for financial amounts.
- Index measured query patterns; consider write cost and selectivity.
- Use transactions for multi-step invariants; define isolation expectations for concurrency-sensitive operations.
- Make migrations repeatable and reviewable. Prefer expand/migrate/contract for zero-downtime changes.
- Never edit production data manually without an approved, auditable procedure and backup/restore plan.
- Define retention, deletion, archival, and privacy requirements.
- Use synthetic or anonymized data in development and tests.
