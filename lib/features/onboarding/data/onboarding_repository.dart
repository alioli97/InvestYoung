import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/db/app_database.dart';
import '../../goals/data/goals_repository.dart';
import '../../goals/domain/goal.dart';
import '../../goals/domain/goal_type.dart';
import '../domain/onboarding_answers.dart';
import 'profile_repository.dart';

part 'onboarding_repository.g.dart';

/// Localized names for the goals created by onboarding.
typedef OnboardingGoalNames = ({
  String emergency,
  String housing,
  String retirement,
});

/// Default inputs of the goals created from onboarding (docs/SPEC.md §5).
abstract final class GoalDefaults {
  static const housingParams = {'downPaymentPct': 0.20, 'feesPct': 0.10};
  static const retirementParams = {'retirementAge': 67};
  static const retirementReturn = 0.05;
}

/// Persists the result of the onboarding questionnaire.
class OnboardingRepository {
  const OnboardingRepository(this._db, this._profiles, this._goals);

  final AppDatabase _db;
  final ProfileRepository _profiles;
  final GoalsRepository _goals;

  /// Saves profile, expenses and goals atomically.
  ///
  /// Safe to call again when the questionnaire is retaken: the profile,
  /// expenses and emergency goal target are updated, selected goals are only
  /// created if missing, and nothing is ever deleted.
  Future<void> complete(
    OnboardingAnswers answers, {
    required String locale,
    required OnboardingGoalNames names,
    DateTime? now,
  }) {
    final timestamp = (now ?? DateTime.now()).toUtc();
    return _db.transaction(() async {
      final existing = await _profiles.getProfile();
      await _profiles.saveProfile(
        answers.toProfile(
          id: existing?.id,
          locale: locale,
          completedAt: timestamp,
        ),
      );
      await _profiles.replaceExpenses(answers.monthlyExpenses);

      final goals = await _goals.getGoals();
      bool hasType(GoalType type) => goals.any((g) => g.type == type);

      await _saveEmergencyGoal(
        goals.where((g) => g.type == GoalType.emergency).firstOrNull,
        targetCents: answers.emergencyTargetCents!,
        name: names.emergency,
        now: timestamp,
      );
      if (answers.wantsHousing && !hasType(GoalType.housing)) {
        await _goals.addGoal(
          Goal(
            type: GoalType.housing,
            name: names.housing,
            targetCents: 0,
            params: GoalDefaults.housingParams,
            createdAt: timestamp,
          ),
        );
      }
      if (answers.wantsRetirement && !hasType(GoalType.retirement)) {
        await _goals.addGoal(
          Goal(
            type: GoalType.retirement,
            name: names.retirement,
            targetCents: 0,
            expectedAnnualReturn: GoalDefaults.retirementReturn,
            params: GoalDefaults.retirementParams,
            createdAt: timestamp,
          ),
        );
      }
      final customName = answers.customGoalName.trim();
      final customExists = goals.any(
        (g) =>
            g.type == GoalType.custom &&
            g.name.toLowerCase() == customName.toLowerCase(),
      );
      if (answers.wantsCustom && customName.isNotEmpty && !customExists) {
        await _goals.addGoal(
          Goal(
            type: GoalType.custom,
            name: customName,
            targetCents: 0,
            createdAt: timestamp,
          ),
        );
      }
    });
  }

  Future<void> _saveEmergencyGoal(
    Goal? existing, {
    required int targetCents,
    required String name,
    required DateTime now,
  }) async {
    if (existing == null) {
      await _goals.addGoal(
        Goal(
          type: GoalType.emergency,
          name: name,
          targetCents: targetCents,
          createdAt: now,
        ),
      );
      return;
    }
    await _goals.updateGoal(
      Goal(
        id: existing.id,
        type: existing.type,
        name: existing.name,
        targetCents: targetCents,
        targetDate: existing.targetDate,
        expectedAnnualReturn: existing.expectedAnnualReturn,
        params: existing.params,
        createdAt: existing.createdAt,
      ),
    );
  }
}

@Riverpod(keepAlive: true)
OnboardingRepository onboardingRepository(Ref ref) => OnboardingRepository(
  ref.watch(appDatabaseProvider),
  ref.watch(profileRepositoryProvider),
  ref.watch(goalsRepositoryProvider),
);
