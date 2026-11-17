import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_status_provider.g.dart';

/// Whether the user has completed the onboarding questionnaire.
///
/// In-memory for now; it will be backed by `user_profiles.onboarding_completed_at`
/// once the database exists (Phase 1–2).
@Riverpod(keepAlive: true)
class OnboardingStatus extends _$OnboardingStatus {
  @override
  bool build() => false;

  void markCompleted() => state = true;
}
