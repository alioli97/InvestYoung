import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/features/goals/domain/goal.dart';
import 'package:invest_young/features/goals/domain/goal_progress.dart';
import 'package:invest_young/features/goals/domain/goal_type.dart';
import 'package:invest_young/features/goals/domain/retirement_projection.dart';

GoalProgress _retirement({DateTime? date, int target = 45000000}) =>
    GoalProgress(
      goal: Goal(
        id: 1,
        type: GoalType.retirement,
        name: 'Jubilación',
        targetCents: target,
        targetDate: date,
        expectedAnnualReturn: 0.05,
        params: const {'currentAge': 30, 'retirementAge': 67},
        createdAt: DateTime.utc(2026),
      ),
      assets: const [],
    );

void main() {
  final now = DateTime(2026, 1, 1);

  test('samples one point per year and reaches the target', () {
    final projection = RetirementProjection.fromProgress(
      _retirement(date: DateTime(2063, 7, 1)),
      now,
    )!;
    // 37,5 years = 450 months → years 0..37 plus month 450.
    expect(projection.points.first.month, 0);
    expect(projection.points[1].month, 12);
    expect(projection.points.last.month, 450);
    expect(projection.points, hasLength(39));
    expect(projection.last.valueCents, greaterThanOrEqualTo(45000000));
    expect(projection.last.contributedCents, projection.monthlyCents * 450);
    expect(projection.startAge, 30);
  });

  test('is null without a date, a target or time left', () {
    expect(RetirementProjection.fromProgress(_retirement(), now), isNull);
    expect(
      RetirementProjection.fromProgress(
        _retirement(date: DateTime(2060), target: 0),
        now,
      ),
      isNull,
    );
    expect(
      RetirementProjection.fromProgress(_retirement(date: DateTime(2025)), now),
      isNull,
    );
  });
}
