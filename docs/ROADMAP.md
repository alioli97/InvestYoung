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
- [x] Goal screens: emergency, housing, retirement, custom
- [x] Assign assets to a goal and compute progress
- [x] Retirement projection chart
- [x] Dashboard: net worth, goal cards, pie chart, tip of the day
- [x] Warning when adding Equities/Crypto before the emergency fund is complete

## Phase 5 — Learn
- [x] `index.json` + locale-aware Markdown reader
- [x] 2 full lessons per module for modules 1–3 (es + ca)
- [x] Quiz and progress tracking
- [x] Quick tips

## Phase 6 — Profile and polish
- [x] Language and theme switching
- [x] JSON export/import + delete all data
- [x] Legal notice
- [x] Empty states, form validation and basic accessibility

## Phase 7 — Stability and sharing (APK for family and friends)
- [ ] Test on real devices; collect feedback and fix the bugs found
- [x] Own release signing key (kept out of Git) so updates install over previous versions
- [x] Versioning: bump `version` in pubspec.yaml on every shared build
- [x] CI job that builds the release APK and uploads it as a downloadable artifact

## Phase 8 — Learn content
- [x] Module 4 — Fixed income: 2 lessons + quizzes (es + ca)
- [x] Module 5 — Equities (diversification, index funds, DCA): 2 lessons + quizzes (es + ca)
- [x] Module 6 — Crypto (risks, volatility, custody): 2 lessons + quizzes (es + ca)
- [x] Module 7 — Basic taxation in Spain: 2 lessons + quizzes (es + ca)
- [x] Module 8 — Investor psychology: 2 lessons + quizzes (es + ca)
- [ ] Content review (Catalan wording, no product recommendations, legal tone)

## Phase 9 — Useful features
- [x] Recurring contribution reminders (local notifications)
- [x] CSV export of transactions
- [x] Biometric/PIN lock (local_auth)

## Future
- [x] Store release (final application id, icon, splash, privacy policy, Play Store listing)
  — assets ready; creating the Play Console app and the closed test is manual (docs/RELEASE.md)
- [ ] iOS release (App Store), built and signed in GitHub Actions since there is no local Mac:
  - [x] Unsigned iOS build in CI; localized display name and Face ID text (es + ca)
  - [x] Signing in CI (API key + own distribution certificate) and upload to TestFlight
  - [x] iPhone screenshots and App Store listing (`store/app-store/`, support page in `site/support/`)
  - [ ] Submit for App Review (manual, App Store Connect)
- [ ] Automatic prices (stock and crypto APIs)
- [ ] Cloud sync
- [ ] Ads (monetization). Checklist before enabling them:
  - [ ] Legal/tax: register the activity in Spain (Hacienda, and self-employed if it
        applies — check with an accountant) and declare ad income
  - [ ] Play Console: switch the EU DSA status from non-trader to **trader** (public name,
        address, phone and email on the listing); tick "Contains ads"; update Data safety
        (advertising ID, device data collected by the ad SDK)
  - [ ] App: add the INTERNET permission and the ad SDK (e.g. AdMob)
  - [ ] EU consent form before personalized ads (Google UMP)
  - [ ] Legal notice (CNMV): block finance, crypto, trading and gambling ad categories so no
        ad looks like a product recommendation; never place ads next to simulations or
        inside lessons
  - [ ] Rewrite the privacy policy (`site/privacy/`) and the listing texts (`store/listing/`):
        both currently promise no internet permission and no data collection
