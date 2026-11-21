# Release guide

The app is shared as an APK with family and friends (no store release yet).

## Signing

Release builds are signed with a private key that lives **outside the repository**:

- Keystore: `~/.android/invest_young-release.jks` (alias `invest_young`).
- `android/key.properties` (gitignored) holds the passwords and the keystore path:

  ```properties
  storePassword=...
  keyPassword=...
  keyAlias=invest_young
  storeFile=/absolute/path/to/invest_young-release.jks
  ```

Without `key.properties`, release builds fall back to the debug key so CI and fresh clones
still build — but those APKs **cannot update** an install signed with the release key.

**Back up the keystore and `key.properties` somewhere safe** (e.g. a password manager).
If the key is lost, every user has to uninstall the app (export a backup first) and install
a newly signed build.

## Application id

`com.alioli97.investyoung` (Android) / `com.alioli97.investyoung` (iOS bundle id).

**This id is final — do not change it.** It is the id used for the Google Play release, and Play
never allows changing it once an app is published: a new id is a different app (new listing,
no updates for existing users, and the closed-testing requirement — 12 testers for 14 days on
personal accounts — starts over).

When enrolling in Play App Signing, upload the existing release keystore as the app signing key
(Play Console → "Use existing key" / PEPK export) instead of letting Google generate one, so
APKs already installed from the sideloaded releases can update from Play.

## Versioning

`version` in `pubspec.yaml` is `name+build` (e.g. `1.0.1+2`). Before every APK you share:

- bump the build number (`+N`) — Android refuses to install a lower one over a higher one;
- bump the name (`1.0.1` → `1.0.2`, or `1.1.0` for new features);
- add an entry to `CHANGELOG.md`.

The installed version is shown in Profile → About.

## Building

```bash
flutter build apk --release
# → build/app/outputs/flutter-apk/app-release.apk
```

Requires a JDK 17+ (`flutter config --jdk-dir <path>` if `java` is not on the PATH).

## APK from CI

`.github/workflows/apk.yml` builds the release APK on every push to `main` (and on PRs that
touch the Android build) and uploads it as an artifact named
`InvertirSiendoJoven-<version>-<release|debug>` (kept 30 days): GitHub → Actions → APK → run →
Artifacts. It can also be started by hand ("Run workflow").

It signs with the release key when these repository secrets exist:

- `ANDROID_KEYSTORE_BASE64`: `base64 -w0 ~/.android/invest_young-release.jks`
- `ANDROID_KEYSTORE_PASSWORD`: the store/key password from `android/key.properties`

Without them the artifact is debug-signed (`-debug` suffix) and cannot update a release install.

### App Bundle for Google Play

With the signing secrets, the same run also builds the Android App Bundle that Google Play needs
and uploads it as a second artifact, `InvertirSiendoJoven-<version>-release-play`, containing:

- `InvertirSiendoJoven-<version>-release.aab`: upload it in Play Console → Test and release →
  your track → Create new release;
- `mapping.txt` (when R8 produced one): upload it as the deobfuscation file of that release.

No bundle is built without the secrets, since Play rejects debug-signed bundles. Locally:
`flutter build appbundle --release` (needs the Android SDK `cmdline-tools` component to strip
native debug symbols).


## Google Play (manual steps)

Everything the listing needs is in the repository; these steps happen in Play Console.

1. **Developer account** (personal, one-off 25 USD, identity verification), opened with the
   owner's personal Google account (private, not recorded here). The **public contact email**
   for the listing is the dedicated `alio.studios.games@gmail.com`, the same one the privacy
   policy shows; never use the personal address in public fields.
2. **Create the app**: default language Spanish (es-ES), app, free.
3. **Play App Signing**: choose to use the existing key and upload the release keystore
   (Play Console's PEPK export), so sideloaded installs keep updating.
4. **App content**:
   - Privacy policy URL: https://alioli97.github.io/InvestYoung/privacy/
   - Data safety: no data collected, no data shared (everything stays on the device; the
     release build has no INTERNET permission).
   - Ads: no. Target audience: 18+. Content rating questionnaire: finance/education app,
     no user-generated content.
   - Financial features: none of the regulated ones (no loans, payments or trading);
     the app is educational and only tracks what the user types in.
5. **Store listing** (es-ES, plus a ca-ES translation): texts in `store/listing/`, graphics
   in `branding/play_store_icon_512.png`, `store/graphics/` and `store/screenshots/`.
6. **Closed test**: upload the `.aab` from the CI artifact `…-release-play` to a closed
   testing track; testers join through a Google Group. Personal accounts need at least 12
   testers opted in for 14 consecutive days before applying for production access.
7. **Production**: apply for access, answer the questionnaire, then roll out.

## iOS (App Store / TestFlight)

There is no local Mac: iOS builds run on GitHub Actions macOS runners (`ios.yml`).
PRs and pushes to `main` build the app unsigned. A signed build is uploaded to TestFlight
by running the workflow by hand: **Actions → iOS → Run workflow**.

The archive is signed automatically by Xcode through an App Store Connect API key; the
export re-signs it for distribution with the certificate and profile stored as secrets
(never in the repository). One-time setup:

1. Register at least one device (Certificates, IDs & Profiles → Devices). Automatic
   signing needs it to issue the development profile used at archive time; without a Mac,
   read the iPhone's UDID on Linux with `idevice_id -l` (package `libimobiledevice-utils`).
   Testers do not need registered devices: TestFlight works on any iPhone.
2. Register the bundle id `com.alioli97.investyoung` (Certificates, IDs & Profiles →
   Identifiers), with no extra capabilities.
3. Create the app in App Store Connect with that bundle id (primary language Spanish).
4. Create a team API key with the **Admin** role (Users and Access → Integrations →
   App Store Connect API) and download the `.p8` file (it can only be downloaded once).
5. Store the GitHub secrets: `APPSTORE_API_KEY` (contents of the `.p8`), `APPSTORE_KEY_ID`,
   `APPSTORE_ISSUER_ID` and `APPLE_TEAM_ID`.
6. Distribution certificate and App Store profile. Apple's cloud-managed distribution
   signing cannot be used: it writes the accented name of the certificate ("Alió") in a
   different Unicode form than the certificate itself, and App Store Connect rejects the
   upload (ITMS-90035, "does not satisfy its designated Requirement"). So the export signs
   on the runner with our own certificate:
   - Create a private key and a CSR outside the repository (`~/ios-signing`):
     `openssl genrsa -out dist.key 2048` and
     `openssl req -new -key dist.key -out dist.csr -subj "/CN=Arnau Alio/C=ES"`.
   - Certificates → + → **Apple Distribution**, upload `dist.csr`, download the `.cer`.
   - Build the `.p12`: `openssl x509 -inform der -in distribution.cer -out dist.pem` and
     `openssl pkcs12 -export -legacy -inkey dist.key -in dist.pem -out dist.p12`.
   - Profiles → + → **App Store Connect**, bundle id `com.alioli97.investyoung`, that
     certificate; download the `.mobileprovision`.
   - Secrets: `IOS_DIST_P12_BASE64` (`base64 -w0 dist.p12`), `IOS_DIST_P12_PASSWORD` and
     `IOS_APPSTORE_PROFILE_BASE64` (`base64 -w0` of the profile). The certificate and the
     profile expire after one year: renew them and update the secrets.

Listing texts, screenshots and every App Store Connect answer (category, age rating, privacy,
review notes): `store/app-store/README.md`. The app is iPhone-only.

The version name comes from `pubspec.yaml`; the build number is `100 + run number` of the
workflow, so every upload gets a new one. After the upload, Apple processes the build
(roughly 10–30 minutes) before it shows up in TestFlight.

