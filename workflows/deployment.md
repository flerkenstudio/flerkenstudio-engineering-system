# Workflow: Production deployment

1. Confirm release scope, commit/artifact, environment and explicit deployment authorization.
2. Verify CI, tests, build, dependency/security checks and approvals.
3. Review environment configuration and secret references without printing values.
4. Review database migrations and backward compatibility.
5. Confirm backups, restore capability, health checks, dashboards, alerts and runbook.
6. Define deployment strategy (rolling/canary/blue-green) and stop/rollback criteria.
7. Deploy only through approved pipeline; do not improvise production commands.
8. Run smoke tests and monitor error rate, latency, saturation and key business flows.
9. Roll back or roll forward according to approved criteria; preserve evidence.
10. Record release outcome, incidents, follow-up tasks and owner.
