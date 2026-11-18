# Changelog

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
