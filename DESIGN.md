# DESIGN.md: Trinanda Dinantio Portfolio

## Design Read
Reading this as: personal engineering portfolio for hiring managers, engineering leads, and technical recruiters, in a Warm Editorial Craft style, dial **ENERGY 2 / RHYTHM 3 / MOTION 1**.

## Dials
- **ENERGY 2 (Balanced):** Confident editorial typography and clear focal points without theatrical effects or loud banners.
- **RHYTHM 3 (Varied):** Every section uses a composition shaped by its actual content (asymmetric 2-column hero with fact ledger, full-width flagship case study over 2-column supporting work, horizontal hairline experience ledger, compact 2-column technical index, 2-column education note, inverted contact block).
- **MOTION 1 (Hover states & smooth scroll only):** No entrance cascades, no floating orbs, no endless loops; subtle hover/focus/pressed feedback only, respecting reduced-motion settings.

## Identity Motif
Warm archival paper paired with 1px stone hairlines, an editorial serif display voice (`Newsreader`) for headlines, and `IBM Plex Sans` for technical details and tabular index markers.

## Color System (WCAG AA Verified via contrast-check.py)
Maximum 2 neutral surfaces + 1 ink + 1 deliberate accent per theme.

### Light Mode (Default)
- Canvas: `#F7F4EE` (warm archival paper)
- Surface: `#EFEAE0` (warm stone panel)
- Crisp Surface: `#FFFFFF` (modals, active tags)
- Primary Ink: `#171614` (16.47:1 on canvas)
- Muted Ink: `#524D46` (7.63:1 on canvas, 6.98:1 on surface)
- Hairline Border: `#D8D1C5`
- Strong Control Border: `#7D756A` (4.14:1 on canvas, 3.79:1 on surface)
- Single Accent: `#B83B0A` terracotta (5.22:1 on canvas, 4.78:1 on surface; `#FFFFFF` text on `#B83B0A` is 5.73:1)

### Dark Mode (Working Toggle)
- Canvas: `#151412` (warm obsidian charcoal)
- Surface: `#1F1D1A` (warm dark umber)
- Crisp Surface: `#292622` (modals, active tags)
- Primary Ink: `#F3EFE7` (16.05:1 on canvas)
- Muted Ink: `#B8B0A4` (8.58:1 on canvas, 7.83:1 on surface)
- Hairline Border: `#332F2A`
- Strong Control Border: `#8E867B` (5.13:1 on canvas, 4.68:1 on surface)
- Single Accent: `#F07847` warm terracotta (6.56:1 on canvas, 5.99:1 on surface; `#151412` text on `#F07847` is 6.56:1)

## Typography
- **Display / Headings:** `Newsreader` (editorial serif) differentiates the site from generic sans-only AI developer templates and gives headlines authority without ALL-CAPS shouting.
- **Body / UI:** `IBM Plex Sans` (humanist technical sans) provides high legibility at small sizes for engineering specs, dates, and technical lists.

## Radius & Elevation Rules
- Structural panels and dialogs: `12px` radius.
- Buttons and interactive controls: `8px` radius (no uniform pill soup).
- Inline tags and filter tabs: `4px` radius.
- Elevation: flat by default using 1px hairlines; subtle shadow reserved only for open dialogs and mobile sheets.

## Decision Log (R-31)
- **Light default + dark toggle:** Recruiters and hiring managers read portfolios primarily in daylight/office browsers; a real working dark toggle serves engineers who prefer dark mode.
- **Single terracotta accent:** Restrains color scatter so primary actions, active filters, and focus rings stand out immediately.
- **No hero badge/orb/stat grid:** Removes decorative clutter so the headline, live product scope, and fact ledger act as one clear focal point above the fold.
- **Asymmetric work showcase:** `ESB POSLite` receives a full-width spread because it holds 3 years of hardware, payment terminal, and migration work, while `OLIN by ESB` and `jobseeker.partners` sit side by side below it.
- **No public CV PDF:** Keeps private phone/contact details off public GitHub hosting while inviting direct email or LinkedIn requests.
