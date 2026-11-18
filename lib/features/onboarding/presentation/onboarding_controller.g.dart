// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Step navigation and answers of the onboarding questionnaire.

@ProviderFor(OnboardingController)
final onboardingControllerProvider = OnboardingControllerProvider._();

/// Step navigation and answers of the onboarding questionnaire.
final class OnboardingControllerProvider
    extends $NotifierProvider<OnboardingController, OnboardingFlowState> {
  /// Step navigation and answers of the onboarding questionnaire.
  OnboardingControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingControllerHash();

  @$internal
  @override
  OnboardingController create() => OnboardingController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OnboardingFlowState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OnboardingFlowState>(value),
    );
  }
}

String _$onboardingControllerHash() =>
    r'3de532cae953367ca3b1bfd132cf09c62398be39';

/// Step navigation and answers of the onboarding questionnaire.

abstract class _$OnboardingController extends $Notifier<OnboardingFlowState> {
  OnboardingFlowState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<OnboardingFlowState, OnboardingFlowState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<OnboardingFlowState, OnboardingFlowState>,
              OnboardingFlowState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
