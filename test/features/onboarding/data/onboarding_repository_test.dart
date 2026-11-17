import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/db/app_database.dart';
import 'package:invest_young/features/goals/data/goals_repository.dart';
import 'package:invest_young/features/goals/domain/goal.dart';
import 'package:invest_young/features/goals/domain/goal_type.dart';
import 'package:invest_young/features/onboarding/data/onboarding_repository.dart';
import 'package:invest_young/features/onboarding/data/profile_repository.dart';
import 'package:invest_young/features/onboarding/domain/onboarding_answers.dart';
import 'package:invest_young/features/onboarding/domain/profile_enums.dart';

import '../../../helpers/test_database.dart';

const _names = (
  emergency: 'Fondo de emergencia',
  housing: 'Entrada de una vivienda',
  retirement: 'Jubilación',
);

const _answers = OnboardingAnswers(
  legalAccepted: true,
  ageRange: AgeRange.from26To30,
  employment: Employment.permanent,
  monthlyIncomeCents: 200000,
  hasDependents: false,
  hasHighInterestDebt: false,
  expenses: {ExpenseCategory.housing: 70000, ExpenseCategory.food: 30000},
  riskAnswers: [3, 3, 3, 3],
  wantsHousing: true,
  wantsCustom: true,
  customGoalName: ' Viaje ',
  knowledgeLevel: KnowledgeLevel.intermediate,
);

void main() {
  late AppDatabase db;
  late ProfileRepository profiles;
  late GoalsRepository goals;
  late OnboardingRepository repo;
  final now = DateTime.utc(2026, 11, 17, 9);

  setUp(() {
    db = createTestDatabase();
    profiles = ProfileRepository(db.profileDao);
    goals = GoalsRepository(db.goalsDao);
    repo = OnboardingRepository(db, profiles, goals);
  });

  tearDown(() => db.close());

  Future<void> complete(OnboardingAnswers answers) =>
      repo.complete(answers, locale: 'ca', names: _names, now: now);

  test('creates profile, expenses and selected goals', () async {
    await complete(_answers);

    final profile = (await profiles.getProfile())!;
    expect(profile.riskProfile, RiskProfile.aggressive);
    expect(profile.emergencyMonths, 5);
    expect(profile.locale, 'ca');
    expect(profile.onboardingCompletedAt, now);

    final expenses = await profiles.getExpenses();
    expect(expenses, hasLength(ExpenseCategory.values.length));
    expect(expenses.fold(0, (sum, e) => sum + e.amountCents), 100000);

    final all = await goals.getGoals();
    expect(all.map((g) => g.type), [
      GoalType.emergency,
      GoalType.housing,
      GoalType.custom,
    ]);
    final emergency = all.first;
    expect(emergency.targetCents, 500000);
    expect(emergency.name, 'Fondo de emergencia');
    expect(all[1].params, GoalDefaults.housingParams);
    expect(all[2].name, 'Viaje');
  });

  test(
    'retaking updates profile and emergency goal without duplicates',
    () async {
      await complete(_answers);
      final firstEmergency = (await goals.getEmergencyGoal())!;

      await complete(
        _answers.copyWith(
          employment: Employment.selfEmployed,
          expenses: {ExpenseCategory.housing: 80000},
          customGoalName: 'viaje',
          wantsRetirement: true,
        ),
      );

      expect(await db.select(db.userProfiles).get(), hasLength(1));
      expect((await profiles.getProfile())!.emergencyMonths, 9);

      final all = await goals.getGoals();
      expect(all.map((g) => g.type), [
        GoalType.emergency,
        GoalType.housing,
        GoalType.custom,
        GoalType.retirement,
      ]);
      final emergency = all.first;
      expect(emergency.id, firstEmergency.id);
      expect(emergency.targetCents, 80000 * 9);
    },
  );

  test('retaking never deletes goals that were deselected', () async {
    await complete(_answers);
    await complete(_answers.copyWith(wantsHousing: false, wantsCustom: false));

    final types = (await goals.getGoals()).map((g) => g.type);
    expect(types, contains(GoalType.housing));
    expect(types, contains(GoalType.custom));
  });

  test('keeps the existing emergency goal settings on retake', () async {
    await complete(_answers);
    final emergency = (await goals.getEmergencyGoal())!;
    await goals.updateGoal(
      Goal(
        id: emergency.id,
        type: GoalType.emergency,
        name: 'Mi colchón',
        targetCents: emergency.targetCents,
        expectedAnnualReturn: 0.02,
        createdAt: emergency.createdAt,
      ),
    );

    await complete(_answers);
    final updated = (await goals.getEmergencyGoal())!;
    expect(updated.name, 'Mi colchón');
    expect(updated.expectedAnnualReturn, 0.02);
  });

  test('rejects incomplete answers without writing anything', () async {
    await expectLater(
      complete(const OnboardingAnswers(legalAccepted: true)),
      throwsStateError,
    );
    expect(await profiles.getProfile(), isNull);
    expect(await goals.getGoals(), isEmpty);
  });
}
