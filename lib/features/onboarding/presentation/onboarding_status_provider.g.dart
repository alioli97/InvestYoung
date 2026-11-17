// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Profile loaded from the database before the app starts (see `main.dart`).
/// `null` when there is none yet; tests can leave it un-overridden.

@ProviderFor(startupProfile)
final startupProfileProvider = StartupProfileProvider._();

/// Profile loaded from the database before the app starts (see `main.dart`).
/// `null` when there is none yet; tests can leave it un-overridden.

final class StartupProfileProvider
    extends $FunctionalProvider<UserProfile?, UserProfile?, UserProfile?>
    with $Provider<UserProfile?> {
  /// Profile loaded from the database before the app starts (see `main.dart`).
  /// `null` when there is none yet; tests can leave it un-overridden.
  StartupProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'startupProfileProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$startupProfileHash();

  @$internal
  @override
  $ProviderElement<UserProfile?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserProfile? create(Ref ref) {
    return startupProfile(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserProfile? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserProfile?>(value),
    );
  }
}

String _$startupProfileHash() => r'd13f62ece5c8eb3eda97e5518118ee029fb3aa39';

/// Whether the user has completed the onboarding questionnaire.

@ProviderFor(OnboardingStatus)
final onboardingStatusProvider = OnboardingStatusProvider._();

/// Whether the user has completed the onboarding questionnaire.
final class OnboardingStatusProvider
    extends $NotifierProvider<OnboardingStatus, bool> {
  /// Whether the user has completed the onboarding questionnaire.
  OnboardingStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingStatusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingStatusHash();

  @$internal
  @override
  OnboardingStatus create() => OnboardingStatus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$onboardingStatusHash() => r'7f267d4c82d166388f2ecee2fdb7cc261ced183d';

/// Whether the user has completed the onboarding questionnaire.

abstract class _$OnboardingStatus extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
