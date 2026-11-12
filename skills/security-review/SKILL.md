---
name: security-review
description: Reviews code and system changes for security weaknesses, abuse paths, privacy risks, and unsafe operational practices.
---

# Security review

## Scope
Review the changed code and its reachable trust boundaries. Do not claim a complete security audit from a limited diff.

## Review sequence
1. Identify assets, actors, trust boundaries, entry points, and abuse cases.
2. Check authentication, session/token handling, authorization, object ownership, and tenant isolation.
3. Check input validation, injection, output encoding, SSRF, path traversal, deserialization, and file upload handling.
4. Check secrets, cryptography, TLS, CORS, CSRF, security headers, and dependency risks.
5. Check rate limiting, brute-force/abuse controls, resource exhaustion, and safe error handling.
6. Check logging, telemetry, data retention, privacy exposure, and backup access.
7. Check payment/webhook signature verification and idempotency when relevant.
8. Rank findings by severity and exploitability; include file/line references and concrete remediation.
9. Run available scanners/tests only when configured and safe; report their limits.

## Output format
- Scope and files reviewed
- Findings: severity, evidence, impact, exploit path, remediation
- Positive controls observed
- Tests/tools run and results
- Residual risks and items requiring human/security review

Never test live systems, exploit production data, or modify security controls without explicit authorization. Use OWASP guidance as a baseline.
