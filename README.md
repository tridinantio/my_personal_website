# Trinanda Dinantio — Flutter Engineer Portfolio

Personal portfolio website built with **Flutter Web**. It showcases professional experience, categorized technical skills, live Google Play applications, and education credentials in a responsive single-page layout.

## Architecture

```text
lib/
├── main.dart                     # App entrypoint, SelectionArea, sticky nav & scroll shell
├── theme/app_theme.dart          # Dark theme palette & typography tokens
├── models/portfolio_models.dart  # Immutable data models
├── data/portfolio_data.dart      # Single source of truth for portfolio content
├── widgets/common_widgets.dart   # SiteShell, SectionBlock, HoverCard, TechChip, SocialActionPill
└── sections/
    ├── nav_bar.dart              # Sticky frosted-glass navbar + mobile popup menu
    ├── hero_section.dart         # Headline, quick stats & social CTAs
    ├── about_section.dart        # Summary & 6-category technical stack
    ├── experience_section.dart   # Career timeline & live Play Store chips
    ├── projects_section.dart     # Live production apps + interactive Highlights modal
    ├── education_section.dart    # University degree, CGPA, honors, certification & languages
    └── contact_section.dart      # Email, Copy Email, social links & footer
```

## Run locally

```powershell
flutter pub get
flutter run -d chrome
```

## Verify & build for production

```powershell
flutter analyze
flutter test
flutter build web --release
```

## Deployment

Pushing to `main` automatically runs `flutter analyze`, `flutter test`, builds the release web bundle with the repository `--base-href`, and deploys to GitHub Pages via `.github/workflows/deploy.yml`.
