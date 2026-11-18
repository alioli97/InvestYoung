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

`com.alioli97.investyoung` (Android) / `com.alioli97.investyoung` (iOS bundle id). Changing it
makes Android treat the app as a different one.

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
