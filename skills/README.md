# FAES skills index — v3.0.0

## Core Engineering Skills

| Skill | Use when |
|---|---|
| `karpathy-guidelines` | Any non-trivial task; manage assumptions, simplicity, surgical changes, and goal-driven verification |
| `ponytail` | Implementing or changing code with a simplicity-first/YAGNI pass |
| `ponytail-review` | Reviewing a diff with correctness, risk, tests, and complexity priorities; complements `code-review` |
| `ponytail-audit` | Read-only risk and complexity audit of a repository |
| `ponytail-debt` | Inventorying documented `shortcut:` / `ponytail:` limitations |
| `ponytail-gain` | Reporting measured impact from real before/after data |
| `ponytail-help` | Explaining available FAES modes and host-specific usage |
| `backend-engineering` | Server-side code, APIs, jobs, integrations |
| `frontend-engineering` | UI, client state, accessibility, responsive design |
| `database-design` | Schema, queries, indexes, migrations |
| `api-design` | HTTP/event contracts and compatibility |
| `security-review` | Sensitive changes or security assessment |
| `testing-qa` | Test planning and verification |
| `code-review` | General correctness/security review of diffs and PRs |
| `product-requirements` | Turning an idea into a testable PRD |
| `devops-release` | CI/CD, deployment, operations |
| `performance-engineering` | Measured performance diagnosis/optimization |
| `project-onboarding` | Read-only discovery of an unfamiliar repository |
| `agent-reliability-self-debugging` | Hangs, timeouts, flaky tests/builds, or failed agent tasks: structured failure capture, root cause, safe recovery |

## Design Engineering Skills (v2.0.0)

| Skill | Use when |
|---|---|
| `design-review` | Evaluating UI/UX against professional visual, ergonomic, and brand standards |
| `visual-qa` | Inspecting rendered UI output across viewports, themes, and states |
| `design-system` | Guiding design tokens, atomic component architecture, and UI libraries |
| `accessibility-review` | WCAG 2.2 compliance verification (24×24px AA mandatory, 44×44px AAA preferred) |

## Security & Review Skills (v3.0.0)

| Skill | Use when |
|---|---|
| `secret-scanning` | Leaked-credential detection and remediation (TruffleHog external tool + offline fallback); before commits/releases |
| `security-audit` | Full six-phase, source-first security audit or pen-test (vendored from Cloudflare, MIT); explicit requests only |
| `code-review-ocr` | Optional second-opinion review with Alibaba's Open Code Review CLI, merged with `code-review` |

## Optional Integrations

| Skill | Use when |
|---|---|
| `unslop` | Optional upstream design cleanup and typography refinement (Damir Sokolovsky, CC BY 4.0) |
| `release-hardening` | Optional hardening of your own release artifacts against AI reverse engineering using BLA (MIT); opt-in with `--include-bla` |

Each skill is an independent Agent Skills-compatible directory containing `SKILL.md` with YAML frontmatter.
