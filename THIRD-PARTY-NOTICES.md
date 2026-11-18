# Third-party notices and inspiration

FAES v2.0.0 is an independently maintained engineering playbook and multi-agent system. The following public projects informed the design of selected guidance or provide optional integration capabilities:

1. **Karpathy-inspired Claude Code Guidelines** — https://github.com/multica-ai/andrej-karpathy-skills
   - FAES already contained an original-wording adaptation of the four high-level principles: think before coding, simplicity first, surgical changes, and goal-driven execution.
   - v2.0.0 preserves and extends that existing FAES skill. No upstream file is bundled verbatim.
   - The upstream repository identifies its license as MIT. This notice is attribution, not a claim that FAES is the upstream project.

2. **Ponytail** — https://github.com/DietrichGebert/ponytail
   - Informed the simplicity-first decision ladder, review/audit focus, shortcut ledger, and measured-impact discipline.
   - FAES v2.0.0 provides locally authored skill text adapted to FAES and its multi-agent workflows. It does not bundle the upstream plugin, lifecycle hooks, command runtime, or upstream skill files verbatim.
   - The upstream repository identifies its license as MIT. Review the upstream repository's current license before copying or redistributing any of its files.
   - No upstream benchmark claims are represented as FAES measurements. FAES does not claim the upstream projects' measured code, speed, token, or cost savings.

3. **Everything Claude Code (ECC)** — https://github.com/affaan-m/ECC
   - FAES v2.0.0 provides an integration bridge to ECC's official `ecc-universal` package (pinned v2.2.3) and its native Antigravity plugin adapter.
   - ECC source files are not vendored or modified in the core FAES distribution. The bridge requests the official npm package at a pinned version at install time.
   - ECC's upstream repository identifies its license as MIT. ECC remains the work of its original authors; FAES does not claim ownership or authorship of ECC.
   - Review upstream licenses and documentation before using optional ECC components.

4. **Unslop** — https://github.com/heydamir/unslop
   - Created by Damir Sokolovsky ([@heydamir](https://x.com/heydamir)).
   - Licensed under Creative Commons Attribution 4.0 International (CC BY 4.0).
   - FAES v2.0.0 integrates an optional design refinement skill located in `skills/unslop`, pinned to reviewed commit `620163eedb3529d9cd23a3994ed8d287d06f760d`.
   - Full upstream CC BY 4.0 attribution, author metadata, and license terms are preserved in `skills/unslop/SKILL.md` and `integrations/unslop/`.
   - FAES strictly honors the Zero-Slop / No-Op safeguard: if an interface already satisfies its design goals, no changes are proposed.
