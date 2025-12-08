# Thinkr

Personal decision assistant built with Flutter, Supabase, and Edge Functions.
- Clean Architecture (feature-first: data/domain/presentation)
- State management via BLoC/Cubit
- Dependency Injection with GetIt + Injectable
- Multi-environment (development/staging/production)
- Supabase Auth + Edge Functions for evaluation (WSM/AHP/Fuzzy)

Documentation: see docs/USAGE.md for the user guide.

## Table of Contents
- Overview
- Tech Stack
- Project Structure
- Environments & Config
- Run
- Auth Setup
- Dependency Injection & Codegen
- Localization
- Edge Functions
- Testing & Linting
- Branding & Icons
- Scripts
- CI/CD
- Notes

## Overview
Thinkr helps you make decisions by defining options, criteria, and scores, then evaluating them remotely using Supabase Edge Functions. It currently supports:
- Weighted Sum Model (WSM)
- AHP (simplified)
- Fuzzy Weighted Sum (placeholder, with fuzzy arithmetic and defuzzification)

Routing is protected with auth-aware redirects. Localization supports English and Bahasa Indonesia.

## Tech Stack
- Flutter (Dart 3.8)
- flutter_bloc for state management
- go_router for routing
- get_it + injectable for DI
- supabase_flutter for backend (auth/db/functions)
- google_sign_in for OAuth
- flutter_dotenv for environment variables
- hcaptcha_flutter (optional, when Supabase captcha is enabled)

Dev tools:
- build_runner, injectable_generator, freezed
- flutter_lints

## Project Structure
- lib/
  - main_development.dart, main_staging.dart, main_production.dart
  - bootstrap.dart (env/DI setup, Supabase init, providers, runApp)
  - thinkr_router.dart (GoRouter with auth-aware redirects)
  - thinkr_app.dart (root widget)
  - core/
    - env/environment.dart (EnvConfig from dotenv)
    - di/supabase_module.dart (SupabaseClient provider)
    - routes/app_routes.dart
    - localization/* (generated + helpers)
    - theme/, widgets/
  - features/
    - auth/ (data/domain/presentation)
    - decision/ (data/domain/presentation, Edge evaluation use cases)
    - settings/, home/, splash/, documentation/
  - l10n/ (generated localization files)
- supabase/functions/evaluate_decision/index.ts
- docs/USAGE.md
- script/generate-envs.sh, script/generate-envs.bat

## Environments & Config
Env files are bundled as assets (see pubspec.yaml) and loaded per flavor with fallback to .env.example.

Required keys (see lib/core/env/environment.dart):
```
SUPABASE_URL=...
SUPABASE_ANON_KEY=...
SUPABASE_REDIRECT_URL=...
# Optional: if captcha is enabled in Supabase
SUPABASE_CAPTCHA_SITE_KEY=...
# Google OAuth client IDs
GOOGLE_WEB_CLIENT_ID=...
GOOGLE_IOS_CLIENT_ID=...
```

Quick start:
1) Install deps
```bash
flutter pub get
```
2) Generate env files from example (creates .env.development/.staging/.production if missing)
```bash
bash script/generate-envs.sh   # macOS/Linux
# or
script\generate-envs.bat       # Windows
```
3) Edit .env.development (and staging/production if needed) with the values above.

## Run
Development flavor:
```bash
flutter run -t lib/main_development.dart
```
Use lib/main_staging.dart or lib/main_production.dart for other flavors.

Notes:
- Web uses path URL strategy (no hash).
- Ensure the selected flavor’s env file is present or .env.example exists as fallback (see main_*.dart).

## Auth Setup
- Supabase Auth: enable providers you need (Google is used in app). Set the Redirect URL to match SUPABASE_REDIRECT_URL in your env.
- Google Sign-In:
  - Provide GOOGLE_WEB_CLIENT_ID (for web)
  - Provide GOOGLE_IOS_CLIENT_ID (for iOS)
  - Configure authorized redirect URIs to match SUPABASE_REDIRECT_URL.

## Dependency Injection & Codegen
- Injectable bootstraps GetIt via SLInitializer ($init from sl_initializer.config.dart).
- SupabaseClient is provided by SupabaseModule (uses Supabase.instance.client).
- Re-generate code after annotations/changes:
```bash
dart run build_runner build --delete-conflicting-outputs
```

## Localization
- ARB files live under lib/l10n for en and id.
- Generated localization files are committed under lib/l10n.
- Update strings in ARB and rebuild as needed (gen-l10n or re-run build).

## Edge Functions
- Functions live in supabase/functions/.
- evaluate_decision implements:
  - Weighted Sum (WSM)
  - AHP (simplified, with consistency ratio)
  - Fuzzy Weighted Sum (placeholder with fuzzy arithmetic + defuzzification)
- Deploy:
```bash
supabase functions deploy evaluate_decision --project-ref <project-ref>
```
(Optional) Local serve:
```bash
supabase functions serve evaluate_decision
```

### Decision Support Method (WSM details)
- Normalize criterion weights: w_i_normalized = w_i / Σ w_i
- Score per option: score(option) = Σ (w_i_normalized * score(option, criterion_i))
- Result: best option id, per-option scores, sorted ranking
- Error rate is computed from confidence based on score margins and stability; UI shows reliability = 1 - error rate

## Testing & Linting
```bash
flutter test
```
Lints configured via analysis_options.yaml (flutter_lints).

## Branding & Icons
- Source asset: assets/branding/app_icon.png
- Regenerate platform icons:
```bash
flutter pub run flutter_launcher_icons
```
- Launcher/splash background color: #141C30

## Scripts
- script/generate-envs.sh / script/generate-envs.bat: scaffold env files from .env.example
- script/bump-version.py: version bump helper

## CI/CD
- Release workflow under .github/workflows/release.yml (tag-driven).

## Notes
- Env files are listed in pubspec.yaml assets so they’re available at runtime.
- Localization config is in l10n.yaml with ARB files under lib/l10n/.
- See docs/USAGE.md for an end-user guide to the app flow.
