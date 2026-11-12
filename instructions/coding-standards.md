# Coding standards

- Match the repository's formatter, lint rules, naming, file organization, and error conventions.
- Prefer clear names, small cohesive functions, explicit data flow, and readable control flow.
- Avoid speculative abstractions, premature optimization, unnecessary dependencies, and duplicated sources of truth.
- Keep functions/classes/modules focused; split only when cohesion or testability improves.
- Validate untrusted inputs at system boundaries; encode/escape output for its context.
- Use explicit types where supported; avoid unsafe casts and broad `any`/dynamic escape hatches.
- Keep comments focused on why, invariants, and non-obvious constraints—not restating code.
- Do not change formatting or comments in unrelated files.
- Make failures observable and actionable without leaking secrets or personal data.
- Follow accessibility and internationalization conventions in user-facing software.
