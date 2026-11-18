# FAES Multi-Agent Adapter Layer — v2.0.0

FAES v2.0.0 separates core engineering rules and skills from agent-specific runtime mechanics. The FAES Core is shared and vendor-neutral, while modular adapters map core capabilities to each target AI coding agent.

## Supported Agent Adapters

| Target Agent | Tier | Discovery Root | Instruction File | Lifecycle Hooks |
|---|---|---|---|---|
| **Google Antigravity** | Tier 1 (First-Class) | `.agents/skills/` / `~/.gemini/config/skills/` | `AGENTS.md` | Native protojson IPC (`hooks.json`) |
| **Claude Code** | Tier 2 | `.claude/skills/` | `CLAUDE.md` | Shell commands (`.claude/hooks.json`) |
| **Cursor** | Tier 2 | `.cursor/rules/` | `.cursorrules` | Not supported (N/A) |
| **Gemini CLI** | Tier 2 | `.gemini/skills/` | `GEMINI.md` | Shell commands (`.gemini/hooks.json`) |

## Architecture Principle

1. **Shared Core:** All skills, architectural rules, and security guidelines reside in `skills/` and `instructions/`.
2. **Modular Adapters:** Each adapter directory provides the configuration, templates, and hook bridges required for its respective agent environment.
3. **Independent Installation:** Installing an adapter for one agent does not require dependencies, runtimes, or configurations from another agent.
4. **Honest Compatibility:** Adapters gracefully degrade when an agent lacks advanced features (such as lifecycle interception or sandboxed browser automation).
