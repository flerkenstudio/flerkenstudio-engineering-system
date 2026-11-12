# FlerkenStudio Antigravity Engineering System (FAES)

A reusable, production-minded engineering playbook for Google Antigravity. It provides global and workspace skills, always-on engineering rules, project templates, and repeatable delivery workflows.

## What is included
- `AGENTS.md`: always-on workspace engineering contract.
- `skills/`: reusable Agent Skills (each has a `SKILL.md`).
- `instructions/`: detailed engineering standards for humans and agents.
- `templates/`: PRD, architecture, API, database, security, ADR and project starter templates.
- `workflows/`: practical step-by-step delivery playbooks.
- `install/`: Windows PowerShell scripts for global and workspace installation.
- `examples/`: sample project configuration.

## Quick start (Windows PowerShell)

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

5. Restart or refresh Antigravity and inspect the Customizations/skills view. Skills can also be invoked by slash command, e.g. `/backend-engineering`.

## Antigravity locations

- Global skills: `~/.gemini/config/skills/<skill-name>/SKILL.md`
- Workspace skills: `<project-root>/.agents/skills/<skill-name>/SKILL.md`
- Workspace instructions: `<project-root>/AGENTS.md`
- Global instructions: `~/.gemini/AGENTS.md`

These locations follow the current Antigravity documentation. See `docs/ANTIGRAVITY-SETUP.md`.

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

## Versioning

Use semantic versioning for FAES releases. Record changes in `CHANGELOG.md`. Validate skills and scripts before distributing a new version.
