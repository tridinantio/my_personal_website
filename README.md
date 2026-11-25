# Trinanda Dinantio, Flutter Engineer Portfolio

Personal portfolio website built with Flutter Web using a Warm Editorial Craft design direction documented in `DESIGN.md`. It includes a working light and dark theme toggle, domain filters for shipped Google Play products, technical notes dialogs, and responsive layouts across mobile, tablet, and desktop widths.

## Structure

```text
DESIGN.md                         Design direction, WCAG AA color tokens, and decision log
assets/fonts/                     Bundled Newsreader and IBM Plex Sans static TTF fonts
lib/
├── main.dart                     App entrypoint, theme mode state, and scroll shell
├── theme/app_theme.dart          Light and dark EditorialPalette tokens and button themes
├── models/portfolio_models.dart  Immutable models for work, experience, and stack rows
├── data/portfolio_data.dart      Portfolio content synced with resume facts
├── widgets/common_widgets.dart   SiteShell, ScreenBand, EditorialSectionHeader, InlineTag
└── sections/
    ├── nav_bar.dart              Sticky navigation bar, theme toggle, and mobile sheet menu
    ├── hero_section.dart         Asymmetric hero and profile fact ledger
    ├── projects_section.dart     Domain filter, flagship case study spread, and notes dialog
    ├── experience_section.dart   Hairline experience ledger
    ├── about_section.dart        Two-column technical stack index
    ├── education_section.dart    Education, certification, and languages note
    └── contact_section.dart      Inverted contact block and footer
```

## Verify and build

```powershell
flutter pub get
flutter analyze
flutter test
flutter build web --release
```

## Deployment

Pushing to `main` runs `flutter analyze`, `flutter test`, builds the release web bundle with Flutter `3.47.1`, and deploys to GitHub Pages via `.github/workflows/deploy.yml`.
