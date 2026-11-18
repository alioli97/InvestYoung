import 'package:decimal/decimal.dart';
import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/db/app_database.dart';
import 'package:invest_young/features/goals/domain/goal_type.dart';
import 'package:invest_young/features/investments/domain/investment_enums.dart';
import 'package:invest_young/features/onboarding/domain/profile_enums.dart';

import '../../helpers/test_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = createTestDatabase();
  });

  tearDown(() => db.close());

  Future<int> insertGoal() => db
      .into(db.goals)
      .insert(
        GoalsCompanion.insert(
          type: GoalType.emergency,
          name: 'Emergency',
          targetCents: 600000,
          createdAt: DateTime.utc(2026, 1, 1),
        ),
      );

  Future<int> insertAsset({int? goalId}) => db
      .into(db.assets)
      .insert(
        AssetsCompanion.insert(
          category: AssetCategory.fixedIncome,
          name: 'Letras',
          goalId: Value(goalId),
          createdAt: DateTime.utc(2026, 1, 2),
        ),
      );

  test('schema version is 3', () {
    expect(db.schemaVersion, 3);
  });

  test('stores user profile enums with stable db values', () async {
    await db
        .into(db.userProfiles)
        .insert(
          UserProfilesCompanion.insert(
            ageRange: AgeRange.from21To25,
            employment: Employment.selfEmployed,
            hasDependents: false,
            hasHighInterestDebt: true,
            debtCents: const Value(150000),
            riskScore: 8,
            riskProfile: RiskProfile.moderate,
            knowledgeLevel: KnowledgeLevel.basic,
            emergencyMonths: 9,
            locale: 'ca',
          ),
        );

    final row = await db.select(db.userProfiles).getSingle();
    expect(row.employment, Employment.selfEmployed);
    expect(row.debtCents, 150000);
    expect(row.monthlyIncomeCents, isNull);

    final raw = await db
        .customSelect('SELECT employment, age_range FROM user_profiles')
        .getSingle();
    expect(raw.read<String>('employment'), 'self_employed');
    expect(raw.read<String>('age_range'), '21_25');
  });

  test('goals use defaults and keep UTC dates', () async {
    await insertGoal();
    final goal = await db.select(db.goals).getSingle();
    expect(goal.paramsJson, '{}');
    expect(goal.expectedAnnualReturn, 0.0);
    expect(goal.createdAt.isUtc, isTrue);
    expect(goal.createdAt, DateTime.utc(2026, 1, 1));
  });

  test('transactions round-trip Decimal quantities as text', () async {
    final assetId = await insertAsset();
    final quantity = Decimal.parse('0.00012345');
    await db
        .into(db.transactions)
        .insert(
          TransactionsCompanion.insert(
            assetId: assetId,
            type: TransactionType.buy,
            date: DateTime.utc(2026, 2, 1),
            amountCents: 1000,
            quantity: Value(quantity),
            feeCents: const Value(15),
          ),
        );

    final tx = await db.select(db.transactions).getSingle();
    expect(tx.quantity, quantity);
    expect(tx.type, TransactionType.buy);

    final raw = await db
        .customSelect('SELECT quantity FROM transactions')
        .getSingle();
    expect(raw.read<String>('quantity'), '0.00012345');
  });

  test('deleting an asset cascades to its transactions', () async {
    final assetId = await insertAsset();
    await db
        .into(db.transactions)
        .insert(
          TransactionsCompanion.insert(
            assetId: assetId,
            type: TransactionType.deposit,
            date: DateTime.utc(2026, 2, 1),
            amountCents: 5000,
          ),
        );

    await (db.delete(db.assets)..where((a) => a.id.equals(assetId))).go();
    expect(await db.select(db.transactions).get(), isEmpty);
  });

  test('deleting a goal unassigns its assets', () async {
    final goalId = await insertGoal();
    await insertAsset(goalId: goalId);

    await (db.delete(db.goals)..where((g) => g.id.equals(goalId))).go();
    final asset = await db.select(db.assets).getSingle();
    expect(asset.goalId, isNull);
  });

  test('rejects transactions for unknown assets', () async {
    expect(
      db
          .into(db.transactions)
          .insert(
            TransactionsCompanion.insert(
              assetId: 999,
              type: TransactionType.deposit,
              date: DateTime.utc(2026, 2, 1),
              amountCents: 1,
            ),
          ),
      throwsA(isA<SqliteException>()),
    );
  });

  test('lesson progress is keyed by lesson id', () async {
    final companion = LessonProgressCompanion.insert(
      lessonId: 'fundamentals-01',
      readAt: Value(DateTime.utc(2026, 3, 1)),
    );
    await db.into(db.lessonProgress).insertOnConflictUpdate(companion);
    await db
        .into(db.lessonProgress)
        .insertOnConflictUpdate(
          companion.copyWith(quizPassedAt: Value(DateTime.utc(2026, 3, 2))),
        );

    final rows = await db.select(db.lessonProgress).get();
    expect(rows, hasLength(1));
    expect(rows.single.quizPassedAt, DateTime.utc(2026, 3, 2));
  });
}
