# FlerkenStudio Antigravity Engineering System (FAES)

A reusable, production-minded engineering playbook for Google Antigravity Agent/IDE and compatible CLI skill hosts. It provides global and workspace skills, always-on engineering rules, project templates, and repeatable delivery workflows.

## What is included
- `AGENTS.md`: always-on workspace engineering contract.
- `skills/`: reusable Agent Skills (each has a `SKILL.md`), including Karpathy-inspired thinking and the Ponytail simplicity/review/audit toolset.
- `instructions/`: detailed engineering standards for humans and agents.
- `templates/`: PRD, architecture, API, database, security, ADR and project starter templates.
- `workflows/`: practical step-by-step delivery playbooks.
- `install/`: Windows PowerShell scripts for global and workspace installation.
- `examples/`: sample project configuration.

## Quick start — Antigravity Agent (no CLI required)

1. Copy the FAES `AGENTS.md` into your project root. If one already exists, merge the rules manually; do not overwrite project-specific instructions.
2. Copy the FAES `skills/` folders you want into `<project-root>/.agents/skills/` (or use the workspace installer below).
3. Refresh/restart Antigravity and ask the Agent to list the skills it can access.
4. Ask the Agent to use `karpathy-guidelines` and `ponytail` for a non-trivial task. Invoke review/audit skills from the skill picker or slash interface only if your installed Antigravity version exposes them.

## Quick start — Windows PowerShell / CLI

1. Extract this repository or clone it from your GitHub repository.
2. Open PowerShell in the repository root.
3. Install globally (available to all Antigravity workspaces):

   ```powershell
   Set-ExecutionPolicy -Scope Process Bypass
   .\install\Install-Global.ps1 -InstallGlobalInstructions
   ```

4. In each project, copy the workspace package:

   ```powershell
   .\install\Install-Workspace.ps1 -ProjectPath 'C:\path\to\your-project'
   ```

5. Restart or refresh Antigravity and inspect the Customizations/skills view. In a skill-capable CLI host, invoke skills using that host’s supported skill syntax; slash-command availability varies by host and version.

## Antigravity locations

- Global skills: `~/.gemini/config/skills/<skill-name>/SKILL.md`
- Workspace skills: `<project-root>/.agents/skills/<skill-name>/SKILL.md`
- Workspace instructions: `<project-root>/AGENTS.md`
- Global instructions: `~/.gemini/AGENTS.md`

These locations follow the current Antigravity documentation. See `docs/ANTIGRAVITY-SETUP.md`.

## Agent and CLI support

FAES has one shared set of `AGENTS.md` rules and `SKILL.md` skills. Use the same workspace installation for Antigravity Agent/IDE and a compatible CLI host. The Agent workflow does not require a terminal or CLI. CLI is optional for installation, verification, and skill invocation where the host supports Agent Skills.

- Antigravity Agent/IDE: root `AGENTS.md` is the always-on project contract; workspace skills live in `.agents/skills/<skill>/SKILL.md`.
- Antigravity CLI / other compatible skill hosts: install the same skills with the supplied PowerShell scripts or the host's documented skill mechanism. Do not install the upstream Ponytail plugin on top of bundled FAES Ponytail skills unless you intentionally want a separate duplicate installation.
- The bundled `ponytail` skill supports lite/full/ultra/off as task instructions. Mode persistence, lifecycle hooks, and slash-command registration depend on the host; FAES does not claim those features when the host lacks them.
- Use `install/Verify-Installation.ps1` to verify the local skill files. This verifies files on disk, not whether an AI host has loaded them.

## Safe usage model

FAES is an engineering guide, not a guarantee of secure or production-ready software. Agents must inspect the actual project, follow its existing conventions, run available checks, and clearly report what was not verified. Human review is required for security-sensitive changes, production migrations, credentials, payments, and deployment.

## Recommended first run

Open a project in Antigravity and ask:

> Read `AGENTS.md` and the relevant FAES skills. Inspect this repository without changing files. Summarize the architecture, stack, test commands, security-sensitive areas, and the top risks. Do not implement anything yet.

Then use `workflows/new-project.md` or `workflows/feature-development.md`.

## Adapting the system

Keep global rules broadly applicable. Put stack- or product-specific requirements in the project-level `AGENTS.md` and `.agents/skills/`. Do not force one architecture, framework, database, or cloud provider on every product.

## Karpathy-inspired principles and attribution

The `karpathy-guidelines` skill is an original, concise adaptation of four publicly described principles: think before coding, simplicity first, surgical changes, and goal-driven execution. It is not a copy of the upstream repository's complete files. Upstream: https://github.com/multica-ai/andrej-karpathy-skills (MIT license as shown by its repository at time of review). Review upstream license and attribution before redistributing any upstream files.

## Upstream inspiration and attribution

- Karpathy-inspired guidelines: https://github.com/multica-ai/andrej-karpathy-skills — FAES retains its existing original-wording adaptation and does not bundle upstream files verbatim.
- Ponytail: https://github.com/DietrichGebert/ponytail — FAES adds locally authored, interoperable skill instructions inspired by the repository's simplicity-first workflow; it does not bundle the upstream plugin, hooks, or command runtime.
- See `THIRD-PARTY-NOTICES.md` for attribution and scope. Check upstream repositories and licenses before redistributing their files directly.

## Versioning

Use semantic versioning for FAES releases. Record changes in `CHANGELOG.md`. Validate skills and scripts before distributing a new version.
