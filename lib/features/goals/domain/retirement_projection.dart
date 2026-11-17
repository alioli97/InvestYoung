import '../../../core/utils/finance.dart';
import 'goal_params.dart';
import 'goal_progress.dart';

/// Yearly projection of a retirement goal: current capital plus the required
/// monthly contribution, compounded at the goal's expected return.
class RetirementProjection {
  const RetirementProjection({
    required this.points,
    required this.monthlyCents,
    this.startAge,
  });

  /// One point per year (month 0, 12, 24…) plus the final month.
  final List<GrowthPoint> points;
  final int monthlyCents;

  /// Age at month 0, when known, to label the axis with ages.
  final int? startAge;

  GrowthPoint get last => points.last;

  /// `null` when the goal has no target or no time left.
  static RetirementProjection? fromProgress(
    GoalProgress progress,
    DateTime now,
  ) {
    final months = progress.monthsLeft(now);
    final monthly = progress.requiredMonthlyCents(now);
    if (months == null || months == 0 || monthly == null) return null;
    final series = projectGrowth(
      currentCents: progress.currentCents,
      monthlyCents: monthly,
      annualRate: progress.goal.expectedAnnualReturn,
      months: months,
    );
    return RetirementProjection(
      points: [
        for (final p in series)
          if (p.month % 12 == 0 || p.month == months) p,
      ],
      monthlyCents: monthly,
      startAge: GoalParams.intValue(
        progress.goal.params,
        GoalParams.currentAge,
      ),
    );
  }
}
