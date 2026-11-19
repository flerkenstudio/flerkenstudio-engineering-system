# Gemini CLI Engineering Directives (FAES v3.0.0)

Follow the FlerkenStudio AI Engineering System standards.

1. **Think Before Coding:** Explicitly state assumptions and verification steps before editing.
2. **Smallest Complete Solution:** Do not over-engineer. Avoid speculative features.
3. **Surgical Changes:** Modify only files relevant to the active task.
4. **Goal-Driven Verification:** Run tests or verification commands and report exact results.
5. **Secure Defaults:** Parameterize queries, sanitize inputs, protect secrets. Use `secret-scanning` before commits/releases; use `security-audit` only for explicit full audits.
6. **Zero-Slop Craft:** Do not generate cluttered, flashy, or unrequested UI redesigns.
