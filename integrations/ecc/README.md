# FAES + ECC integration bridge

FAES v1.2.0 uses both documented ECC Antigravity installation targets while keeping FAES as the primary engineering contract.

## Scope and hook strategy

- **Global FAES:** install FAES skills and `~/.gemini/AGENTS.md` using the existing FAES installer.
- **Global ECC:** install ECC's experimental native Antigravity plugin under `~/.gemini/config/plugins/ecc/` using `--target antigravity-home --profile core --enable-hooks`.
- **Global hooks:** enabled once with `ECC_HOOK_PROFILE=standard`; no individual hook IDs are disabled.
- **Project ECC:** install native project-local rules, workflows, skills, and agents under `.agents/` using `--target antigravity --profile minimal --no-hooks`.
- **Why project hooks are disabled:** the global plugin already owns the lifecycle event runtime. Enabling project-local hooks as well could cause duplicate handling. Project-local configuration still installs.
- **Experimental status:** the global Antigravity plugin and hook bridge are experimental. Validate in a disposable project and real Antigravity session before relying on enforcement.

## Install

Run from the FAES repository root in PowerShell:

```powershell
# Global FAES
.\install\Install-Global.ps1 -InstallGlobalInstructions

# Global ECC plugin + hooks
.\install\Install-ECC-Global.ps1

# Project-local ECC components; hooks remain global-only
.\install\Install-ECC-Workspace.ps1 -ProjectPath 'D:\path\to\project'

# Verify both scopes
.\install\Test-ECC-Global.ps1
.\install\Test-ECC-Compatibility.ps1 -ProjectPath 'D:\path\to\project'
```

The wrappers use the official pinned npm package `ecc-universal@2.2.3`. Node.js 18+ and network access to npm are required. The scripts support `-DryRun`.

## Hook profile

The global installer sets `ECC_HOOK_PROFILE=standard` for installation and does not set `ECC_DISABLED_HOOKS`, so no individual hook IDs are deliberately disabled. `standard` is the upstream documented default strictness profile; it is not a claim that every optional behavior in every harness is identical.

## Upstream lifecycle

ECC owns its global plugin files and project `.agents/ecc-install-state.json`. Do not delete or edit these manually. Use the upstream ECC doctor, repair, and uninstall commands. See `HOOK-COMPATIBILITY.md` and `../docs/COMPATIBILITY-AUDIT-ECC.md`.

Official guide: https://github.com/affaan-m/ECC/blob/main/docs/ANTIGRAVITY-GUIDE.md
Official repository: https://github.com/affaan-m/ECC
