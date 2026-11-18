# FAES v1.2.0 verification report

**Build date:** 2026-11-18
**Input:** user-uploaded `faes-github.zip`
**Detected input version:** 1.1.0
**Output:** FAES v1.2.0 with ECC integration bridge

## Passed checks

- Input ZIP opened successfully; source tree extracted without Git internals.
- Input `VERSION` confirmed as `1.1.0`.
- Preserved all 18 existing FAES skills and their `SKILL.md` files.
- Parsed YAML frontmatter for all 18 skills; each has a non-empty `name` and `description`, and each name matches its folder name.
- Preserved existing FAES license, global instructions, workspace contract, templates, workflows, instructions, examples, and original installers.
- Updated release version to `1.2.0`.
- Added ECC integration manifest, global and project installers, global and workspace verifiers, hook compatibility note, license attribution, and compatibility audit.
- Parsed the new ECC integration manifest as valid JSON.
- Confirmed the release source contains no `.git/` internals.
- ZIP integrity checked after packaging.

## Explicitly not verified

- PowerShell syntax/runtime: not run because PowerShell is not installed in the build container.
- `npx ecc-universal@2.2.3` installation: not run because outbound network access is unavailable in the build container.
- ECC's complete source/test suite: not run; the full upstream source could not be downloaded in this environment.
- Live Antigravity runtime discovery: not available in the build container.
- Global + project end-to-end installation on the user's Windows PC: not run; no user workspace was modified.

## Compatibility constraints

- FAES is global; ECC supports an experimental global Antigravity plugin plus a project-local native adapter.
- Global hooks are configured with the standard profile and no disabled hook IDs; project-local hooks are disabled to prevent duplicate event handling. Runtime execution is not verified.
- The actual ECC skill catalog was not present locally. The included scanner inventories workspace skill-name overlaps after installation; semantic duplicate review remains a user-side follow-up.

## Required user-side smoke test

1. Install FAES globally.
2. Install the ECC global plugin/hooks and run the global file verifier.
3. Install ECC project-local components in a disposable project and run the workspace compatibility scanner.
4. Restart Antigravity and start a new conversation.
5. Confirm ECC appears in Settings > Customizations and ask the agent to list available FAES/ECC skills, rules, workflows, and custom agents.
6. Run the upstream-documented allowed/denied command and edit/Stop smoke tests using disposable files.
7. Do not rely on hook enforcement until those live tests pass.

A successful file check does not prove Antigravity loaded the customizations.
