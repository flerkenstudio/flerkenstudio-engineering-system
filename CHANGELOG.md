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
