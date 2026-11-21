# Google Play listing

Store listing texts, one file per language (`es.md` = default listing, `ca.md` = Catalan
translation). Paste each section into Play Console → Grow users → Store presence → Main store
listing. Limits: app name 30 characters, short description 80, full description 4000.
Check them with `python3 store/listing/check.py`.

Rules (see CLAUDE.md, legal notice): educational tone, no specific products recommended, no
promises of returns, no "best"/ranking claims (also a Play metadata policy).

## Graphics

- App icon (512×512): `branding/play_store_icon_512.png`.
- Feature graphic (1024×500): `store/graphics/feature_graphic_{es,ca}.png`, rendered from
  `store/graphics/feature_graphic.html?lang=es|ca` (replace `ROBOTO_DIR` with the Flutter SDK's
  `bin/cache/artifacts/material_fonts` path, open it in a 1024 px wide window and screenshot
  the 1024×500 block; headless Chrome works).
- Phone screenshots (1080×1920): `store/screenshots/{es,ca}/`, five per language, rendered
  from the real screens with sample data:
  `flutter test store/screenshots/screenshots_test.dart --update-goldens`.
  Regenerate them when the UI changes.
