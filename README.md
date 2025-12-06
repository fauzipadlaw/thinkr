# Thinkr

Personal decision assistant built with Flutter, Supabase, and Edge Functions (multi-env, Clean Architecture, BLoC, DI).

## Prerequisites
- Flutter SDK (3.8.x)
- Supabase project (URL + anon key)
- (Optional) Supabase CLI for Edge Functions

## Setup
1) Install deps
```bash
flutter pub get
```
2) Generate env files from the example (creates .env.development/.staging/.production if missing)
```bash
bash script/generate-envs.sh   # macOS/Linux
# or
script\generate-envs.bat       # Windows
```
3) Fill Supabase values in `.env.development` (and staging/production if you use them):
```
SUPABASE_URL=...
SUPABASE_ANON_KEY=...
SUPABASE_REDIRECT_URL=...
```

## Run
```bash
flutter run -t lib/main_development.dart
```
(use `main_staging.dart` / `main_production.dart` for other flavors)

## Edge Functions
- Functions live in `supabase/functions/`.
- `evaluate_decision` implements Weighted Sum Model (AHP/Fuzzy stubs ready).
- Deploy: `supabase functions deploy evaluate_decision --project-ref <project-ref>`

## Decision Support Method (current)
- **Weighted Sum Model (WSM)**  
  - Normalize criterion weights: `w_i_normalized = w_i / Σ w_i`  
  - Score per option: `score(option) = Σ (w_i_normalized * score(option, criterion_i))`  
  - Result: best option id, per-option scores, sorted ranking.  
  - Computed remotely via `evaluate_decision` Edge Function.

## Documentation
- User guide with expandable sections: `docs/USAGE.md`

## Scripts
- `script/generate-envs.sh` / `script/generate-envs.bat`: scaffold env files from `.env.example`.

## Notes
- Env files are listed in `pubspec.yaml` assets so they’re available at runtime.
- Localization config is in `l10n.yaml` with ARB files under `lib/l10n/`.
