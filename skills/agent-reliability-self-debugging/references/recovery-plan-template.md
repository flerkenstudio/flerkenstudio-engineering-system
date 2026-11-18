# ARSD Recovery Plan

## Objective

State what workflow or service must be restored and what must remain unchanged.

## 1. Containment

| Step | Preconditions | Action | Expected result | Safety/rollback note |
|---|---|---|---|---|
| | | | | |

## 2. Recovery

| Step | Action | Verification | Owner | Status |
|---|---|---|---|---|
| | | | | open |

## 3. Root-cause correction

| Proposed change | Files/components | Why this layer | Tests required | Risk |
|---|---|---|---|---|
| | | | | |

## 4. Prevention

- Bounded execution and cancellation:
- Test/environment isolation:
- Process/task ownership and lifecycle:
- Logging/observability:
- Regression coverage:
- Documentation/runbook:

## 5. Authorization boundary

- Changes that can be performed read-only:
- Changes requiring user approval:
- Production or data-impacting actions requiring explicit approval:

## 6. Rollback and recovery

- Rollback trigger:
- Rollback steps:
- Data/configuration backup required:
- Recovery verification:

## 7. Acceptance criteria

- [ ] Original failure mode can no longer reproduce under the defined test conditions.
- [ ] Relevant regression checks pass.
- [ ] No unrelated tests were removed or weakened.
- [ ] No production data or security boundary was altered unexpectedly.
- [ ] Commands, results, and limitations are recorded.
