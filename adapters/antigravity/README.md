# Antigravity Adapter (Tier 1 — First-Class)

Google Antigravity is the primary, first-class host environment for FAES.

## Capabilities

- **Instruction File:** `AGENTS.md` at workspace root, or `~/.gemini/AGENTS.md` globally.
- **Skill Discovery:** Scans `.agents/skills/` locally and `~/.gemini/config/skills/` globally.
- **Lifecycle Interception:** Lifecycle hook template configured for Antigravity's `.agents/hooks.json` contract (invoking `scripts/faes-secret-guard.mjs` on `PreToolUse` for `run_command`). Optional and opt-in.
- **Native Tool Support:** Direct alignment with `run_command`, `read_file`, `write_file`, and `edit_file`.

## Global Installation
Global setup places shared skills in `~/.gemini/config/skills/`, configures `~/.gemini/AGENTS.md`, and links the global ECC plugin runtime when present.
