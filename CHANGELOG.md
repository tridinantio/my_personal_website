# Changelog

All notable changes to this portfolio website are documented in this file.

## [2.0.0] - 2026-11-25

### Added
- Created `DESIGN.md` defining the Warm Editorial Craft visual direction, WCAG AA verified Light and Dark palettes, typographic hierarchy, and design decision log.
- Bundled static `Newsreader` (serif display) and `IBM Plex Sans` (humanist sans) fonts locally under `assets/fonts/` for consistent offline and web rendering.
- Added a working Light (default) and Dark theme toggle in the navigation bar with high-contrast keyboard focus borders across both themes.
- Added interactive work domain filters (`All work`, `POS & hardware`, `AI & voice`, `Recruitment`) and `Technical notes` dialogs for `ESB POSLite`, `OLIN by ESB`, and `jobseeker.partners`.
- Added a labeled `Menu` bottom sheet for tablet and mobile viewports (`< 960px`) with accessible tap targets (`>= 44x44`).
- Added an interactive `Made With AI's Love!` floating button featuring organic floating motion, magnetic hover tilt, 60fps overlay physics fireworks (ChatGPT, Gemini, heart, and spark vector particles), an `AI Colophon` popover with per-model bursts, combo counter messages, and a manual `Pause` / `Float on` toggle.
- Expanded widget tests to cover desktop, tablet (`768px`), and mobile (`390px`) layouts, Light/Dark theme switching, clipboard copy feedback, project filters, dialogs, and the AI fireworks popover.

### Changed
- Revamped page composition to vary by section content: asymmetric hero with profile fact ledger, full-width `ESB POSLite` case study above two-column supporting work, hairline experience ledger, two-column technical stack index, and two-column education note.
- Replaced AI-default visual patterns (forced dark neon palette, hero glow orb, decorative status dot pill, wide-tracked uppercase eyebrows, generic sparkle/bolt icons, and uniform card grids).
- Updated copywriting across all sections and `web/index.html` to remove em dashes and generic buzzwords.
- Updated `web/index.html` loading screen and `web/manifest.json` to match the Warm Editorial paper palette.

## [1.1.0] - 2026-11-25

### Added
- Modularized `lib/` into `theme/`, `models/`, `data/`, `widgets/`, and `sections/`.
- Added `SelectionArea` for text selection on Flutter Web, `Copy email` clipboard feedback, Education credentials (`Universiti Utara Malaysia`, CGPA `3.61 / 4.00`, 4x Dean's List), and direct links to LinkedIn, GitHub, and live Google Play listings.
- Added `flutter analyze` and `flutter test` checks to `.github/workflows/deploy.yml` and pinned Flutter `3.47.1` in CI.

### Changed
- Synced experience timelines (`Nov 2023 to Present`, `Jan 2022 to Nov 2022`, `Oct 2020 to Jun 2021`) and engineering scope (Bluetooth/USB/Network printers, bank ECR payment terminals, OLIN AI chatbot with Text-to-Speech, Flutter 2 to 3 migration, and Angular/Go/PHP exposure).

### Removed
- Removed public CV PDF and personal phone number from the repository for privacy.
- Removed unused `cupertino_icons` dependency from `pubspec.yaml`.

## [1.0.0] - 2026-08-29

### Added
- Initial single-page Flutter Web portfolio and GitHub Pages deployment workflow.
- Custom portfolio favicon and web manifest icons.
