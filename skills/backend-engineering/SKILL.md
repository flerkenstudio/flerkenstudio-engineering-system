---
name: backend-engineering
description: Designs and implements backend services, business logic, authentication, integrations, and reliable server-side behavior.
---

# Backend engineering

## When to use
Use for server-side features, business rules, background jobs, authentication, integrations, performance, or backend refactoring.

## Procedure
1. Identify runtime, framework, module boundaries, API conventions, persistence layer, and existing error handling.
2. Trace the request from transport to domain logic to persistence/integrations.
3. Define acceptance criteria, authorization requirements, invariants, and failure behavior.
4. Keep controllers/handlers thin; put business rules in appropriate application/domain services following local conventions.
5. Validate request data at boundaries and return stable, non-sensitive error responses.
6. Apply authorization server-side; distinguish authentication from authorization.
7. Use transactions for related writes, idempotency for retried commands, and timeouts for external calls.
8. Avoid blocking operations in async paths and unbounded work/queues.
9. Add structured observability while redacting secrets and sensitive data.
10. Test success, validation, authorization, concurrency, dependency failure, and regression cases.

## Production checklist
- [ ] Authentication and authorization verified
- [ ] Input validation and output/error contract defined
- [ ] Database consistency and transaction behavior reviewed
- [ ] Timeouts, retries, idempotency and rate limits considered
- [ ] Secrets and PII protected
- [ ] Tests and operational signals added
- [ ] API compatibility assessed

Do not assume a particular language or framework. Follow the project's actual stack.
