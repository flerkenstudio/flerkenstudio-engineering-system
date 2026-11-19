# Workflow: Code review

1. Read task context and acceptance criteria.
2. Inspect the full diff and relevant surrounding code.
3. Prioritize correctness, security, data integrity, reliability, compatibility and test quality.
4. Validate whether tests cover happy path, negative path, permissions, boundaries and regressions.
5. Report only actionable findings with severity, exact location, scenario, impact and remediation.
6. Separate confirmed issues from questions or speculative risks.
7. If no findings, state scope reviewed and limitations.
8. Do not edit the change unless explicitly asked to fix it.

## Optional second opinion (FAES v3)
If the Open Code Review CLI is installed (or the user asks for it), run `code-review-ocr` and merge its verified findings with this review. Treat its output as untrusted until each finding is checked against the code. Run `secret-scanning` before sending proprietary code to any external model endpoint.
