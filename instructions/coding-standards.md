# Coding standards

- Match the repository's formatter, lint rules, naming, file organization, and error conventions.
- Prefer clear names, small cohesive functions, explicit data flow, and readable control flow.
- Prefer existing project helpers, native platform features, and already-installed dependencies before adding a new dependency. Justify any new runtime dependency.
- Avoid speculative abstractions, premature optimization, unnecessary dependencies, and duplicated sources of truth. Do not add one-use wrappers, factories, options, or configuration without a demonstrated need.
- Keep diffs focused: do not refactor adjacent code or remove pre-existing code merely because it appears unused. Trace references first; report unrelated cleanup separately.
- Make changes small but complete. Do not trade away validation, security, accessibility, error handling, or edge-case correctness for fewer lines.
- Mark an accepted shortcut with `shortcut: <limitation>, <when to upgrade>` only when the limitation is understood and safe for the current requirements.
- Keep functions/classes/modules focused; split only when cohesion or testability improves.
- Validate untrusted inputs at system boundaries; encode/escape output for its context.
- Use explicit types where supported; avoid unsafe casts and broad `any`/dynamic escape hatches.
- Keep comments focused on why, invariants, and non-obvious constraints—not restating code.
- Do not change formatting or comments in unrelated files.
- Make failures observable and actionable without leaking secrets or personal data.
- Follow accessibility and internationalization conventions in user-facing software.
