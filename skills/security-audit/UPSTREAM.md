# Upstream provenance

- Source: https://github.com/cloudflare/security-audit-skill
- Pinned commit: `c1c8a8c1471069fb0e188eeaff69b8e8db6564a8`
- License: MIT, Copyright (c) 2025-2026 Cloudflare, Inc. (see `LICENSE-UPSTREAM`)
- Modified for cross-platform compatibility: `validate-findings.cjs` and `validate-coverage-ledger.cjs` (and their test suites) have been modified by FAES to support Windows securely while preserving 100% of upstream POSIX protections.

## Modifications in FAES

Upstream Cloudflare code relies on POSIX-exclusive kernel flags (`O_RDONLY | O_NOFOLLOW | O_NONBLOCK`) to safely open files without following symlinks or blocking on special character/FIFO devices. Because Windows does not provide `O_NOFOLLOW` or `O_NONBLOCK` in the Windows kernel/Node.js `win32` platform:

1. **Windows Defense-in-Depth Pipeline**:
   - **Namespace Filter**: Explicitly rejects UNC and NT device paths (`/^[\\/]{2}/`), blocking SMB remote shares, named pipes, and `\\?\` prefix escapes.
   - **DOS Device Filter**: Validates each path segment against Windows reserved device names (`CON`, `PRN`, `AUX`, `NUL`, `COM1-9`, `LPT1-9`, `CLOCK$`, `CONIN$`, `CONOUT$`) before filesystem access.
   - **Pre-Open Inspection**: Verifies with `fs.lstatSync` that the target is a regular file and not a symbolic link or reparse point.
   - **Path Ancestry Verification**: Resolves the full path and traverses every parent directory component with `fs.lstatSync` to guarantee no directory junction or symlink exists along the path.
   - **Post-Open File Handle Validation**: Verifies `fs.fstatSync(descriptor).isFile()` directly against the opened kernel file handle.
   - **Anti-TOCTOU Handle Binding**: Verifies device and inode numbers (`fstat.dev === postStat.dev && fstat.ino === postStat.ino`) to protect against Time-of-Check to Time-of-Use replacement races.

2. **POSIX Protections Preserved**:
   - On all POSIX platforms (Linux, macOS, BSD), the original atomic kernel `O_RDONLY | O_NOFOLLOW | O_NONBLOCK` open flags remain 100% active and unmodified.

3. **Test Suite Compatibility**:
   - `validate-findings.test.cjs` and `validate-coverage-ledger.test.cjs` were extended to test Windows reserved names, device paths, and symlink rejection, while conditionally skipping POSIX-only FIFO tests on `win32`.

## How FAES uses it

- `security-review` stays the fast, diff-scoped review.
- `security-audit` is the deep, six-phase, whole-codebase audit. Use it only for an explicit audit,
  pen-test, full/comprehensive security review, or when report artifacts are requested.
- Run its validators with `node validate-coverage-ledger.cjs` and `node validate-findings.cjs`
  (zero dependencies, Node >= 18).
