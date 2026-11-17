// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Whether the user has completed the onboarding questionnaire.
///
/// In-memory for now; it will be backed by `user_profiles.onboarding_completed_at`
/// once the database exists (Phase 1–2).

@ProviderFor(OnboardingStatus)
final onboardingStatusProvider = OnboardingStatusProvider._();

/// Whether the user has completed the onboarding questionnaire.
///
/// In-memory for now; it will be backed by `user_profiles.onboarding_completed_at`
/// once the database exists (Phase 1–2).
final class OnboardingStatusProvider
    extends $NotifierProvider<OnboardingStatus, bool> {
  /// Whether the user has completed the onboarding questionnaire.
  ///
  /// In-memory for now; it will be backed by `user_profiles.onboarding_completed_at`
  /// once the database exists (Phase 1–2).
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

String _$onboardingStatusHash() => r'70d41d11cb688cd686ddff2d231dfbac0eebe8c5';

/// Whether the user has completed the onboarding questionnaire.
///
/// In-memory for now; it will be backed by `user_profiles.onboarding_completed_at`
/// once the database exists (Phase 1–2).

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
