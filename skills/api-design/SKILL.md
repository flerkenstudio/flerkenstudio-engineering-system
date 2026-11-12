---
name: api-design
description: Designs consistent, secure, versionable HTTP or event-driven API contracts.
---

# API design

## Procedure
1. Identify consumers, use cases, authorization model, data sensitivity, and compatibility requirements.
2. Follow existing protocol and naming conventions.
3. Define resources/commands, request and response schemas, status/error semantics, pagination, filtering, and sorting.
4. Validate inputs server-side and return actionable but non-sensitive errors.
5. Enforce object-level and tenant-level authorization on every operation.
6. Use idempotency keys for retryable non-idempotent operations when appropriate.
7. Set payload limits, rate limits, timeouts, and upload constraints.
8. Document versioning, deprecation, and backward compatibility.
9. Add contract/integration tests for success, invalid input, permissions, concurrency, and errors.

## Deliverables
- Endpoint/event inventory
- OpenAPI or equivalent contract where appropriate
- Authentication and authorization matrix
- Example requests/responses and error model
- Pagination and idempotency behavior
- Compatibility and deprecation plan
