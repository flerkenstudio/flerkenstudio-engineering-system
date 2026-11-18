# ECC hook compatibility — Antigravity

**Status: experimental native support is documented for the global Antigravity plugin.**

ECC's current Antigravity guide documents a global plugin at `~/.gemini/config/plugins/ecc/` with lifecycle hooks using Antigravity's protojson protocol. It identifies:
- `PreToolUse`: command and file guards
- `PostToolUse`: edit tracking
- `Stop`: formatting and diagnostics

The guide documents global installation with:

```powershell
& "$EccRoot\install.ps1" --target antigravity-home --profile core --enable-hooks
```

FAES v1.2.0 uses the official `ecc-universal@2.2.3` package wrapper for that target and sets `ECC_HOOK_PROFILE=standard`. It does not populate `ECC_DISABLED_HOOKS`, so it does not intentionally disable individual hook IDs.

## Why project-local hooks are disabled

ECC also documents project-local hooks using the same runtime. When both global and project-local ECC are installed, FAES enables hooks only in the global plugin and uses `--no-hooks` for the project-local install. This avoids duplicate event handling while keeping project-local rules, workflows, skills, and agents available.

## Experimental validation boundary

The upstream guide calls the global Antigravity integration experimental and describes validation limits:
- The optional native validation requires Antigravity CLI 1.3.5 and does not download the CLI.
- The CLI's importer and component registration checks do not prove automatic IDE discovery or actual tool-event execution.
- Real Antigravity session testing is still required for allowed/denied tool behavior and Stop-phase execution.

FAES does not claim that hooks were executed or verified in this build environment. Test on a disposable workspace before relying on them for destructive-command prevention or formatting enforcement.

## Safety

Hooks are executable configuration. Inspect the generated `hooks.json`, plugin manifest, scripts, and MCP configuration. The upstream installer uses managed absolute paths; do not hand-copy hook JSON into unrelated settings files. Preserve ECC ownership/state files and use ECC's own doctor/repair/uninstall lifecycle.
