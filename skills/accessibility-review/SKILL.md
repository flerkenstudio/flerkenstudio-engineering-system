---
name: accessibility-review
description: Accessibility audit and WCAG 2.2 compliance verification (Levels A, AA, and AAA targets), keyboard navigation, screen reader semantics, and focus management.
---

# Accessibility Review (`accessibility-review`)

Evaluates digital products against Web Content Accessibility Guidelines (WCAG) 2.2 and assistive technology requirements.

## WCAG 2.2 Target Size Standards

- **Level AA Mandatory (SC 2.5.8 Target Size Minimum):** Interactive targets must be at least **24×24 CSS pixels**, or provide sufficient spacing such that a 24px diameter circle centered on the target does not intersect another target or undersized target circle.
- **Level AAA Preferred Usability Enhancement (SC 2.5.5 Target Size Enhanced):** Interactive targets are recommended to meet **44×44 CSS pixels** for superior ergonomics, particularly on mobile and touch interfaces. Note: 44×44px is a preferred usability enhancement, not a mandatory failure criterion for standard Level AA compliance.

## Core Accessibility Dimensions

### 1. Perceivable
- **Text Contrast (SC 1.4.3 AA):** Minimum 4.5:1 for normal text; minimum 3:1 for large text (>= 18pt or bold >= 14pt).
- **Non-Text Contrast (SC 1.4.11 AA):** Minimum 3:1 for user interface components and graphical objects (borders, icons, active indicators).
- **Text Alternatives (SC 1.1.1 A):** Informative images must have concise, descriptive `alt` text. Purely decorative images must use empty `alt=""` or `aria-hidden="true"`.
- **Use of Color (SC 1.4.1 A):** Color must not be the sole visual means of conveying information, indicating an action, or distinguishing an element. Combine color with icons, text labels, or distinct shapes.

### 2. Operable
- **Keyboard Operability (SC 2.1.1 A):** All functionality must be operable via keyboard alone without requiring specific timings for individual keystrokes.
- **No Keyboard Trap (SC 2.1.2 A):** Focus must not become locked in any widget or modal dialog. Standard escape keys (e.g., `Esc` or `Tab`/`Shift+Tab`) must exit safely.
- **Focus Visible (SC 2.4.7 AA):** Interactive elements must display a distinct visual focus indicator when navigated via keyboard. Never set `outline: none` without providing an accessible alternative.
- **Focus Order (SC 2.4.3 A):** Navigation order must preserve meaning and operability, following logical reading order.

### 3. Understandable
- **Language of Page (SC 3.1.1 A):** Set valid top-level `lang` attribute on `<html>` (e.g., `<html lang="en">`).
- **Error Identification & Labels (SC 3.3.1 A & 3.3.2 A):** Input errors must be clearly identified and described in text. Labels and instructions must be associated with inputs via `label for` or `aria-labelledby`.
- **Status Messages (SC 4.1.3 AA):** Dynamic updates (toast notifications, asynchronous completions) should use `aria-live` regions (`polite` or `assertive`) so screen readers announce changes without taking focus.

### 4. Robust
- **Name, Role, Value (SC 4.1.2 A):** Standard native HTML elements (`<button>`, `<input>`, `<select>`, `<dialog>`) are preferred over custom `<div>` controls. Custom controls must expose proper ARIA roles, states, and properties (`aria-expanded`, `aria-checked`, `aria-haspopup`).
- **Valid Parsing & Semantics:** HTML markup must be well-formed with unique IDs.

## Audit Workflow

1. **Automated Scanning:** Run axe-core, Lighthouse, or Pa11y when available to catch baseline syntax and color contrast gaps.
2. **Keyboard Traversal Test:** Tab through the entire page using keyboard only:
   - Is focus order logical?
   - Is the focus ring always visible?
   - Can all buttons, links, and forms be activated?
   - Do modals trap focus correctly when open and return focus to the trigger on close?
3. **Screen Reader Verification:** Test key user journeys with NVDA, VoiceOver, or Orca.
4. **Remediation Plan:** Categorize findings by WCAG severity (A, AA, AAA) and provide code snippets showing corrected semantic HTML or ARIA attributes.
