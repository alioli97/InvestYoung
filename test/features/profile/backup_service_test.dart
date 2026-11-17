import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/db/app_database.dart';
import 'package:invest_young/features/goals/data/goals_repository.dart';
import 'package:invest_young/features/goals/domain/goal.dart';
import 'package:invest_young/features/goals/domain/goal_type.dart';
import 'package:invest_young/features/investments/data/investments_repository.dart';
import 'package:invest_young/features/investments/domain/investment_enums.dart';
import 'package:invest_young/features/learn/data/lesson_progress_repository.dart';
import 'package:invest_young/features/onboarding/data/profile_repository.dart';
import 'package:invest_young/features/onboarding/domain/profile_enums.dart';
import 'package:invest_young/features/onboarding/domain/user_profile.dart';
import 'package:invest_young/features/profile/data/backup_service.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/test_database.dart';

/// Fills every table with some data.
Future<void> _seed(AppDatabase db) async {
  final profiles = ProfileRepository(db.profileDao);
  await profiles.saveProfile(onboardedProfile(locale: 'ca'));
  await profiles.replaceExpenses(const [
    MonthlyExpense(category: ExpenseCategory.food, amountCents: 25000),
  ]);
  final goalId = await GoalsRepository(db.goalsDao).addGoal(
    Goal(
      type: GoalType.housing,
      name: 'Piso',
      targetCents: 6000000,
      targetDate: DateTime.utc(2030, 6, 1, 10),
      expectedAnnualReturn: 0.03,
      params: const {'homePriceCents': 20000000},
      createdAt: DateTime.utc(2026),
    ),
  );
  final investments = InvestmentsRepository(db.investmentsDao);
  final assetId = await investments.addAsset(
    testAsset(AssetCategory.crypto, name: 'BTC', goalId: goalId),
  );
  await investments.addTransaction(
    testTx(assetId, TransactionType.buy, 5000, quantity: '0.00012345'),
  );
  await LessonProgressRepository(
    db.lessonProgressDao,
  ).markQuizPassed('fundamentals-budget', at: DateTime.utc(2026, 3));
}

void main() {
  late AppDatabase source;
  late AppDatabase target;

  setUp(() {
    source = createTestDatabase();
    target = createTestDatabase();
  });

  tearDown(() async {
    await source.close();
    await target.close();
  });

  test('exports every table with the schema version', () async {
    await _seed(source);
    final json =
        jsonDecode(
              await BackupService(
                source,
              ).exportJson(now: DateTime.utc(2026, 11, 18)),
            )
            as Map<String, dynamic>;

    expect(json['app'], 'invest_young');
    expect(json['schemaVersion'], source.schemaVersion);
    expect(json['exportedAt'], '2026-11-18T00:00:00.000Z');
    final tables = json['tables'] as Map<String, dynamic>;
    expect(tables.keys, {
      'user_profiles',
      'monthly_expenses',
      'goals',
      'assets',
      'transactions',
      'lesson_progress',
    });
    for (final rows in tables.values) {
      expect(rows, hasLength(1));
    }
  });

  test('export → import restores identical data', () async {
    await _seed(source);
    final backup = await BackupService(source).exportJson();
    await BackupService(target).importJson(backup);

    expect(
      await BackupService(target).exportJson(now: DateTime.utc(2026)),
      await BackupService(source).exportJson(now: DateTime.utc(2026)),
    );

    final tx = await InvestmentsRepository(
      target.investmentsDao,
    ).getTransactions();
    expect(tx.single.quantity, Decimal.parse('0.00012345'));
    final goal = (await GoalsRepository(target.goalsDao).getGoals()).single;
    expect(goal.targetDate, DateTime.utc(2030, 6, 1, 10));
    expect(goal.params['homePriceCents'], 20000000);
  });

  test('import replaces existing data', () async {
    await _seed(source);
    await GoalsRepository(target.goalsDao).addGoal(
      Goal(
        type: GoalType.custom,
        name: 'Old',
        targetCents: 1,
        createdAt: DateTime.utc(2025),
      ),
    );
    await BackupService(
      target,
    ).importJson(await BackupService(source).exportJson());
    final names = (await GoalsRepository(
      target.goalsDao,
    ).getGoals()).map((g) => g.name);
    expect(names, ['Piso']);
  });

  group('rejects invalid backups and keeps the data', () {
    Future<void> expectRejected(String json) async {
      await _seed(target);
      await expectLater(
        BackupService(target).importJson(json),
        throwsA(isA<BackupFormatException>()),
      );
      expect(await target.select(target.goals).get(), hasLength(1));
      expect(await target.select(target.transactions).get(), hasLength(1));
    }

    Map<String, Object?> valid() => {
      'app': 'invest_young',
      'schemaVersion': 2,
      'tables': {'goals': <Object?>[]},
    };

    test('not JSON', () => expectRejected('not json'));

    test(
      'another app',
      () => expectRejected(jsonEncode({...valid(), 'app': 'x'})),
    );

    test(
      'a newer schema',
      () => expectRejected(jsonEncode({...valid(), 'schemaVersion': 99})),
    );

    test(
      'an unknown table',
      () => expectRejected(
        jsonEncode({
          ...valid(),
          'tables': {'secrets': <Object?>[]},
        }),
      ),
    );

    test(
      'an unknown column (no SQL injection through keys)',
      () => expectRejected(
        jsonEncode({
          ...valid(),
          'tables': {
            'goals': [
              {'id": 1); DROP TABLE goals; --': 1},
            ],
          },
        }),
      ),
    );

    test(
      'rows that break constraints',
      () => expectRejected(
        jsonEncode({
          ...valid(),
          'tables': {
            'transactions': [
              {
                'asset_id': 999,
                'type': 'deposit',
                'date': '2026-01-01T00:00:00.000Z',
                'amount_cents': 1,
              },
            ],
          },
        }),
      ),
    );
  });

  test('deleteAll empties every table', () async {
    await _seed(source);
    await BackupService(source).deleteAll();
    final json =
        jsonDecode(await BackupService(source).exportJson())
            as Map<String, dynamic>;
    for (final rows in (json['tables'] as Map<String, dynamic>).values) {
      expect(rows, isEmpty);
    }
  });
}
