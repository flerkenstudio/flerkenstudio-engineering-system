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
