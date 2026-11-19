import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../onboarding/data/profile_repository.dart';
import '../../../onboarding/presentation/onboarding_status_provider.dart';
import '../../data/device_auth.dart';

part 'app_lock_controller.g.dart';

/// Whether the app lock is turned on and whether the app is locked now.
class AppLockState {
  const AppLockState({required this.enabled, required this.locked});

  final bool enabled;
  final bool locked;
}

/// Result of trying to turn the lock on or off.
enum AppLockChange { done, cancelled, unavailable }

/// Locks the app on start and when it comes back after [relockAfter] in the
/// background, if the user turned the lock on.
@Riverpod(keepAlive: true)
class AppLock extends _$AppLock {
  /// Short trips away (copying a number, answering a message) do not lock.
  static const relockAfter = Duration(minutes: 1);

  DateTime? _backgroundSince;

  DeviceAuth get _auth => ref.read(deviceAuthProvider);

  @override
  AppLockState build() {
    final enabled = ref.read(startupProfileProvider)?.appLockEnabled ?? false;
    return AppLockState(enabled: enabled, locked: enabled);
  }

  /// Asks for the device lock and unlocks if it passes. If the device no
  /// longer has any lock set up, unlocks directly so nobody is locked out.
  Future<bool> unlock(String reason) async {
    if (!state.locked) return true;
    final ok = !await _auth.isAvailable() || await _auth.authenticate(reason);
    if (ok) state = AppLockState(enabled: state.enabled, locked: false);
    return ok;
  }

  /// Turning it on or off both require passing the device lock first.
  Future<AppLockChange> setEnabled(
    bool enabled, {
    required String reason,
  }) async {
    if (enabled == state.enabled) return AppLockChange.done;
    if (!await _auth.isAvailable()) {
      return enabled ? AppLockChange.unavailable : _save(enabled);
    }
    if (!await _auth.authenticate(reason)) return AppLockChange.cancelled;
    return _save(enabled);
  }

  Future<AppLockChange> _save(bool enabled) async {
    await ref.read(profileRepositoryProvider).updateAppLock(enabled: enabled);
    state = AppLockState(enabled: enabled, locked: false);
    return AppLockChange.done;
  }

  /// Follows the saved profile after a backup import or delete all, without
  /// locking the user who just did it.
  void sync({required bool enabled}) =>
      state = AppLockState(enabled: enabled, locked: false);

  void wentToBackground(DateTime now) => _backgroundSince ??= now;

  void cameToForeground(DateTime now) {
    final since = _backgroundSince;
    _backgroundSince = null;
    if (state.enabled &&
        since != null &&
        now.difference(since) >= relockAfter) {
      state = const AppLockState(enabled: true, locked: true);
    }
  }
}
