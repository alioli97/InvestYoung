// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_lock_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Locks the app on start and when it comes back after [relockAfter] in the
/// background, if the user turned the lock on.

@ProviderFor(AppLock)
final appLockProvider = AppLockProvider._();

/// Locks the app on start and when it comes back after [relockAfter] in the
/// background, if the user turned the lock on.
final class AppLockProvider extends $NotifierProvider<AppLock, AppLockState> {
  /// Locks the app on start and when it comes back after [relockAfter] in the
  /// background, if the user turned the lock on.
  AppLockProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLockProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLockHash();

  @$internal
  @override
  AppLock create() => AppLock();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLockState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLockState>(value),
    );
  }
}

String _$appLockHash() => r'f71d434f7ff351f610c9a840b05214c985993bac';

/// Locks the app on start and when it comes back after [relockAfter] in the
/// background, if the user turned the lock on.

abstract class _$AppLock extends $Notifier<AppLockState> {
  AppLockState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AppLockState, AppLockState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppLockState, AppLockState>,
              AppLockState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
