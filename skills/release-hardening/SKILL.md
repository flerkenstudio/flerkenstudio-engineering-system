---
name: release-hardening
description: Optional. Hardens your own release artifacts against AI reverse-engineering agents using BLA (bla-agents), with before/after verification. Use only for software you own and are about to ship.
---

# Release hardening (optional, BLA)

BLA (https://github.com/qybaihe/bla, MIT; npm `bla-agents`) is an **external tool**, opt-in, and excluded from default installs. It adds decoy and resource-exhaustion structures to build outputs to make automated AI reverse engineering costlier. It is defense in depth, not secrecy: **never rely on it to protect secrets.** Keep keys and sensitive logic server-side.

## Use only when
- You own the software or have explicit authorization to modify and distribute it.
- The build already passes tests and you are preparing a release.
- Do **not** use it on third-party software, to evade security review, or to hide malicious behavior.

## Workflow
1. **Precheck:** run `secret-scanning` and `security-review` first; hardening is not a substitute for fixing vulnerabilities or leaked secrets.
2. **Build** the release normally. BLA targets build output, not source.
3. **Dry run (writes a mirror only):** `npx bla-agents harden .` -> output goes to `.bla-hardened/`. Nothing ships yet.
4. **Verify equivalence:** run the project's full test suite and smoke test against the hardened output. Run `npx bla-agents verify <protected> <original>` for BLA's structural gates. Compare size and startup/performance to the original.
5. **Review the diff in behavior and size.** If tests fail or performance regresses beyond what the user accepts, stop and report.
6. **Apply only with explicit approval:** `npx bla-agents harden . --apply`. Undo with `--restore`. Keep the originals.
7. **Report:** artifacts hardened, tests run and results, size/perf delta, how to restore, and the limitation that this is not absolute protection.

## Rules
- Pin the BLA version in the report; behavior changes between releases.
- Do not run `--apply` unattended or in CI without an approved, reviewed pipeline.
- Do not install or register BLA's MCP server (`bla-agents setup`) without the user's consent.
- Read BLA's DISCLAIMER before first use; it restricts use to software you own.
