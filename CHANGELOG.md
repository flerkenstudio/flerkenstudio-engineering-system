# Changelog

## 3.0.0 - Security, review, and verification suite

### Added
- **Security suite**
  - `skills/security-audit/`: Cloudflare's six-phase source-first security audit skill, vendored (MIT) with license and provenance; enhanced with Windows defense-in-depth pipeline (device namespace blocking, DOS reserved component validation, pre-open `lstat`, directory traversal checks, handle-based `fstat` checks, and anti-TOCTOU handle binding); upstream POSIX protections preserved.
  - `skills/secret-scanning/`: TruffleHog-based leaked-credential workflow (external tool, AGPL-3.0, not vendored) with rotate-first remediation and an offline fallback.
  - `scripts/faes-secret-guard.mjs`: zero-dependency, offline secret guard (staged diff or paths; redacted output; `faes-secret-ignore` suppression).
  - `workflows/secret-scanning.md` and `workflows/security-audit.md`: depth-matched security workflows.
  - `templates/project-starter/.pre-commit-config.yaml` and `.github/workflows/secret-scan.yml` (TruffleHog action pinned to a reviewed commit).
- **Review**: `skills/code-review-ocr/`: bridge to Alibaba's Open Code Review CLI (Apache-2.0, external). Findings are treated as untrusted and merged with `code-review` / `ponytail-review`.
- **Optional**: `skills/release-hardening/`: BLA (MIT) release hardening for software you own; opt-in via `--include-bla` / `-IncludeBla`.
- **Claude Code hooks**: working `pre-tool-use.js` (blocks `git commit`/`push` with likely secrets) and `post-tool-use.js` (warns on secrets in written files), shipped in `adapters/claude/hooks/`.
- **Integrations metadata** for each upstream under `integrations/` with pinned commits and license notes.
- **Validation**: `scripts/validate.mjs` checks skill frontmatter, name/directory match, internal Markdown links, integration metadata, version consistency, and `SHA256SUMS.txt`; `scripts/generate-checksums.mjs` regenerates checksums.

### Changed
- `AGENTS.md` v3: security-depth skill selection, rotate-first secret rule, untrusted-scanner-output rule, license-respect rule.
- Installers (PowerShell and POSIX): new optional `-IncludeBla` / `--include-bla`; cross-platform CLI argument parity (supports `--agent all`, `--install-global-instructions`, `--skip-global`); selective global uninstaller preserving custom and non-FAES skills; verification covers 26 default skills (also fixes `agent-reliability-self-debugging` missing from the index and verify lists) (`-RequireBla` / `--require-bla` for the optional one); Claude workspace install copies hook scripts (inactive until merged into `.claude/settings.json`).
- `adapters/claude/hooks.json` rewritten to Claude Code's current `hooks` schema; the previous file referenced scripts that did not exist.
- `adapters/antigravity/hooks.json` and adapter metadata aligned with Antigravity's `.agents/hooks.json` lifecycle hook schema (optional `PreToolUse` secret guard template).
- `integrations/ecc/integration.json` `faes_version` corrected (was stuck at 1.2.0).
- All adapter, README, skill index, and notices updated to 3.0.0.

### Preserved
- All 24 v2.0.0 skills (including `agent-reliability-self-debugging`), workflows, templates, instructions, ECC bridge, and the optional `unslop` skill. No breaking changes; new default skills are additive.

### License decisions
- TruffleHog is AGPL-3.0 and is therefore invoked only as an external tool; no code is copied into this MIT project.

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
