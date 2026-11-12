# Antigravity setup

Current documented skill discovery paths:

| Scope | Path | Purpose |
|---|---|---|
| Workspace | `<workspace>/.agents/skills/<skill>/SKILL.md` | Version-controlled skills for one project/team |
| Global | `~/.gemini/config/skills/<skill>/SKILL.md` | Skills available across local workspaces |
| Workspace instructions | `<workspace>/AGENTS.md` | Always-on project instructions |
| Global instructions | `~/.gemini/AGENTS.md` | Personal cross-project instructions, if desired |

FAES scripts install global skills to the documented global skills path and workspace skills to `.agents/skills`. The workspace installer also installs `AGENTS.md` only if it does not already exist, so it does not overwrite project-specific instructions.

## Refresh and inspect
1. Restart Antigravity or refresh its customization/skills view.
2. Ask the agent: "List the FAES skills you can access and summarize when each applies."
3. Try a manual invocation such as `/code-review` or `/security-review` if slash commands are available in your Antigravity surface/version.
4. If a skill is not visible, verify the exact path and that each skill folder contains `SKILL.md` with valid YAML frontmatter.

## Notes
Antigravity surfaces can differ in feature availability. The documented global path for the Antigravity App/IDE is `~/.gemini/config/skills`. Do not substitute older paths unless your installed version's documentation explicitly calls for them.

Official docs: https://antigravity.google/docs/skills

## Global instructions (optional)

Run `Install-Global.ps1 -InstallGlobalInstructions` to install `global/AGENTS.md` as `~/.gemini/AGENTS.md`. The script preserves an existing global `AGENTS.md`; merge the content manually if one already exists.
