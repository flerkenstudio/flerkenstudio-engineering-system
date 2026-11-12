---
name: devops-release
description: Plans CI/CD, environments, deployment, observability, rollback, and operational readiness.
---

# DevOps and release engineering

## Procedure
1. Inspect existing hosting, CI/CD, environments, infrastructure-as-code, and release process.
2. Define build artifacts, configuration, secrets, network boundaries, and environment parity.
3. Make builds reproducible and deployments traceable to commits/artifacts.
4. Separate configuration from code; never commit secrets.
5. Add health checks, readiness/liveness where relevant, logs, metrics, traces, and alerts proportionate to risk.
6. Plan database migrations using backward-compatible rollout where possible.
7. Define deployment strategy, smoke tests, rollback/roll-forward criteria, and recovery owner.
8. Verify backups and restore procedures for stateful systems.
9. Review cost, capacity, rate limits, and external dependency failure modes.

## Release gate
- [ ] CI checks pass
- [ ] Configuration and secrets reviewed
- [ ] Migration and rollback/recovery plan reviewed
- [ ] Monitoring and alerting adequate
- [ ] Smoke tests and rollback criteria defined
- [ ] Security and privacy review complete for sensitive changes
- [ ] Human approval obtained for production deployment

Never deploy or incur cloud spend without explicit authorization.
