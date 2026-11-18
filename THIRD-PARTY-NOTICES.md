# Third-party notices and inspiration

FAES v1.1.0 is an independently maintained engineering playbook. The following public projects informed the design of selected guidance:

1. **Karpathy-inspired Claude Code Guidelines** — https://github.com/multica-ai/andrej-karpathy-skills
   - FAES v1.0.0 already contained an original-wording adaptation of the four high-level principles: think before coding, simplicity first, surgical changes, and goal-driven execution.
   - v1.1.0 preserves and extends that existing FAES skill. No upstream file is bundled verbatim.
   - The upstream repository identifies its license as MIT. This notice is attribution, not a claim that FAES is the upstream project.

2. **Ponytail** — https://github.com/DietrichGebert/ponytail
   - Informed the simplicity-first decision ladder, review/audit focus, shortcut ledger, and measured-impact discipline.
   - FAES v1.1.0 provides locally authored skill text adapted to FAES and its Antigravity Agent/CLI workflows. It does not bundle the upstream plugin, lifecycle hooks, command runtime, or upstream skill files verbatim.
   - The upstream repository identifies its license as MIT. Review the upstream repository's current license before copying or redistributing any of its files.

No upstream benchmark claims are represented as FAES measurements. FAES does not claim the upstream projects' measured code, speed, token, or cost savings.


3. **Everything Claude Code (ECC)** — https://github.com/affaan-m/ECC
   - FAES v1.2.0 provides an integration bridge to ECC's official `ecc-universal` package and its documented native Antigravity adapter.
   - ECC source files are not vendored or modified in this FAES distribution. The bridge requests the official npm package at a pinned version at install time.
   - ECC's upstream repository identifies its license as MIT. Review the upstream `LICENSE` and package provenance before each future version bump. ECC remains the work of its original authors; FAES does not claim ownership or authorship of ECC.
   - ECC hooks are not copied or enabled by this integration because the documented Antigravity adapter does not expose a native hook mapping. See `docs/COMPATIBILITY-AUDIT-ECC.md`.
