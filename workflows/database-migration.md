# Workflow: Database migration

1. Identify affected entities, data volume, constraints, consumers and invariants.
2. Classify operation as additive, backfill, contract, destructive or data repair.
3. Prefer expand/migrate/contract for live systems: add compatible schema, deploy compatible code, backfill safely, verify, then remove obsolete schema in a later release.
4. Define batching, throttling, checkpointing, idempotency, lock duration and monitoring for backfills.
5. Provide forward migration and rollback/roll-forward recovery plan.
6. Test against representative synthetic data and supported database versions.
7. Review backups and restore point before production changes.
8. Obtain explicit approval before production execution or irreversible data changes.
9. Verify row counts, constraints, application behavior and performance after migration.
