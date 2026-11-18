---
name: agent-reliability-self-debugging
description: Use when an AI coding agent, command, test suite, build, background task, tool session, or development environment hangs, times out, is cancelled, fails intermittently, or needs structured failure capture, evidence-based root-cause analysis, safe recovery, verification, and prevention. Also use to prepare a reliability solution or post-incident review before implementation.
---

# Agent Reliability & Self-Debugging Protocol (ARSD)

## Mission

Diagnose and improve the reliability of agent-driven software engineering sessions. Coordinate evidence collection, root-cause analysis, safe containment, recovery, verification, and preventive engineering changes. ARSD is an orchestration skill; it complements rather than replaces FAES testing, DevOps, review, security, and Ponytail skills.

## Activate When

- A command, test, build, tool call, or background task stalls or times out.
- An agent session is cancelled, restarted, loses task state, or resumes with uncertain execution status.
- A failure is intermittent, environment-dependent, or crosses code, tooling, OS, network, and host boundaries.
- A user asks for an introspection report, debugging protocol, recovery plan, reliability design, or prevention strategy.
- Repeated failures are consuming engineering time or causing unreliable verification.

Do not use ARSD for ordinary feature implementation with no reliability symptom. Route ordinary test design to `testing-qa`, CI/deployment work to `devops-release`, and broad read-only repository inspection to `ponytail-audit` or `project-onboarding` as appropriate.

## Operating Rules

1. **Evidence before conclusions.** Separate observed facts, verified causes, plausible hypotheses, and unknowns. Never promote a hypothesis to a root cause without supporting evidence.
2. **Preserve state.** Capture the current diff, process/task identifiers, logs, command, working directory, branch, and last known good state before recovery.
3. **Contain before changing.** Stop or isolate only the specific task/process that is known to be stuck. Do not kill generic process names or terminate unrelated work.
4. **Bound every operation.** Prefer explicit timeouts, bounded retries, cancellation, progress reporting, and finite polling over indefinite waits.
5. **Use the smallest reversible action.** Prefer diagnosis and local containment before code changes, cleanup, dependency changes, permission changes, or environment changes.
6. **Protect security and data.** Do not disable antivirus, firewalls, sandboxing, TLS verification, access controls, or production safeguards as a routine workaround. Never expose secrets in reports.
7. **Do not hide failures.** Do not delete failing tests, weaken assertions, skip integration tests without a reason, or report an unrun check as passing.
8. **Get approval for material changes.** Before destructive cleanup, process termination with uncertain ownership, elevated permissions, production changes, data mutation, dependency upgrades, or deployment, explain the impact and obtain authorization.
9. **Honor the active FAES contract.** Read applicable `AGENTS.md` and project instructions. Use relevant FAES skills and preserve their constraints.

## ARSD Workflow

### 1. Intake and scope

- Restate the user-visible failure and the expected behavior.
- Identify the affected project, environment, agent host, command/tool, and time window.
- Determine whether the request is **investigation only**, **solution design**, **approved implementation**, or **post-incident review**.
- For a solution-design request, do not modify application code.

### 2. Capture the failure

Record, where available:

- Exact command or tool action, arguments, start/end time, exit code, and elapsed time.
- Working directory, branch, commit, working-tree status, runtime/tool versions, OS, and relevant environment mode.
- Complete relevant stdout/stderr and task/process identifiers.
- Last successful step and last known good state.
- Whether the failure is reproducible, intermittent, or observed once.
- Network, credentials, permissions, resource limits, and external dependencies only when verified and safe to disclose.

Redact tokens, passwords, cookies, connection strings, personal data, and private URLs. Use the [failure-capture template](references/failure-capture-template.md).

### 3. Classify and assess impact

Classify the failure across one or more boundaries:

- Application or code defect
- Test design, fixture, or test-runner behavior
- External service, network, DNS, proxy, or rate limit
- OS, filesystem, file lock, permissions, or resource exhaustion
- Process, job, queue, or background-task lifecycle
- Agent host, tool harness, session, or execution cancellation
- Configuration, dependency, or version mismatch

State impact and urgency. Treat possible data loss, credential exposure, security-control bypass, or production outage as high severity and stop unsafe experimentation.

### 4. Contain safely

- Preserve logs and state before stopping anything.
- Prefer a command-level timeout or targeted cancellation over broad process termination.
- Confirm process ownership and working directory before terminating a process.
- Do not start duplicate builds, migrations, jobs, or test runs while the original task may still be active.
- Keep integration tests available; isolate external dependencies with controlled mocks for unit tests and run true integration tests in an authorized environment.
- Avoid broad cache deletion. First identify the exact generated directory, owning process, and recovery impact.

### 5. Diagnose the root cause

For each hypothesis, document evidence for, evidence against, verification method, and confidence (`confirmed`, `probable`, or `unverified`). Trace the causal chain from trigger to failure; distinguish the immediate symptom from the underlying cause and contributing conditions.

Use the smallest safe reproduction. Inspect relevant source, configuration, fixtures, callers, process state, and logs. Do not infer that network isolation, antivirus locking, or agent-host cancellation is the cause merely because it is plausible.

Use the [root-cause analysis template](references/root-cause-analysis-template.md).

### 6. Design the recovery and permanent solution

Separate the plan into:

- **Containment:** stop ongoing waste or prevent further impact.
- **Recovery:** restore the affected development workflow safely.
- **Correction:** fix the confirmed cause at the right layer.
- **Prevention:** add bounded execution, isolation, observability, regression coverage, or lifecycle controls.

Rank actions by risk, reversibility, impact, and effort. Prefer existing project utilities and minimal dependencies. Assign each action an owner, acceptance criterion, and rollback/recovery note. Use the [recovery-plan template](references/recovery-plan-template.md).

### 7. Implement only within the authorized scope

If implementation is authorized:

- Load the relevant FAES skill(s): `testing-qa`, `devops-release`, `backend-engineering`, `security-review`, `code-review`, `ponytail`, or `ponytail-review`.
- Inspect affected callers, fixtures, configuration, and CI paths before shared changes.
- Make surgical changes; do not bundle unrelated cleanup.
- Keep normal tests, integration tests, and E2E tests distinct but discoverable.
- Preserve security boundaries and production behavior.

If implementation is not authorized, stop after the solution design and list the exact proposed files/changes without applying them.

### 8. Verify and close the incident

- Run the smallest relevant verification first, then progressively broader checks.
- Apply finite timeouts and report any timeout plugin/tooling prerequisites rather than assuming they exist.
- Run integration tests against mocks or controlled test services where appropriate; separately identify tests that require real external services.
- Verify recovery did not create duplicate processes, stale locks, data changes, or weakened security controls.
- Record exact commands, exit codes, elapsed time, pass/fail/skip counts, environment, and unrun checks.
- Mark each finding as `open`, `contained`, `resolved`, or `prevented`.
- Add a regression test or operational guard when justified; do not create generic framework code without a demonstrated need.

Use the [verification template](references/verification-template.md) and review [preventive controls](references/preventive-controls.md).

## Failure-Family Guidance

### Tests that hang

Inspect test collection, fixtures, external HTTP calls, retry loops, subprocesses, waits, and teardown behavior. Identify the exact test or fixture that blocks. Mock external boundaries for deterministic unit tests, but retain separately marked integration tests with explicit environment requirements and finite timeouts. A broad `pytest` run is not automatically wrong; establish why it is blocked before narrowing the run permanently.

### Build or filesystem errors

For errors such as `EPERM`, `EACCES`, or file-lock failures, inspect the exact path, active build/dev processes, permissions, open handles, available disk space, and relevant OS diagnostics. Treat antivirus/file-watcher interference as a hypothesis until verified. Do not repeatedly delete build output while another process may own it.

### Background tasks or agent sessions cancelled

Distinguish a task cancelled by the agent host from a child process that may still be running. Check task status, process tree, logs, output timestamps, and side effects before retrying. For long-running application jobs, use idempotency, checkpoints, explicit states, and safe resume semantics where the application requires them. Do not claim a cancelled tool task continues in the background unless verified.

## Required Output

For any non-trivial ARSD task, provide:

1. **Executive summary** — what failed and current state.
2. **Failure record** — exact commands/actions and last known good step.
3. **Classification and impact** — affected boundary and severity.
4. **Evidence table** — facts, hypotheses, confidence, and missing evidence.
5. **Root-cause statement** — confirmed cause or explicitly unresolved hypotheses.
6. **Recovery plan** — containment, recovery, correction, and rollback.
7. **Verification plan/results** — exact commands and observed outcomes.
8. **Prevention backlog** — minimal controls, regression tests, owners, and acceptance criteria.
9. **Limitations** — what was not run, not inspected, or not proven.

Do not report success solely because a focused test passes if the original failure mode remains unverified. Do not say that a failure is permanently fixed until the relevant reproduction or regression check demonstrates it.

## FAES Skill Coordination

- `project-onboarding`: orient in an unfamiliar repository before diagnosing.
- `ponytail-audit`: perform a read-only repository risk audit when broader inspection is needed.
- `testing-qa`: design and execute deterministic test coverage.
- `devops-release`: address CI, environments, build/release operations, and observability.
- `backend-engineering`: correct application jobs, API integrations, retries, or lifecycle logic.
- `security-review`: review permissions, secrets, network controls, and sensitive recovery actions.
- `code-review` and `ponytail-review`: review the final diff and complexity.
- `karpathy-guidelines` and `ponytail`: keep the correction minimal and evidence-driven.

ARSD owns the cross-boundary incident workflow and final reliability report. The specialist skill owns the detailed implementation in its domain.
