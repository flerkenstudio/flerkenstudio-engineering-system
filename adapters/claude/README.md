# Claude Code Adapter (Tier 2)

Provides full compatibility with Anthropic Claude Code.

- **Instruction File:** `CLAUDE.md` at workspace root.
- **Skill Discovery:** Copies FAES skills to `.claude/skills/`.
- **Lifecycle Hooks:** Uses `.claude/hooks.json` mapping `Bash` to terminal and file operations to node verifiers.

## Hooks (v3.0.0)

The workspace installer copies `pre-tool-use.js`, `post-tool-use.js`, and `faes-secret-guard.mjs` to `.claude/hooks/`. They are **not active** until you merge the `hooks` object from `adapters/claude/hooks.json` into `.claude/settings.json`.

- `PreToolUse` (Bash): blocks `git commit` / `git push` when staged changes contain likely secrets. Uses TruffleHog if installed, otherwise the offline guard.
- `PostToolUse` (Write|Edit): warns when a written file appears to contain a secret.
- Guard runtime errors never block work; only confirmed findings do.
