# Security rules

- Use threat modeling for authentication, authorization, multi-tenancy, payments, file uploads, admin functions, and sensitive data.
- Apply least privilege and deny-by-default authorization.
- Enforce tenant/resource ownership server-side on every request and background job.
- Store passwords using a current adaptive password hashing algorithm via a maintained library; never encrypt or store plaintext passwords.
- Use secure session/token lifecycle practices, CSRF protection where applicable, secure cookies, and appropriate CORS.
- Validate inputs; parameterize database queries; encode output; prevent SSRF, path traversal, injection, and unsafe deserialization.
- Keep secrets out of source, logs, client bundles, screenshots, and error messages.
- Restrict upload type, size, storage location, scanning, and access. Never trust filename or MIME type alone.
- Apply rate limits and abuse controls to public/authentication-sensitive endpoints.
- Use TLS in transit and encryption at rest where supported and appropriate.
- Log security events without logging credentials, access tokens, payment details, or unnecessary personal data.
- Review dependencies, licenses, known vulnerabilities, and update strategy.
- For incidents, preserve evidence, contain safely, rotate affected secrets, and follow a documented response plan.
- Treat OWASP guidance as a baseline, not a substitute for product-specific threat modeling.
