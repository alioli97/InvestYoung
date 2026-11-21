# App Store listing

Store listing texts, one file per language (`es.md` = primary language, Spanish (Spain);
`ca.md` = Catalan localization). Paste each section into App Store Connect → the app →
iOS App → version page (name and subtitle are in **App Information**). Limits: name 30,
subtitle 30, promotional text 170, keywords 100 (comma-separated, no spaces after commas),
description 4000. Check them with `python3 store/app-store/check.py`.

Same rules as the Play listing (see CLAUDE.md, legal notice): educational tone, no specific
products recommended, no promises of returns, no "best"/ranking claims.

## Screenshots

6.9" iPhone (1290×2796), five per language: `store/screenshots/ios/{es,ca}/`. Regenerate with
`flutter test store/screenshots/screenshots_test.dart --update-goldens`, then
`python3 store/screenshots/flatten_ios.py` (App Store Connect rejects transparency).
The app is iPhone-only (`TARGETED_DEVICE_FAMILY = 1`), so no iPad screenshots are needed.

## App Store Connect answers

**App Information**
- Category: primary **Education**, secondary **Finance**. Education first on purpose: under
  guideline 5.1.1(ix), apps that provide financial services must come from a legal entity;
  this app only teaches and tracks what the user types in, and the category should say so.
- Content rights: no third-party content.
- Age rating: answer **None/No** to every question (no gambling, no user-generated content,
  no web access, no medical content). Expected result: 4+.
- EU Digital Services Act: **non-trader** (same as Google Play; switch to trader before
  adding ads, see ROADMAP).

**Pricing and Availability**
- Price: free (USD 0).
- Availability: the content is in Spanish and Catalan and the taxation module is about
  Spain; all territories is fine, Spain (and Andorra) is the minimum.

**App Privacy**
- Privacy policy URL: `https://alioli97.github.io/InvestYoung/privacy/`
- Data collection: **No, we do not collect data from this app.**

**Version page**
- Support URL: `https://alioli97.github.io/InvestYoung/support/`
- Marketing URL: leave empty.
- Copyright: `2026 Arnau Alió Parull`
- Build: the latest TestFlight build (Actions → iOS → Run workflow).
- Export compliance: answered in `Info.plist` (`ITSAppUsesNonExemptEncryption = false`).

**App Review Information**
- Sign-in required: **no**.
- Contact: name, phone and email of the developer (private, only for Apple).
- Notes (paste as is):

  > Educational personal finance app for young people in Spain. It does not provide
  > financial services, trading, accounts or advice: users type in their own savings and
  > investments, and the app computes goals and shows lessons. All data stays on the
  > device; the app makes no network requests. No login is needed: on first launch, answer
  > the short questionnaire (any values) to reach the main screens. The app lock
  > (Face ID / passcode) and the monthly reminder are optional, in Profile. The UI is in
  > Spanish and Catalan.

**Version release**: manual or automatic after approval (developer's choice).
