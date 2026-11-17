# Roadmap

Tick each task with [x] when done. Work on one phase at a time; at the end of each phase
run `flutter analyze` and `flutter test`, then commit (Conventional Commits, in English).

## Phase 0 — Project foundation
- [x] Dependencies: flutter_riverpod, riverpod_annotation, go_router, drift, drift_flutter, intl,
      flutter_localizations (sdk), fl_chart, decimal, flutter_markdown, file_picker, share_plus;
      dev: build_runner, drift_dev, riverpod_generator, riverpod_lint
      (custom_lint dropped: riverpod_lint 3.x runs as an analysis_server_plugin. Versions are
      capped by Dart 3.11 / analyzer 9 — revisit after upgrading Flutter)
- [x] `l10n.yaml` + `app_es.arb` and `app_ca.arb` with the first keys
- [x] Folder structure as described in CLAUDE.md
- [x] Material 3 theme (light and dark)
- [x] go_router with StatefulShellRoute, 5 empty tabs + redirect to onboarding
- [x] Locale-aware currency, percentage and date formatting helpers

## Phase 1 — Data and logic
- [x] Drift AppDatabase with all tables from SPEC §10
- [x] DAOs and repositories per feature
- [x] `core/utils/finance.dart` with the SPEC §8 formulas + unit tests
- [x] Asset metrics calculation (SPEC §6) + tests

## Phase 2 — Onboarding
- [x] Steps 0–7 flow (SPEC §3) with state in a Notifier
- [x] Risk profile and emergency months logic + tests
- [x] Persist profile, expenses and goals on confirm
- [x] Retake questionnaire from Profile

## Phase 3 — Investments
- [x] Screen with the 4 categories and their totals
- [x] Asset list per category + create/edit form (category-specific fields)
- [x] Asset detail with transactions + transaction form
- [x] Visible metrics (contributed, value, return)

## Phase 4 — Goals and Home
- [ ] Goal screens: emergency, housing, retirement, custom
- [ ] Assign assets to a goal and compute progress
- [ ] Retirement projection chart
- [ ] Dashboard: net worth, goal cards, pie chart, tip of the day
- [ ] Warning when adding Equities/Crypto before the emergency fund is complete

## Phase 5 — Learn
- [ ] `index.json` + locale-aware Markdown reader
- [ ] 2 full lessons per module for modules 1–3 (es + ca)
- [ ] Quiz and progress tracking
- [ ] Quick tips

## Phase 6 — Profile and polish
- [ ] Language and theme switching
- [ ] JSON export/import + delete all data
- [ ] Legal notice
- [ ] Empty states, form validation and basic accessibility

## Future
- [ ] Remaining lessons (modules 4–8)
- [ ] Recurring contribution reminders (local notifications)
- [ ] Biometric/PIN lock (local_auth)
- [ ] Automatic prices (stock and crypto APIs)
- [ ] CSV export
- [ ] Cloud sync
