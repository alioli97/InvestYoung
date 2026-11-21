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

