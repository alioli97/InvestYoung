import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/user_profile.dart';

part 'onboarding_status_provider.g.dart';

/// Profile loaded from the database before the app starts (see `main.dart`).
/// `null` when there is none yet; tests can leave it un-overridden.
@Riverpod(keepAlive: true)
UserProfile? startupProfile(Ref ref) => null;

/// Whether the user has completed the onboarding questionnaire.
@Riverpod(keepAlive: true)
class OnboardingStatus extends _$OnboardingStatus {
  @override
  bool build() =>
      ref.read(startupProfileProvider)?.onboardingCompleted ?? false;

  void markCompleted() => state = true;
}
