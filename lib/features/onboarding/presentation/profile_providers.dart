import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/profile_repository.dart';
import '../domain/onboarding_logic.dart';
import '../domain/user_profile.dart';

part 'profile_providers.g.dart';

/// The saved profile (live).
@riverpod
Stream<UserProfile?> profile(Ref ref) =>
    ref.watch(profileRepositoryProvider).watchProfile();

/// Sum of the saved monthly expenses, in cents (live).
@riverpod
Stream<int> monthlyExpensesTotal(Ref ref) => ref
    .watch(profileRepositoryProvider)
    .watchExpenses()
    .map((list) => list.fold(0, (sum, e) => sum + e.amountCents));

/// Recommended emergency fund range for the saved profile.
@riverpod
Future<EmergencyMonthsRange?> recommendedEmergencyRange(Ref ref) async {
  final profile = await ref.watch(profileProvider.future);
  if (profile == null) return null;
  return emergencyMonthsRange(
    riskProfile: profile.riskProfile,
    employment: profile.employment,
    hasDependents: profile.hasDependents,
  );
}
