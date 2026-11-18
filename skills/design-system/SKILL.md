---
name: design-system
description: Design tokens, atomic component architecture, design system consistency, token governance, and UI component library integration.
---

# Design System (`design-system`)

Guides the creation, governance, and consumption of design tokens, atomic components, and reusable UI libraries.

## Token Architecture

Design tokens represent the single source of truth for visual decisions. Maintain a three-tier token hierarchy:

1. **Global (Primitive) Tokens:** Raw values without semantic meaning.
   - Examples: `colors.blue.500: #3b82f6`, `spacing.4: 16px`, `radii.md: 8px`
2. **Semantic (Contextual) Tokens:** Purpose-bound tokens mapping primitives to systemic roles.
   - Examples: `color.surface.primary`, `color.text.muted`, `color.action.hover`, `border.default`
3. **Component Tokens:** Scoped tokens for specific component requirements.
   - Examples: `button.primary.bg`, `card.header.padding`, `badge.font-size`

## Component Construction Rules

1. **Atomic Composition:** Build complex widgets by composing simpler atoms and molecules.
2. **Single Responsibility:** A component should own its visual rendering and accessibility attributes; avoid mixing business API queries directly into base design components.
3. **Props Contract:**
   - Explicit `variant` props (`primary`, `secondary`, `outline`, `ghost`, `destructive`).
   - Standardized `size` props (`sm`, `md`, `lg`).
   - Proper typing (TypeScript interfaces) for all supported states and event bindings.
4. **Style Encapsulation:** Use scoped styling (Tailwind CSS, CSS Modules, Styled Components, or native design tokens) to prevent style leakage.
5. **No Ad-Hoc Magic Numbers:** Avoid hardcoded arbitrary pixel values (`top: 13px`, `margin-left: 27px`) when established token scales exist.

## Migration & Token Auditing

When refactoring legacy components:
- Identify one-off hex colors and convert them to the semantic token palette.
- Replace manual margin/padding with standardized spacing tokens.
- Document token additions in the project's central theme or Tailwind configuration.
