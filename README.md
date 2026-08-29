# Trinanda Dinantio Portfolio

Personal portfolio website built with Flutter Web. It showcases professional experience, technical skills, and selected products in a responsive single-page design.

## Run locally

```powershell
flutter pub get
flutter run -d chrome
```

## Build for production

```powershell
flutter build web --release
```

The deployable static website is generated in `build/web`.

## Deploy free with GitHub Pages

1. Create a new **public** GitHub repository, for example `my-personal-website`.
2. Push this project to the repository's `main` branch.
3. In the GitHub repository, open **Settings → Pages** and set the source to **GitHub Actions**.
4. The included workflow builds and deploys the site automatically after each push to `main`.
5. Your website will be available at `https://YOUR_GITHUB_USERNAME.github.io/my-personal-website/`.

The workflow sets the required GitHub Pages base path automatically from the repository name. If you publish to a custom domain, update the `flutter build web` command in `.github/workflows/deploy.yml` to use `--base-href "/"`.

## Content to personalize

The portfolio content is in `lib/main.dart`. Before publishing, verify the role dates, product details, email address, and GitHub URL. Add real product links when they can be shared publicly.

## Product visuals

The project cards intentionally use Flutter icons instead of third-party screenshots. The Google Play links remain available for visitors who want to view the live listings.
