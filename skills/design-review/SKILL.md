---
name: design-review
description: Comprehensive UI/UX design review for web and mobile interfaces. Evaluates layout, hierarchy, contrast, typography, spacing, interaction ergonomics, and zero-slop design integrity.
---

# Design Review (`design-review`)

Evaluates user interfaces against professional visual, ergonomic, and brand standards.

## Principles

1. **Zero-Slop / No-Op Safeguard:** Never propose stylistic changes or redesigns to functional, established interfaces unless there is a verified design defect, accessibility gap, or explicit user request.
2. **Preserve Business Logic & Behavior:** Visual changes must never break event handlers, form submissions, validation, state management, or API contracts.
3. **Hierarchy & Structure:** Establish intentional typography, clear visual weight, rhythm, and purposeful negative space.
4. **Contrast & Color:** Ensure text and interactive elements pass contrast standards while maintaining cohesive brand palettes.
5. **Usability & Ergonomics:** Layouts must serve the user's workflow with minimal cognitive friction.

## Review Dimensions

1. **Typography & Scale:**
   - Single or dual harmonious font families.
   - Modular type scale with distinct headings (`h1` through `h6`) and body styling.
   - Line height (leading) proportioned to font size (1.4–1.6 for body copy).
   - Line length bounded to readable widths (45–75 characters per line).

2. **Spacing & Alignment:**
   - Consistent 4px or 8px baseline spacing system.
   - Predictable padding inside containers and consistent margins between blocks.
   - Strict horizontal and vertical grid alignment.

3. **Color, Tone & Contrast:**
   - Intentional palette: background, surface, border, primary accent, neutral text, muted text, status (success, warning, error).
   - WCAG 2.2 contrast compliance: minimum 4.5:1 for normal text, 3:1 for large text (18pt / 24px or bold 14pt / 18.5px) and active UI components / borders.
   - Avoid low-contrast text on bright backgrounds or muddy gray-on-gray styling.

4. **Interactive States:**
   - Clear hover, active, focus-visible, and disabled states on all interactive elements.
   - Never suppress `:focus-visible` outlines without providing a high-contrast replacement.

5. **Responsiveness & Fluidity:**
   - Graceful reflow from mobile (320px) to ultra-wide desktop.
   - No horizontal scrollbars on standard viewport widths.
   - Breakpoints aligned to standard container limits.

## Review Output Format

Structure design reviews with:
1. **Executive Assessment:** Overall design quality, strengths, and alignment.
2. **Defects & Friction Points:** Specific UI anomalies categorized by severity (Critical / Usability / Polish).
3. **Actionable Recommendations:** Exact CSS/component adjustments with before/after rationale.
4. **Preserved Elements:** Acknowledgment of components that meet design goals and should remain untouched.
