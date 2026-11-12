---
name: frontend-engineering
description: Builds accessible, responsive, maintainable web interfaces and client-side application behavior.
---

# Frontend engineering

## Procedure
1. Inspect framework, routing, component library, styling, state, data-fetching, and test conventions.
2. Identify user journey, loading/empty/error/success states, responsive behavior, and accessibility needs.
3. Reuse established components and design tokens; do not introduce a second UI system without justification.
4. Keep presentation separate from domain rules where practical.
5. Validate data from APIs; never treat client-side validation as a security boundary.
6. Handle loading, retries, cancellation, stale responses, and optimistic updates carefully.
7. Support keyboard navigation, visible focus, semantic HTML, labels, contrast, and screen-reader context.
8. Avoid leaking secrets or privileged logic into client bundles.
9. Test critical interactions, responsive layouts, accessibility basics, and error states.

## Checklist
- [ ] Responsive at supported breakpoints
- [ ] Accessible labels, semantics, focus and keyboard behavior
- [ ] Loading, empty, error and success states
- [ ] No secrets or authorization decisions trusted only on client
- [ ] Network failures and stale state handled
- [ ] Tests and production build pass
