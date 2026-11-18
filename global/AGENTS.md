# FlerkenStudio Global Engineering Defaults

These are cross-project defaults. Project-level `AGENTS.md` and explicit user-approved decisions provide product-specific detail.

- Inspect the repository and detect its actual stack before acting.
- Think before coding: surface material assumptions and ask when ambiguity affects outcomes.
- Prefer the simplest complete implementation and make surgical changes.
- Follow existing project conventions; do not force a preferred framework or architecture.
- Validate untrusted inputs and enforce authorization server-side.
- Never commit, reveal, or log secrets or unnecessary personal data.
- Do not run destructive production operations, deploy, publish, or incur paid costs without explicit authorization.
- Test changed behavior and report exact commands/results; never claim unrun checks passed.
- Report uncertainty, security implications, migrations, and remaining risks honestly.

- Prefer existing project helpers, native platform features, and already-installed dependencies before adding new dependencies.
- Trace affected callers, tests, fixtures, exports, and configuration before changing shared behavior.
- Avoid speculative features, wrappers, abstractions, and configurability without a demonstrated requirement.
- Keep a change small but complete; never cut trust-boundary validation, security, accessibility, data-loss protection, or requested behavior.
- For non-trivial new logic, add a focused test or self-check; report any meaningful checks not run.
- For non-trivial coding, combine `karpathy-guidelines` and `ponytail` when available; use domain skills only when relevant.
- For reviews, `code-review` is the broad review and `ponytail-review` adds a simplicity/YAGNI pass; avoid duplicate findings.
- For frontend/UI tasks, apply the FAES Design Engineering suite (`design-review`, `visual-qa`, `design-system`, `accessibility-review`). Enforce Zero-Slop / No-Op safeguard, WCAG 2.2 target sizes (24×24px AA mandatory SC 2.5.8 vs 44×44px AAA preferred SC 2.5.5), and preserve business logic and event handlers.


## FAES + ECC coordination

FAES is the global source of engineering standards. ECC may provide a global Antigravity plugin/hook runtime and optional project-local capabilities when installed through its official adapters. The global adapter is experimental; verify it in a disposable workspace. Do not hand-copy hook configuration or install project-local hooks on top of the global runtime. Project-specific ECC components must not override FAES security, testing, simplicity, or user-approval requirements.


## Optional Unslop Integration

Unslop (by Damir Sokolovsky, CC BY 4.0, pinned commit `620163eedb3529d9cd23a3994ed8d287d06f760d`) is an optional design refinement skill. Core FAES operates independently. Maintain upstream attribution and the Zero-Slop / No-Op safeguard.
