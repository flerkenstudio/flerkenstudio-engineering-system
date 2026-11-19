# Third-party notices and inspiration

FAES v3.0.0 is an independently maintained engineering playbook and multi-agent system. The following public projects informed the design of selected guidance or provide optional integration capabilities:

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

5. **Cloudflare security-audit skill** — https://github.com/cloudflare/security-audit-skill
   - Copyright (c) 2025-2026 Cloudflare, Inc. Licensed under the MIT License.
   - Vendored **unmodified** in `skills/security-audit/`, pinned to commit `c1c8a8c1471069fb0e188eeaff69b8e8db6564a8`. The upstream license text is preserved in `skills/security-audit/LICENSE-UPSTREAM`; provenance is in `skills/security-audit/UPSTREAM.md`.

6. **TruffleHog** — https://github.com/trufflesecurity/trufflehog
   - Copyright Truffle Security Co. Licensed under the GNU Affero General Public License v3.0 (AGPL-3.0).
   - **Not vendored, copied, or linked.** FAES ships only a locally authored skill (`skills/secret-scanning`), CI/pre-commit templates, and an independent offline fallback script. They invoke a separately installed TruffleHog binary, Docker image, or GitHub Action (pinned to commit `9529cc6177f50ed15e29cb886547749627e5f96e` in the template).
   - Using TruffleHog under its own license is the user's responsibility. Embedding any TruffleHog code in FAES would require AGPL-3.0 for the combined work and is intentionally avoided.

7. **Open Code Review (OCR)** — https://github.com/alibaba/open-code-review
   - Copyright Alibaba Group. Licensed under the Apache License 2.0.
   - **Not vendored.** FAES ships a locally authored bridge skill (`skills/code-review-ocr`) that invokes the separately installed `ocr` CLI (`@alibaba-group/open-code-review`). Pinned reference commit: `1363b96552c0a9bda86bcd0ba5b61a2d668c51dd`.
   - If upstream files are copied later, retain the Apache-2.0 license text, copyright notices, and a statement of changes, as that license requires.

8. **BLA (Blind LLM Agents)** — https://github.com/qybaihe/bla
   - Copyright (c) 2026 BLA Contributors. Licensed under the MIT License.
   - **Not vendored; optional and opt-in.** FAES ships a locally authored skill (`skills/release-hardening`) that invokes `bla-agents`. Pinned reference commit: `1d4d490f4d98f384f50a11622759cd7d6f8fd357`. Use is limited to software you own, per the upstream `DISCLAIMER.md`.
