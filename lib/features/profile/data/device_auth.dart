import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_auth.g.dart';

/// The device's own lock (fingerprint, face, PIN, pattern or passcode).
abstract interface class DeviceAuth {
  /// Whether this platform offers it at all (not on web).
  bool get isSupported;

  /// Whether the device has a screen lock or biometrics set up.
  Future<bool> isAvailable();

  /// Shows the system prompt; `true` if the user passed it.
  Future<bool> authenticate(String reason);
}

/// [DeviceAuth] backed by `local_auth`.
class LocalDeviceAuth implements DeviceAuth {
  LocalDeviceAuth([LocalAuthentication? auth])
    : _auth = auth ?? LocalAuthentication();

  final LocalAuthentication _auth;

  @override
  bool get isSupported => !kIsWeb;

  @override
  Future<bool> isAvailable() async {
    if (!isSupported) return false;
    try {
      return await _auth.isDeviceSupported();
    } on Object {
      return false;
    }
  }

  @override
  Future<bool> authenticate(String reason) async {
    if (!isSupported) return false;
    try {
      // Biometrics when available, with the device PIN/pattern as fallback.
      return await _auth.authenticate(
        localizedReason: reason,
        persistAcrossBackgrounding: true,
      );
    } on LocalAuthException {
      return false;
    }
  }
}

@Riverpod(keepAlive: true)
DeviceAuth deviceAuth(Ref ref) => LocalDeviceAuth();
