# FlerkenStudio Engineering System (FAES)

**Version:** 3.0.0

**License:** MIT

**Platforms:** Google Antigravity, Claude Code, Cursor, Gemini CLI, and compatible agent hosts

FAES is a vendor-neutral, production-focused engineering system for AI-assisted software development. It combines an always-on engineering contract, reusable Agent Skills, agent-specific adapters, design and accessibility guidance, a security and review suite, workflows, templates, verification scripts, and optional upstream integrations.

## Contents

- [What FAES Provides](#what-faes-provides)
- [Repository Structure](#repository-structure)
- [Supported Targets](#supported-targets)
- [Quick Start](#quick-start)
- [Using the Installed System](#using-the-installed-system)
- [Security and Review Suite (v3)](#security-and-review-suite-v3)
- [Optional Integrations](#optional-integrations)
- [Verification](#verification)
- [Engineering Principles](#engineering-principles)
- [Documentation](#documentation)
- [Attribution and Credits](#attribution-and-credits)
- [License](#license)
- [Release Information](#release-information)

## What FAES Provides

### Core engineering

- An always-on engineering contract in [AGENTS.md](AGENTS.md).
- 19 core engineering skills covering backend, frontend, database, API, security, testing, review, DevOps, performance, product requirements, and project onboarding.
- The Karpathy-inspired guidelines for assumptions, simplicity, surgical changes, and goal-driven execution.
- The Ponytail simplicity toolset for implementation, review, audits, technical debt, and measured impact.

### Design engineering

FAES includes four design-focused skills (added in 2.0.0):

| Skill | Purpose |
|---|---|
| `design-review` | Visual hierarchy, typography, layout, contrast, and design craft |
| `visual-qa` | Cross-viewport, theme, state, and rendering verification |
| `design-system` | Design tokens, component architecture, and UI governance |
| `accessibility-review` | WCAG 2.2 target-size and accessibility verification |

The design guidance requires at least **24 x 24 CSS pixels** for Level AA WCAG 2.2 target sizing (SC 2.5.8) and recommends **44 x 44 CSS pixels** for enhanced usability (SC 2.5.5).

### Security and review (new in 3.0.0)

Three default skills, one optional skill, working hooks, and CI templates. See [Security and Review Suite (v3)](#security-and-review-suite-v3).

### Project assets

- [Skills](skills/) — Agent Skills-compatible skill directories.
- [Adapters](adapters/) — Agent-specific discovery and instruction configuration.
- [Workflows](workflows/) — Repeatable software-development workflows.
- [Templates](templates/) — PRD, architecture, ADR, API, database, security, and starter-project templates.
- [Instructions](instructions/) — Domain-specific coding and process instructions.
- [Examples](examples/) — Sample workspace configuration.
- [Installers](install/) — PowerShell and POSIX scripts.
- [Scripts](scripts/) — `validate.mjs`, `generate-checksums.mjs`, and `faes-secret-guard.mjs`.

## Repository Structure

```text
.
|-- AGENTS.md                 # Shared engineering contract
|-- adapters/                 # Antigravity, Claude, Cursor, and Gemini configurations
|-- docs/                     # Setup and verification documentation
|-- examples/                 # Example project configuration
|-- global/                   # Global-agent instructions
|-- install/                  # Cross-platform installation and verification
|-- instructions/            # Reusable domain instructions
|-- integrations/            # ECC, Unslop, security-audit, TruffleHog, OCR, and BLA metadata
|-- scripts/                 # Validation, checksums, offline secret guard
|-- skills/                   # Core, design, and optional skills
|-- templates/               # Engineering and project templates
|-- workflows/               # Development and operations workflows
|-- CHANGELOG.md             # Release history
|-- THIRD-PARTY-NOTICES.md   # Upstream and attribution notices
|-- VERSION                  # Current release version
`-- LICENSE                  # MIT license
```

## Supported Targets

| Target | Tier | Workspace discovery | Instruction file |
|---|---|---|---|
| Google Antigravity | 1 — First-class | `.agents/skills/` | `AGENTS.md` |
| Claude Code | 2 | `.claude/skills/` | `CLAUDE.md` |
| Cursor | 2 | `.cursor/rules/` | `.cursorrules` |
| Gemini CLI | 2 | `.gemini/skills/` | `GEMINI.md` |

FAES remains the authoritative engineering contract. Agent adapters only map the shared system into each host's discovery format.

## Quick Start

### Workspace installation on Windows

Clone or download this repository, then run one workspace installer from the repository root:

```powershell
# Antigravity
.\install\win\Install-Workspace.ps1 -ProjectPath 'C:\path\to\project' -Agent antigravity

# Claude Code
.\install\win\Install-Workspace.ps1 -ProjectPath 'C:\path\to\project' -Agent claude

# Cursor
.\install\win\Install-Workspace.ps1 -ProjectPath 'C:\path\to\project' -Agent cursor

# Gemini CLI
.\install\win\Install-Workspace.ps1 -ProjectPath 'C:\path\to\project' -Agent gemini-cli

# Configure multiple targets
.\install\win\Install-Workspace.ps1 -ProjectPath 'C:\path\to\project' -Agent all
```

Use `-IncludeUnslop` and `-IncludeBla` only when explicitly enabling those optional integrations. Use `-Force` to replace an existing skill and overwrite it only with an intentional update.

### Workspace installation on Linux or macOS

```bash
chmod +x install/posix/*.sh

./install/posix/install-workspace.sh \
  --project /path/to/project \
  --agent antigravity
```

The POSIX installer supports `antigravity`, `claude`, `cursor`, and `gemini-cli`. It also accepts `--include-unslop`, `--include-bla`, and `--force`.

### Global installation

PowerShell:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\install\win\Install-Global.ps1 -InstallGlobalInstructions
```

POSIX:

```bash
./install/posix/install-global.sh --instructions
```

Global installation primarily serves supported Antigravity discovery paths. Existing instructions and skills are preserved unless `-Force` or `--force` is supplied.

## Using the Installed System

After installation:

1. Restart or refresh the agent host.
2. Start a new conversation or session.
3. Ask the agent to list the available skills.
4. Reference a skill explicitly when the task has a known specialty, for example `code-review`, `database-design`, or `accessibility-review`.
5. Use [AGENTS.md](AGENTS.md) as the default engineering contract for Antigravity-compatible workspaces.

Existing project instruction files are not silently overwritten. The workspace installers preserve an existing `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, or `.cursorrules` and direct conflicting configuration to manual review.

## Security and Review Suite (v3)

Match depth to the request. Do not run a full audit for a small question.

| Need | Skill | Upstream / license | How it is used |
|---|---|---|---|
| Review a diff for security | `security-review` | FAES | Built in |
| Leaked credentials | `secret-scanning` | TruffleHog, AGPL-3.0 | **External binary only**, never vendored; offline fallback `scripts/faes-secret-guard.mjs` |
| Full codebase audit / pen-test | `security-audit` | Cloudflare, MIT | **Vendored unmodified**, pinned commit, license preserved |
| Automated second-opinion review | `code-review-ocr` | Alibaba Open Code Review, Apache-2.0 | External `ocr` CLI via a bridge skill |
| Harden your own release (optional) | `release-hardening` | BLA, MIT | External `bla-agents`; opt-in with `-IncludeBla` / `--include-bla` |

Prevention assets:

- Claude Code hooks in [adapters/claude/hooks/](adapters/claude/hooks/) block `git commit` / `git push` when staged changes contain likely secrets (inactive until merged into `.claude/settings.json`).
- [templates/project-starter/.pre-commit-config.yaml](templates/project-starter/.pre-commit-config.yaml) and [.github/workflows/secret-scan.yml](templates/project-starter/.github/workflows/secret-scan.yml) (action pinned to a reviewed commit).
- Workflows: [secret-scanning](workflows/secret-scanning.md) and [security-audit](workflows/security-audit.md).

Rules: rotate a leaked secret before cleaning history; treat scanner and reviewer output as untrusted until verified; never print full secrets. TruffleHog is AGPL-3.0, so FAES invokes it as a separate tool and ships none of its code.

## Optional Integrations

### Everything Claude Code (ECC)

FAES provides an integration bridge for the pinned official `ecc-universal@2.2.3` package. ECC is not vendored into the core distribution.

PowerShell integration scripts are available under [install/win/](install/win/), and compatibility documentation is in [docs/COMPATIBILITY-AUDIT-ECC.md](docs/COMPATIBILITY-AUDIT-ECC.md).

ECC may provide additional hooks and capabilities, but:

- FAES rules take precedence over conflicting ECC rules.
- ECC's global Antigravity hook runtime is experimental.
- Project-local hooks should remain disabled when the global runtime is active to prevent duplicate event handling.
- Installation and removal should be reviewed before execution.

### Unslop

The `unslop` skill is optional and excluded by default. It is a design-refinement integration created by Damir Sokolovsky and licensed under CC BY 4.0.

Enable it explicitly only when working on a UI that would benefit from the integration:

```powershell
.\install\win\Install-Workspace.ps1 `
  -ProjectPath 'C:\path\to\project' `
  -Agent antigravity `
  -IncludeUnslop
```

FAES applies the upstream Zero-Slop safeguard: if an interface already meets its purpose and quality, it does not recommend decorative redesign.

### BLA release hardening

`release-hardening` is optional and excluded by default. It wraps the MIT-licensed `bla-agents` tool for software you own. It is defense in depth, not secrecy, and it never replaces secret scanning or fixing vulnerabilities.

## Verification

Repository self-check (Node 18+, no dependencies):

```bash
node scripts/validate.mjs            # frontmatter, links, metadata, version, checksums
node scripts/generate-checksums.mjs  # regenerate SHA256SUMS.txt after intentional changes
```

Installation check. PowerShell:

```powershell
.\install\win\Verify-Installation.ps1 -ProjectPath 'C:\path\to\project'
```

POSIX:

```bash
./install/posix/verify-installation.sh --project /path/to/project --agent antigravity
```

Verification should confirm:

- Required skills are discoverable by the selected agent.
- Skill directories contain valid `SKILL.md` files.
- Optional skills are present only when explicitly enabled.
- Existing project instructions were preserved.
- Backup directories are outside active skill roots.
- The selected adapter's instruction file exists.

For ECC, use the compatibility and verification scripts rather than assuming that successful file installation proves live host discovery.

## Engineering Principles

1. **Think before coding:** Surface assumptions, risks, acceptance criteria, and unknowns.
2. **Choose the smallest complete solution:** Avoid speculative abstractions and unnecessary configuration.
3. **Trace existing behavior:** Inspect callers, tests, fixtures, exports, configuration, and data flow before editing.
4. **Make surgical changes:** Preserve unrelated behavior and follow repository conventions.
5. **Verify measurable outcomes:** Run focused tests or an explicit self-check; do not claim unrun checks passed.
6. **Preserve contracts:** UI changes must not alter form behavior, state management, validation, or backend APIs.
7. **Protect sensitive systems:** Apply least privilege, server-side authorization, safe secret handling, and boundary validation.
8. **Keep design quiet:** Avoid decorative churn, flashy chrome, and unrequested redesign.
9. **Review for simplicity:** Remove or defer work that does not improve correctness, reliability, security, or the requested outcome.

## Documentation

- [Multi-agent adapters](adapters/README.md)
- [Skill index](skills/README.md)
- [Antigravity setup](docs/ANTIGRAVITY-SETUP.md)
- [ECC compatibility audit](docs/COMPATIBILITY-AUDIT-ECC.md)
- [Verification report](docs/VERIFICATION-REPORT.md)
- [ECC integration notes](integrations/ecc/README.md)
- [Unslop integration notes](integrations/unslop/README.md)
- [Security audit](integrations/security-audit/README.md), [TruffleHog](integrations/trufflehog/README.md), [Open Code Review](integrations/open-code-review/README.md), and [BLA](integrations/bla/README.md) integration notes
- [Complete upstream notices](THIRD-PARTY-NOTICES.md)

## Attribution and Credits

FAES is independently maintained by [FlerkenStudio](https://github.com/flerkenstudio). Copyright for the FAES distribution is held by FlerkenStudio as stated in [LICENSE](LICENSE).

FAES gratefully acknowledges the following people and projects for ideas or optional integration capabilities:

| Credit | Contribution |
|---|---|
| [Andrej Karpathy](https://github.com/karpathy) / [multica-ai Karpathy-inspired guidelines](https://github.com/multica-ai/andrej-karpathy-skills) | Inspiration for high-level principles on disciplined implementation, simplicity, surgical edits, and goal-driven verification. FAES uses locally authored adaptation text and does not bundle upstream files verbatim. |
| [Dietrich Gebert](https://github.com/DietrichGebert) / [Ponytail](https://github.com/DietrichGebert/ponytail) | Inspiration for the simplicity-first decision ladder, review and audit structure, shortcut tracking, and measured-impact discipline. FAES provides locally authored skills under the FAES project. |
| [Affaan Mustafa](https://github.com/affaan-m) / [Everything Claude Code](https://github.com/affaan-m/ECC) | Official ECC integration target. ECC remains an upstream project and is not vendored or modified into FAES core. The pinned integration package is `ecc-universal@2.2.3`. |
| [Damir Sokolovsky](https://github.com/heydamir) / [Unslop](https://github.com/heydamir/unslop) | Optional design-refinement skill. Pinned to reviewed commit `620163eedb3529d9cd23a3994ed8d287d06f760d` and distributed with CC BY 4.0 attribution. |
| [Cloudflare](https://github.com/cloudflare) / [security-audit-skill](https://github.com/cloudflare/security-audit-skill) | Vendored unmodified (MIT) as `security-audit`, pinned to `c1c8a8c1471069fb0e188eeaff69b8e8db6564a8`. |
| [Truffle Security](https://github.com/trufflesecurity) / [TruffleHog](https://github.com/trufflesecurity/trufflehog) | Secret scanning engine invoked as an external tool (AGPL-3.0, not vendored). |
| [Alibaba](https://github.com/alibaba) / [Open Code Review](https://github.com/alibaba/open-code-review) | External `ocr` CLI used by the `code-review-ocr` bridge (Apache-2.0, not vendored). |
| [qybaihe](https://github.com/qybaihe) / [BLA](https://github.com/qybaihe/bla) | Optional release-hardening tool (MIT, not vendored). |
| Google Antigravity, Anthropic Claude Code, Cursor, and Google Gemini CLI teams | Agent-host platforms for which FAES provides or targets adapters. FAES is independently maintained and is not claimed as an official product of these platforms. |

These projects are credited for inspiration or integration only. FAES does not claim authorship of their source code or ownership of their trademarks. Review the upstream projects and [THIRD-PARTY-NOTICES.md](THIRD-PARTY-NOTICES.md) before redistributing or extending optional components.

## License

FAES core code and documentation are distributed under the [MIT License](LICENSE).

- MIT: FAES, Karpathy-inspired adapted guidance, Ponytail-inspired adapted guidance, the ECC integration bridge, and the vendored Cloudflare `security-audit` skill (Cloudflare copyright preserved).
- CC BY 4.0: Optional Unslop integration; upstream attribution is preserved in `skills/unslop/` and `integrations/unslop/`.
- AGPL-3.0 (TruffleHog) and Apache-2.0 (Open Code Review): external tools only; no source is included in FAES.

Third-party component terms and upstream attribution requirements remain separate and must be preserved.

## Release Information

- Current version: `3.0.0`
- Release history: [CHANGELOG.md](CHANGELOG.md)
- 19 core skills, 4 design-engineering skills, and 3 security/review skills (26 default)
- 2 optional skills: Unslop and release-hardening (BLA)
- 4 supported agent adapters
- PowerShell and POSIX installation and verification scripts
