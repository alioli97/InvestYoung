import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/features/goals/domain/goal.dart';
import 'package:invest_young/features/goals/domain/goal_progress.dart';
import 'package:invest_young/features/goals/domain/goal_type.dart';
import 'package:invest_young/features/investments/domain/asset_summary.dart';
import 'package:invest_young/features/investments/domain/investment_enums.dart';

import '../../../helpers/fixtures.dart';

Goal _goal(
  int id,
  GoalType type, {
  int target = 100000,
  DateTime? date,
  double rate = 0,
}) => Goal(
  id: id,
  type: type,
  name: type.name,
  targetCents: target,
  targetDate: date,
  expectedAnnualReturn: rate,
  createdAt: DateTime.utc(2026),
);

List<AssetSummary> _assets(
  List<(int id, AssetCategory, int? goalId, int cents)> specs,
) => AssetSummary.build(
  [
    for (final (id, category, goalId, _) in specs)
      testAsset(category, id: id, goalId: goalId),
  ],
  [
    for (final (id, _, _, cents) in specs)
      testTx(id, TransactionType.deposit, cents),
  ],
);

void main() {
  final goals = [
    _goal(1, GoalType.emergency, target: 600000),
    _goal(2, GoalType.housing, target: 2000000),
    _goal(3, GoalType.custom, target: 0),
  ];

  group('compute', () {
    final progress = GoalProgress.compute(
      goals,
      _assets([
        (10, AssetCategory.emergency, null, 300000), // → emergency
        (11, AssetCategory.emergency, 2, 50000), // assigned → housing
        (12, AssetCategory.fixedIncome, 1, 100000), // assigned → emergency
        (13, AssetCategory.equity, 2, 200000), // → housing
        (14, AssetCategory.crypto, null, 999999), // → no goal
        (15, AssetCategory.equity, 99, 1), // unknown goal → no goal
      ]),
    );

    test('unassigned emergency assets count for the emergency goal', () {
      expect(progress[0].assets.map((a) => a.asset.id), [10, 12]);
      expect(progress[0].currentCents, 400000);
    });

    test('assigned assets count only for their goal', () {
      expect(progress[1].assets.map((a) => a.asset.id), [11, 13]);
      expect(progress[1].currentCents, 250000);
    });

    test('each asset counts at most once', () {
      final counted = progress.expand((p) => p.assets).map((a) => a.asset.id);
      expect(counted.toSet().length, counted.length);
      expect(counted, isNot(contains(14)));
      expect(counted, isNot(contains(15)));
    });
  });

  group('progress values', () {
    test('ratio, remaining and completion', () {
      final p = GoalProgress.compute([
        _goal(1, GoalType.emergency, target: 600000),
      ], _assets([(10, AssetCategory.emergency, null, 150000)])).single;
      expect(p.ratio, 0.25);
      expect(p.remainingCents, 450000);
      expect(p.isComplete, isFalse);
    });

    test('caps the ratio at 100 % and completes', () {
      final p = GoalProgress.compute([
        _goal(1, GoalType.emergency, target: 100000),
      ], _assets([(10, AssetCategory.emergency, null, 150000)])).single;
      expect(p.ratio, 1);
      expect(p.remainingCents, 0);
      expect(p.isComplete, isTrue);
    });

    test('a goal without target is never complete', () {
      final p = GoalProgress.compute([
        _goal(3, GoalType.custom, target: 0),
      ], const []).single;
      expect(p.hasTarget, isFalse);
      expect(p.ratio, 0);
      expect(p.isComplete, isFalse);
      expect(p.requiredMonthlyCents(DateTime(2026)), isNull);
    });
  });

  group('requiredMonthlyCents', () {
    final now = DateTime(2026, 1, 1);

    test('is null without a target date', () {
      final p = GoalProgress(
        goal: _goal(2, GoalType.housing),
        assets: const [],
      );
      expect(p.requiredMonthlyCents(now), isNull);
      expect(p.monthsLeft(now), isNull);
    });

    test('spreads the remaining amount over the months left', () {
      final p = GoalProgress(
        goal: _goal(2, GoalType.housing, target: 1200000, date: DateTime(2027)),
        assets: const [],
      );
      expect(p.monthsLeft(now), 12);
      expect(p.requiredMonthlyCents(now), 100000);
    });

    test('is 0 once the goal is reached', () {
      final p = GoalProgress.compute([
        _goal(2, GoalType.housing, target: 1000, date: DateTime(2027)),
      ], _assets([(10, AssetCategory.equity, 2, 5000)])).single;
      expect(p.requiredMonthlyCents(now), 0);
    });
  });
}
