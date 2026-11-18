# FlerkenStudio AI Engineering System (FAES) — v2.0.0

A modular, production-minded AI engineering system and multi-agent playbook for **Google Antigravity** (Tier 1 First-Class), **Claude Code**, **Cursor**, **Gemini CLI**, and compatible agent hosts.

FAES delivers vendor-neutral engineering standards, reusable Agent Skills, always-on engineering rules, design engineering craft, and automated lifecycle verification across agent platforms.

## What is Included in v2.0.0

- **Multi-Agent Adapters (`adapters/`):**
  - `adapters/antigravity/`: First-class Antigravity support (`AGENTS.md`, native protojson lifecycle hooks).
  - `adapters/claude/`: Claude Code support (`CLAUDE.md`, shell hook configs, `.claude/skills/`).
  - `adapters/cursor/`: Cursor IDE support (`.cursorrules`, `.cursor/rules/*.mdc`).
  - `adapters/gemini/`: Google Gemini CLI support (`GEMINI.md`, `.gemini/skills/`).
- **Core Engineering Skills (`skills/`):** 18 battle-tested skills including `karpathy-guidelines` and the Ponytail simplicity toolset (`ponytail`, `ponytail-review`, `ponytail-audit`, `ponytail-debt`, `ponytail-gain`, `ponytail-help`).
- **Design Engineering Suite (New in v2.0.0):**
  - `design-review`: Visual hierarchy, layout, contrast, and craft audit.
  - `visual-qa`: Cross-viewport, dark/light theme, and rendering verification.
  - `design-system`: 3-tier design token architecture and atomic component governance.
  - `accessibility-review`: WCAG 2.2 compliance (24×24px AA mandatory SC 2.5.8 vs 44×44px AAA preferred SC 2.5.5).
- **Optional Upstream Integrations:**
  - `unslop`: Optional UI unslopping and typography refinement by Damir Sokolovsky (CC BY 4.0, pinned commit `620163eedb3529d9cd23a3994ed8d287d06f760d`).
  - `ecc`: Everything Claude Code integration bridge (pinned v2.2.3).
- **Cross-Platform Installers (`install/`):**
  - Windows PowerShell: `install/win/` (`Install-Global.ps1`, `Install-Workspace.ps1`, `Verify-Installation.ps1`, `Install-ECC-Global.ps1`).
  - POSIX Bash: `install/posix/` (`install-global.sh`, `install-workspace.sh`, `verify-installation.sh`).

## Quick Start — Antigravity Agent (First-Class)

1. **Global Installation:**
   ```powershell
   Set-ExecutionPolicy -Scope Process Bypass
   .\install\win\Install-Global.ps1 -InstallGlobalInstructions
   ```
2. **Project Workspace Installation:**
   ```powershell
   .\install\win\Install-Workspace.ps1 -ProjectPath 'C:\path\to\project' -Agent antigravity
   ```
3. **Verify Skill Installation:**
   ```powershell
   .\install\win\Verify-Installation.ps1 -ProjectPath 'C:\path\to\project'
   ```

## Multi-Agent Quick Start

Install FAES into any workspace for your chosen agent target:

```powershell
# Claude Code
.\install\win\Install-Workspace.ps1 -ProjectPath 'C:\path\to\project' -Agent claude

# Cursor
.\install\win\Install-Workspace.ps1 -ProjectPath 'C:\path\to\project' -Agent cursor

# Gemini CLI
.\install\win\Install-Workspace.ps1 -ProjectPath 'C:\path\to\project' -Agent gemini-cli

# All Agents simultaneously
.\install\win\Install-Workspace.ps1 -ProjectPath 'C:\path\to\project' -Agent all
```

On Linux or macOS:
```bash
chmod +x install/posix/*.sh
./install/posix/install-workspace.sh --project /path/to/project --agent antigravity
```

## Core Engineering Principles

1. **Think Before Coding:** Formulate assumptions, surface risks, and establish explicit acceptance criteria.
2. **Simplicity First (Ponytail):** Choose the smallest complete solution over speculative abstractions.
3. **Surgical Edits:** Keep diffs focused; do not touch unrelated code.
4. **Goal-Driven Verification:** Run tests or execute code; never claim an unrun check passed.
5. **Zero-Slop UI Craft:** Respect established visual patterns. Do not redesign functional interfaces without an explicit defect or user request.
6. **Preserve Business Logic:** Visual changes must never break event handlers, forms, validation, or backend contracts.

## Attribution and Licensing

FAES v2.0.0 is distributed under the MIT License.
- **Karpathy-inspired Guidelines:** MIT License (inspired by Andrej Karpathy's principles).
- **Ponytail:** MIT License (inspired by Dietrich Gebert's simplicity tooling).
- **Everything Claude Code (ECC):** MIT License (Affaan Mustafa).
- **Unslop:** Creative Commons Attribution 4.0 International (CC BY 4.0, Damir Sokolovsky).
See `THIRD-PARTY-NOTICES.md` for complete notices and license text.
