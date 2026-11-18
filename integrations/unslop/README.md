# Unslop Integration in FAES v2.0.0

This directory defines the optional Unslop integration in FAES v2.0.0.

- **Upstream Repository:** https://github.com/heydamir/unslop
- **Creator:** Damir Sokolovsky ([@heydamir](https://x.com/heydamir))
- **License:** Creative Commons Attribution 4.0 International (CC BY 4.0)
- **Pinned Commit:** `620163eedb3529d9cd23a3994ed8d287d06f760d`

## Safeguards & Principles

1. **Optional Integration:** Unslop is an optional design refinement skill. Core FAES functionality does not depend on Unslop.
2. **Attribution:** The upstream author, project URL, and CC BY 4.0 license are explicitly maintained in `skills/unslop/SKILL.md` and `THIRD-PARTY-NOTICES.md`.
3. **Zero-Slop / No-Op Rule:** If an audited screen displays no AI-generated slop or meets its design criteria, the skill enforces a zero-modification / no-op policy. Do not redesign clean interfaces.
4. **Behavioral Integrity:** Visual styling passes must never modify underlying business logic, state handling, or API routes.
5. **Tool Dependencies:** Automated snapshotting and video rendering depend on Playwright and FFmpeg, which remain optional. When absent, code-level review and manual browser verification apply.
