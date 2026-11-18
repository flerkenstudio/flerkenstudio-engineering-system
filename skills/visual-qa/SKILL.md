---
name: visual-qa
description: Visual quality assurance, screenshot inspection, and rendering verification across viewports, browsers, and themes (light/dark mode).
---

# Visual QA (`visual-qa`)

Inspects rendered UI output across viewports, themes, and states to detect regressions, alignment drift, clipping, and overflow bugs.

## Core Rules

1. **Verify Before Declaring Complete:** Never assume UI renders correctly based solely on markup or CSS. Inspect rendered output when browser tools or screenshot capabilities are available.
2. **Cross-Viewport Testing:** Validate layout at primary breakpoints:
   - Mobile: 375px × 667px / 390px × 844px
   - Tablet: 768px × 1024px
   - Desktop: 1280px × 800px / 1440px × 900px
3. **Theme Parity:** Verify light and dark mode parity. Ensure contrast, borders, surface elevations, and text readability remain intact in both modes.
4. **Content Stress Testing:** Test UI with empty states, realistic content, and extreme content lengths (e.g., long names, translated strings, high currency numbers).

## Inspection Checklist

- [ ] **Overflow & Clipping:** No text truncation without deliberate ellipsis; no container overflow or unintended horizontal scrolling.
- [ ] **Alignment & Grid:** Elements align cleanly along defined axes; no 1px sub-pixel rounding jitter.
- [ ] **Asset Rendering:** SVGs render sharply without distortion; raster images maintain correct aspect ratios without distortion.
- [ ] **Z-Index & Stacking:** Dropdowns, modals, tooltips, and sticky headers stack above page content without z-index conflicts.
- [ ] **Motion & Transitions:** Transitions are smooth (150ms–300ms ease-out) without jarring flashes, jumps, or layout recalculation lag.
- [ ] **Dark Mode:** Surface hierarchy (elevations 0 through 4) visually distinct; borders visible; text contrast >= 4.5:1.

## Automation & Tooling

When optional visual regression tools (such as Playwright, Cypress, or Puppeteer) are present:
- Capture baseline snapshots before introducing visual changes.
- Run differential comparison after changes.
- Highlight pixel diff thresholds exceeding 0.1%.
- If tooling is unavailable, conduct manual verification using DOM inspection and viewport resizing.
