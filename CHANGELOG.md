# Changelog

## 2.0.0 - Multi-Agent AI Engineering System & Design Engineering

### Added
- **Multi-Agent Architecture:**
  - Added shared Core and modular agent adapter architecture (`adapters/`).
  - Added Tier 1 First-Class support for Google Antigravity (`AGENTS.md`, native protojson hook configurations).
  - Added Tier 2 support for Anthropic Claude Code (`CLAUDE.md`, shell hook configurations, `.claude/skills/`).
  - Added Tier 2 support for Cursor IDE (`.cursorrules`, `.cursor/rules/*.mdc`).
  - Added Tier 2 support for Google Gemini CLI (`GEMINI.md`, `.gemini/skills/`).
- **Design Engineering Suite:**
  - Added `skills/design-review/`: Visual hierarchy, typography, contrast, layout, and ergonomic review.
  - Added `skills/visual-qa/`: Multi-viewport testing, light/dark mode parity, and rendering verification.
  - Added `skills/design-system/`: 3-tier design token architecture and atomic component construction.
  - Added `skills/accessibility-review/`: WCAG 2.2 accessibility audit (Level AA mandatory 24×24px SC 2.5.8 vs Level AAA preferred 44×44px SC 2.5.5).
- **Optional Upstream Integrations:**
  - Added `skills/unslop/`: Optional design refinement skill by Damir Sokolovsky ([@heydamir](https://x.com/heydamir)), CC BY 4.0, pinned to commit `620163eedb3529d9cd23a3994ed8d287d06f760d`.
  - Added `integrations/unslop/`: Upstream metadata, dependency documentation (Playwright and FFmpeg optional), and Zero-Slop / No-Op safeguard specifications.
- **Cross-Platform Installers:**
  - Added `install/win/`: Modern PowerShell installers supporting `-Agent` selection and dedicated backup routing.
  - Added `install/posix/`: POSIX Bash installers (`install-global.sh`, `install-workspace.sh`, `verify-installation.sh`, `uninstall-global.sh`, `install-ecc-global.sh`).

### Changed
- **Backup Architecture:** Fixed the inline backup directory bug in global installers. Skill backups are now routed to `~/.gemini/config/backups/skills-<timestamp>/` outside the active skill root to prevent host discovery pollution.
- **ECC Antigravity Plugin Packaging:** Upgraded ECC integration installer to deterministically construct and verify Antigravity plugin structure (`plugin.json`, `hooks.json`, `mcp_config.json`, `ecc/setup.json`).
- **Engineering Contract:** Updated `AGENTS.md` to v2.0.0 with multi-agent adapters, design engineering rules, Zero-Slop / No-Op safeguard, WCAG 2.2 target sizes, and business logic preservation.
- **Verification Scripts:** Updated `Verify-Installation.ps1` to test 22 core skills (18 baseline + 4 design engineering), check for optional unslop, and enforce zero discovery pollution.

### Preserved
- Preserved all 18 existing FAES skills, templates, workflows, instructions, and backward-compatible root `install/*.ps1` shims.
- Preserved full backward compatibility with existing project workspaces.


## 1.2.0 - ECC integration bridge

### Added
- Added a pinned integration bridge for the official `ecc-universal@2.2.3` package and ECC's native Antigravity 2.0 adapter.
- Added PowerShell installers for ECC's experimental global Antigravity plugin/hooks and supported native project rules, workflows, skills, and custom agents.
- Added global plugin file verification and a workspace compatibility scanner for FAES skill-name overlap, ECC install-state, and native `.agents/` structure.
- Added ECC integration metadata, compatibility audit, hook compatibility note, and third-party attribution.

### Changed
- Clarified the responsibility split: FAES remains the global engineering contract; ECC provides a global plugin/hook runtime plus project-local capabilities.
- Updated the engineering contract and setup documentation with FAES/ECC precedence and safe lifecycle guidance.
- Updated version metadata and the FAES skill index.

### Compatibility and safety decisions
- Did not vendor ECC source; the bridge installs the pinned official npm package at user execution time.
- Enabled the experimental global Antigravity hook runtime using the standard profile; project-local hooks are disabled to avoid duplicate event handling.
- Preserved all 18 existing FAES skills, workflows, templates, instructions, and PowerShell installers.


## 1.1.0 - Unified Karpathy + Ponytail integration

### Added
- Added six locally authored Ponytail-compatible skills: `ponytail`, `ponytail-review`, `ponytail-audit`, `ponytail-debt`, `ponytail-gain`, and `ponytail-help`.
- Added Agent-first and optional CLI setup guidance; both interfaces use the same workspace rules and skills.
- Added explicit guidance for lite/full/ultra/off task modes without promising unsupported persistence or lifecycle hooks.
- Added upstream attribution and scope notes in `THIRD-PARTY-NOTICES.md`.

### Changed
- Strengthened the always-on engineering contract with caller tracing, reuse-first dependency selection, focused diffs, non-trivial logic tests, and a lean-change review.
- Extended the existing Karpathy-inspired skill rather than duplicating it.
- Updated coding standards, skill index, setup docs, and README for the unified workflow.
- Kept `code-review` as the general review skill; `ponytail-review` adds a focused simplicity/YAGNI lens.

### Preserved
- Existing FAES skills, workflows, templates, security/database rules, PowerShell installers, and project starter files.
- Existing project-specific `AGENTS.md` files are still preserved by the workspace installer.
