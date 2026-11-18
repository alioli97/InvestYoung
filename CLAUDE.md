# Invertir siendo Joven — Claude Code guide

Flutter mobile app for personal finance, aimed at young people who are starting to invest.
Full functional spec: `docs/SPEC.md`. Phased work plan: `docs/ROADMAP.md`.
Read both before starting a new task and tick off in ROADMAP.md whatever you complete.

## Language rules

- **Everything in the repository is written in English**: code, identifiers, comments, docs,
  file names, commit messages, PR descriptions and TODOs — even when the user talks to you in Spanish.
- The only exception is **user-facing content**: ARB translations (`app_es.arb`, `app_ca.arb`)
  and lesson content under `assets/learn/{es,ca}/`, which are written in Spanish and Catalan.
- Commit messages follow Conventional Commits in English, e.g. `feat(onboarding): add expenses step`.

## Stack

- Flutter 3.50 (stable) + Dart 3.14 with null safety. Targets: Android and iOS.
- Material widgets come from **`package:material_ui`** (import `package:material_ui/material_ui.dart`,
  not the deprecated `package:flutter/material.dart`). `MaterialUiCompatibilityBridge` in `app.dart`
  stays until `fl_chart` and `flutter_markdown_plus` migrate.
- State: **Riverpod** (`flutter_riverpod`, with `riverpod_annotation` + `riverpod_generator`).
- Local database: **Drift** (`drift`, `drift_flutter`, `drift_dev`, `build_runner`).
- Navigation: **go_router** with `StatefulShellRoute` for the bottom navigation bar.
- Charts: **fl_chart**.
- i18n: `flutter_localizations` + `intl` with ARB files (`l10n.yaml`, `generate: true`).
- Precise decimals (crypto amounts, fund units): **decimal** package.
- Backup: `file_picker` + `share_plus`.
- No backend: everything is local (offline-first).

Add dependencies with `flutter pub add <package>` (do not pin versions by hand).

## Commands

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # Drift + Riverpod
flutter gen-l10n                                            # if not generated automatically
flutter analyze
flutter test
flutter run
```

Before considering a task done: `flutter analyze` has no errors and `flutter test` passes.
CI (`.github/workflows/ci.yml`) runs on every PR: formatting, generated code up to date,
analyze and tests. When upgrading Flutter, bump `flutter-version` there too.

## Architecture (feature-first)

```
lib/
  main.dart
  app.dart                  # MaterialApp.router, theme, locale
  core/
    db/                     # AppDatabase (Drift), tables, migrations
    router/                 # go_router
    theme/
    l10n/                   # formatting helpers (currency, dates, %)
    utils/                  # pure financial calculations
  features/
    onboarding/             # goals questionnaire
    dashboard/              # Home
    goals/                  # goals: emergency, housing, retirement
    investments/            # 4 investment types + transactions
    learn/                  # Knowledge section
    profile/                # settings, language, backup, legal notice
  l10n/
    app_es.arb
    app_ca.arb
assets/
  learn/es/*.md
  learn/ca/*.md
  learn/index.json          # module and lesson index
```

Inside each feature: `data/` (repositories, DAOs), `domain/` (models and pure logic),
`presentation/` (screens, widgets, providers).

## Mandatory conventions

1. **No hard-coded UI strings.** Every visible string goes into `app_es.arb` **and** `app_ca.arb`
   (always both, never just one). camelCase keys prefixed with the feature:
   `onboardingExpensesTitle`, `goalsHousingTitle`…
2. **Money as integer cents** (`int`) in the database and in the logic. Only converted to text
   in the UI through the `core/l10n` helpers (`es_ES` / `ca_ES` format, euro).
3. **Non-monetary quantities** (fund units, crypto units) use `Decimal`, stored in Drift as `TEXT`.
4. **Dates** stored as UTC `DateTime`; displayed in local time.
5. **Financial calculations** (emergency fund, required monthly contribution, compound interest,
   4% rule) are pure functions in `core/utils/finance.dart` and **always have unit tests**.
6. Every Drift schema change bumps `schemaVersion` and adds its migration.
7. Small, reusable widgets; no 500-line screens.
8. Material 3, light and dark themes.

## Legal notice (important)

The app is **educational** and does not provide financial advice (regulated by the CNMV in Spain).
- Never recommend specific products ("buy fund X").
- Profiles, ranges, indicative percentages and simulations are fine.
- Every return simulation shows the (localized) text "Indicative simulation, results are not guaranteed".
- The legal notice is shown during onboarding and is accessible from Profile.

## Web preview

`flutter run -d chrome` is supported for quick previews only (targets are still Android and iOS).
Drift on web needs `web/sqlite3.wasm` and `web/drift_worker.js`; when upgrading `drift` or
`sqlite3`, download the matching files from the drift and sqlite3.dart GitHub releases.
