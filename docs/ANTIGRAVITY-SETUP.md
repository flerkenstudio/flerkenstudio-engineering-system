# Antigravity setup

Current documented skill discovery paths:

| Scope | Path | Purpose |
|---|---|---|
| Workspace | `<workspace>/.agents/skills/<skill>/SKILL.md` | Version-controlled skills for one project/team |
| Global | `~/.gemini/config/skills/<skill>/SKILL.md` | Skills available across local workspaces |
| Workspace instructions | `<workspace>/AGENTS.md` | Always-on project instructions |
| Global instructions | `~/.gemini/AGENTS.md` | Personal cross-project instructions, if desired |

FAES scripts install global skills to the documented global skills path and workspace skills to `.agents/skills`. The workspace installer also installs `AGENTS.md` only if it does not already exist, so it does not overwrite project-specific instructions.

## Agent workflow (no CLI)
1. Ensure `<workspace>/AGENTS.md` contains the FAES engineering contract. Merge; never overwrite project-specific instructions blindly.
2. Install selected skills under `<workspace>/.agents/skills/<skill>/SKILL.md` using file operations or the Agent's safe file-edit capability.
3. Refresh/restart Antigravity.
4. Ask the Agent to list discovered skills and summarize when to use `karpathy-guidelines`, `ponytail`, `ponytail-review`, and `ponytail-audit`.
5. If a skill is not discovered, verify the exact folder and valid YAML frontmatter. Continue using `AGENTS.md` as the fallback ruleset.

## CLI workflow (optional)

Run the supplied PowerShell installer from a terminal when convenient:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\install\Install-Workspace.ps1 -ProjectPath 'C:\path\to\your-project'
.\install\Verify-Installation.ps1 -ProjectPath 'C:\path\to\your-project'
```

For global skills:

```powershell
.\install\Install-Global.ps1 -InstallGlobalInstructions
.\install\Verify-Installation.ps1
```

The scripts copy FAES skills and preserve existing `AGENTS.md` files. `-Force` replaces existing skill folders; inspect backups/diffs before using it. Verification checks files on disk, not whether a host loaded them.

If using Antigravity CLI or another CLI agent, follow that host's current documented skill discovery/invocation syntax. FAES does not require installing the upstream Ponytail plugin separately: bundled FAES skills already provide the integrated workflow. Installing both may create duplicate skill names. Host-specific commands, mode persistence, and hooks are not guaranteed by the shared skill files.

## Refresh and inspect
1. Restart Antigravity or refresh its customization/skills view.
2. Ask the agent: "List the FAES skills you can access and summarize when each applies."
3. Try a manual invocation such as `/code-review`, `/ponytail`, or `/ponytail-review` only if slash/skill invocation is available in your Antigravity surface/version; otherwise ask the Agent in natural language to use the named skill.
4. If a skill is not visible, verify the exact path and that each skill folder contains `SKILL.md` with valid YAML frontmatter.

## Notes
Antigravity surfaces can differ in feature availability. The documented global path for the Antigravity App/IDE is `~/.gemini/config/skills`. Do not substitute older paths unless your installed version's documentation explicitly calls for them.

Official docs: https://antigravity.google/docs/skills

## Global instructions (optional)

Run `Install-Global.ps1 -InstallGlobalInstructions` to install `global/AGENTS.md` as `~/.gemini/AGENTS.md`. The script preserves an existing global `AGENTS.md`; merge the content manually if one already exists.


## FAES v1.2.0 — ECC integration

FAES remains the global engineering contract. ECC supports two Antigravity targets:

- **Global plugin:** `~/.gemini/config/plugins/ecc/` using `--target antigravity-home --profile core --enable-hooks`. This is documented upstream as experimental.
- **Project-local adapter:** `<project>/.agents/` using `--target antigravity --profile minimal --no-hooks`.

FAES v1.2.0 installs global hooks once and disables project-local hooks to avoid duplicate event handling. The global hook profile defaults to `standard`, and the wrapper does not set `ECC_DISABLED_HOOKS`.

From the FAES repository root:

```powershell
# Global FAES rules and skills
.\\install\\Install-Global.ps1 -InstallGlobalInstructions

# Global ECC plugin and lifecycle hooks
.\\install\\Install-ECC-Global.ps1
.\\install\\Test-ECC-Global.ps1

# Project-local ECC rules, workflows, skills, and agents
.\\install\\Install-ECC-Workspace.ps1 -ProjectPath 'C:\\path\\to\\project'
.\\install\\Test-ECC-Compatibility.ps1 -ProjectPath 'C:\\path\\to\\project'
```

The wrappers use the pinned official package `ecc-universal@2.2.3` and require Node.js 18+, npm, and network access. The global plugin includes an ECC memory MCP configuration; inspect `mcp_config.json` and the plugin files after installation.

The upstream guide documents global `PreToolUse`, `PostToolUse`, and `Stop` handlers using Antigravity's protojson protocol. It also states that the native CLI validation has limits and does not prove automatic IDE discovery or live event execution. Validate in a disposable project before relying on hook enforcement.

After installation, restart Antigravity and start a new conversation. Verify the plugin in Settings > Customizations, then perform the upstream-recommended safe/denied-command and edit/Stop smoke tests using disposable files. A disk-level report is not proof of host discovery or hook execution.

See `integrations/ecc/HOOK-COMPATIBILITY.md` and `docs/COMPATIBILITY-AUDIT-ECC.md`.
