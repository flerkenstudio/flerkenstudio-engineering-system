---
name: database-design
description: Designs relational or non-relational data models, constraints, indexes, migrations, and safe data operations.
---

# Database design

## Procedure
1. Gather domain entities, ownership, relationships, lifecycle, invariants, retention, and query patterns.
2. Identify data sensitivity and tenant boundaries.
3. Choose relational/document/key-value/search storage based on access patterns and consistency needs; justify the choice.
4. Define keys, constraints, nullability, uniqueness, deletion behavior, and timestamp semantics.
5. Use exact decimal/numeric representation for money and explicit currency.
6. Add indexes for known queries; estimate write overhead and avoid speculative indexing.
7. Define transactions and concurrency behavior for critical invariants.
8. Write migrations with safe rollout and rollback/recovery notes.
9. Use synthetic fixtures and test constraints, access control, and migration paths.

## Required output for a new schema
- Entity descriptions and relationships
- Table/collection definitions and constraints
- Index rationale tied to queries
- Migration sequence and rollback/recovery strategy
- Data classification, retention, and deletion notes
- Example queries for critical access patterns

Never execute destructive production migrations without explicit approval.
