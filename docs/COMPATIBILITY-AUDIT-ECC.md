# FAES v1.2.0 — ECC compatibility and license audit

**Audit date:** 2026-11-18  
**FAES source:** uploaded `faes-github.zip`, VERSION `1.1.0`  
**ECC upstream:** https://github.com/affaan-m/ECC  
**ECC Antigravity guide:** https://github.com/affaan-m/ECC/blob/main/docs/ANTIGRAVITY-GUIDE.md  
**Pinned package:** `ecc-universal@2.2.3`

## Executive result

FAES v1.1.0 is upgraded to v1.2.0 with a documented bridge to ECC's native Antigravity 2.0 installer. FAES remains the authoritative engineering contract. The bridge installs the ECC global plugin and hooks plus project-local ECC components from the official npm package; FAES remains globally installable.

This archive does **not** vendor ECC source. The build environment could inspect the official repository and its Antigravity guide, but could not clone/download the full upstream repository. Therefore, this is a source-backed integration wrapper and compatibility audit, not a claim that every upstream ECC file or hook was locally audited.

## Compatibility matrix

| Area | Result | Notes |
|---|---|---|
| Antigravity project-local rules | Supported | ECC maps `rules/` to `.agents/rules/` |
| Antigravity workflows | Supported | ECC maps commands to `.agents/workflows/` |
| Antigravity skills | Supported | ECC maps skills to `.agents/skills/<name>/SKILL.md` |
| Antigravity custom agents | Supported | ECC maps agent definitions to `.agents/agents/` with Antigravity-specific adaptation |
| FAES global skills | Supported | Existing `Install-Global.ps1` remains the global installer |
| ECC global Antigravity plugin | Experimental, documented | `antigravity-home` installs under `~/.gemini/config/plugins/ecc/`; includes global rules, skills, agents, workflows, memory MCP, and hooks |
| ECC lifecycle hooks in Antigravity | Experimental, documented | Global plugin supports `PreToolUse`, `PostToolUse`, and `Stop` through Antigravity's protojson protocol; real IDE execution still requires validation |
| CLI compatibility | Conditional | ECC installer is invoked via PowerShell/npm; target runtime remains host-specific |
| ECC plugin `.agents/` packaging | Do not copy wholesale | Upstream guide explicitly warns this is Codex packaging, not Antigravity plugin structure |

## Duplicate detection

FAES v1.1.0 contains 18 skills:

`api-design`, `backend-engineering`, `code-review`, `database-design`, `devops-release`, `frontend-engineering`, `karpathy-guidelines`, `performance-engineering`, `ponytail`, `ponytail-audit`, `ponytail-debt`, `ponytail-gain`, `ponytail-help`, `ponytail-review`, `product-requirements`, `project-onboarding`, `security-review`, `testing-qa`.

Potential semantic overlap exists by design in broad areas such as code review, security review, testing, backend engineering, and database design. Similar purpose is not automatically a duplicate. The FAES bridge does not overwrite FAES skills. Run `Test-ECC-Compatibility.ps1` after ECC installation to inspect skill-name collisions in the actual workspace.

**Audit limitation:** the full ECC skill catalog was not downloaded into this build environment, so a complete file-by-file semantic duplicate audit against every ECC skill is not claimed. The workspace scanner provides an actual post-install inventory; human review is required for semantically overlapping but differently named skills.

## License review

- FAES retains its original MIT `LICENSE`.
- ECC's upstream repository identifies ECC as MIT-licensed.
- No ECC source files are redistributed in this archive; the wrapper fetches the pinned official npm package when the user runs it.
- `THIRD-PARTY-NOTICES.md` records attribution and scope.
- Before changing the ECC package pin, verify the official upstream LICENSE, npm publisher/provenance, package contents, and release notes again.

This is a practical OSS attribution review, not legal advice.

## Security and hook decision

ECC's hooks are executable configuration. The current guide documents global `PreToolUse`, `PostToolUse`, and `Stop` handlers. FAES installs them once at global scope with `ECC_HOOK_PROFILE=standard` and leaves individual hook IDs enabled. Project-local hooks are disabled to avoid duplicate event handling. The global plugin remains experimental and its live behavior was not verified in this build. See `integrations/ecc/HOOK-COMPATIBILITY.md`.

## Installation contract

1. Install FAES globally with `install/Install-Global.ps1 -InstallGlobalInstructions`.
2. In each project, install FAES project skills if desired using `install/Install-Workspace.ps1`.
3. Run `install/Install-ECC-Workspace.ps1 -ProjectPath <project>` to invoke the pinned ECC Antigravity adapter.
4. Run `install/Test-ECC-Compatibility.ps1 -ProjectPath <project>`.
5. Restart Antigravity and verify skills/rules/workflows/custom agents in a new conversation.

ECC's installer owns `.agents/ecc-install-state.json`. Do not delete or edit that file manually; use ECC's documented doctor/repair/uninstall commands for lifecycle operations.

## Verification status

Passed in this build:
- Source archive integrity and extraction.
- FAES v1.1.0 source inventory and 18-skill count.
- Required FAES source files retained.
- Release version and integration metadata updated.
- Integration docs and PowerShell wrapper files created.
- Python-level syntax/structure checks on generated JSON and Markdown inventories.

Not run in this build:
- PowerShell parser/runtime (PowerShell is unavailable in the build container).
- npm registry fetch or ECC package install (network access unavailable in the build container).
- ECC's own test suite (upstream source not downloaded).
- Live Antigravity skill/rule/agent discovery.
- End-to-end installation in a user project.

Do not interpret a file-presence check as proof of runtime discovery.