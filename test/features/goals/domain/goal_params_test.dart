import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/features/goals/domain/goal_params.dart';
import 'package:invest_young/features/goals/domain/goal_type.dart';

void main() {
  group('computeTarget', () {
    int? target(GoalType type, Map<String, Object?> params) =>
        GoalParams.computeTarget(type, params, monthlyExpensesCents: 100000);

    test('emergency = monthly expenses × months', () {
      expect(target(GoalType.emergency, {'months': 6}), 600000);
      expect(target(GoalType.emergency, {}), isNull);
    });

    test('housing uses default percentages when missing', () {
      expect(target(GoalType.housing, {'homePriceCents': 20000000}), 6000000);
      expect(
        target(GoalType.housing, {
          'homePriceCents': 20000000,
          'downPaymentPct': 0.1,
          'feesPct': 0.12,
        }),
        4400000,
      );
      expect(target(GoalType.housing, {}), isNull);
    });

    test('retirement applies the 4% rule', () {
      expect(
        target(GoalType.retirement, {'monthlySpendingCents': 150000}),
        45000000,
      );
    });

    test('custom goals have a manual target', () {
      expect(target(GoalType.custom, {'months': 6}), isNull);
    });
  });

  group('retirementDate', () {
    final now = DateTime(2026, 11, 17);

    test('adds the years until retirement', () {
      expect(
        GoalParams.retirementDate({'currentAge': 27, 'retirementAge': 67}, now),
        DateTime(2066, 11, 17),
      );
      expect(
        GoalParams.retirementDate({'currentAge': 30}, now),
        DateTime(2063, 11, 17),
      );
    });

    test('is null without age or when already retired', () {
      expect(GoalParams.retirementDate({}, now), isNull);
      expect(
        GoalParams.retirementDate({'currentAge': 70, 'retirementAge': 67}, now),
        isNull,
      );
    });
  });
}
