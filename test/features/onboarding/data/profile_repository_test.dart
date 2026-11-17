import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/db/app_database.dart';
import 'package:invest_young/features/onboarding/data/profile_repository.dart';
import 'package:invest_young/features/onboarding/domain/profile_enums.dart';
import 'package:invest_young/features/onboarding/domain/user_profile.dart';

import '../../../helpers/test_database.dart';

UserProfile _profile({int riskScore = 8, DateTime? completedAt}) => UserProfile(
  ageRange: AgeRange.from26To30,
  employment: Employment.permanent,
  monthlyIncomeCents: 180000,
  hasDependents: false,
  hasHighInterestDebt: false,
  riskScore: riskScore,
  riskProfile: RiskProfile.moderate,
  knowledgeLevel: KnowledgeLevel.basic,
  emergencyMonths: 4,
  locale: 'es',
  onboardingCompletedAt: completedAt,
);

void main() {
  late AppDatabase db;
  late ProfileRepository repo;

  setUp(() {
    db = createTestDatabase();
    repo = ProfileRepository(db.profileDao);
  });

  tearDown(() => db.close());

  test('returns null when there is no profile', () async {
    expect(await repo.getProfile(), isNull);
  });

  test('saves and reads the profile', () async {
    final completedAt = DateTime.utc(2026, 5, 1, 10);
    final id = await repo.saveProfile(_profile(completedAt: completedAt));

    final profile = await repo.getProfile();
    expect(profile!.id, id);
    expect(profile.monthlyIncomeCents, 180000);
    expect(profile.riskProfile, RiskProfile.moderate);
    expect(profile.onboardingCompletedAt, completedAt);
    expect(profile.onboardingCompleted, isTrue);
  });

  test('saving again replaces the single profile', () async {
    final firstId = await repo.saveProfile(_profile());
    final secondId = await repo.saveProfile(_profile(riskScore: 11));

    expect(secondId, firstId);
    expect(await db.select(db.userProfiles).get(), hasLength(1));
    expect((await repo.getProfile())!.riskScore, 11);
  });

  test('replaceExpenses overwrites previous expenses', () async {
    await repo.replaceExpenses(const [
      MonthlyExpense(category: ExpenseCategory.housing, amountCents: 60000),
      MonthlyExpense(category: ExpenseCategory.food, amountCents: 25000),
    ]);
    await repo.replaceExpenses(const [
      MonthlyExpense(category: ExpenseCategory.transport, amountCents: 4000),
    ]);

    final expenses = await repo.getExpenses();
    expect(expenses, hasLength(1));
    expect(expenses.single.category, ExpenseCategory.transport);
    expect(expenses.single.amountCents, 4000);
  });

  test('watchProfile emits updates', () async {
    final stream = repo.watchProfile();
    final expectation = expectLater(
      stream.map((p) => p?.riskScore),
      emitsInOrder([isNull, 8]),
    );
    await Future<void>.delayed(Duration.zero);
    await repo.saveProfile(_profile());
    await expectation;
  });
}
