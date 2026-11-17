import 'dart:math' as math;

import '../../../core/utils/dates.dart';
import '../../../core/utils/finance.dart';
import '../../investments/domain/asset_summary.dart';
import '../../investments/domain/investment_enums.dart';
import 'goal.dart';
import 'goal_type.dart';

/// How far a goal is, based on the current value of the assets counted
/// for it (docs/SPEC.md §5).
class GoalProgress {
  const GoalProgress({required this.goal, required this.assets});

  final Goal goal;

  /// Assets counted for this goal.
  final List<AssetSummary> assets;

  int get targetCents => goal.targetCents;

  int get currentCents =>
      assets.fold(0, (sum, a) => sum + a.metrics.currentValueCents);

  /// `false` while the goal has no target yet (e.g. created by onboarding).
  bool get hasTarget => targetCents > 0;

  bool get isComplete => hasTarget && currentCents >= targetCents;

  /// 0–1; 0 when there is no target.
  double get ratio =>
      hasTarget ? (currentCents / targetCents).clamp(0.0, 1.0) : 0;

  int get remainingCents => math.max(0, targetCents - currentCents);

  /// Months left until the target date, or `null` without a date.
  int? monthsLeft(DateTime now) {
    final date = goal.targetDate;
    return date == null ? null : monthsBetween(now, date);
  }

  /// Monthly contribution needed to reach the target on time, or `null`
  /// without a target or a target date.
  int? requiredMonthlyCents(DateTime now) {
    final months = monthsLeft(now);
    if (!hasTarget || months == null) return null;
    return requiredMonthlyContribution(
      targetCents: targetCents,
      currentCents: currentCents,
      annualRate: goal.expectedAnnualReturn,
      months: months,
    );
  }

  /// Progress of every goal. Each asset counts for at most one goal:
  /// - an asset assigned to a goal counts for that goal;
  /// - an unassigned Emergency Fund asset counts for the emergency goal.
  static List<GoalProgress> compute(
    List<Goal> goals,
    List<AssetSummary> assets,
  ) {
    final emergencyId = goals
        .where((g) => g.type == GoalType.emergency)
        .firstOrNull
        ?.id;
    final goalIds = {for (final g in goals) g.id};
    int? goalOf(AssetSummary a) {
      final assigned = a.asset.goalId;
      if (assigned != null && goalIds.contains(assigned)) return assigned;
      return a.asset.category == AssetCategory.emergency ? emergencyId : null;
    }

    return [
      for (final goal in goals)
        GoalProgress(
          goal: goal,
          assets: [
            for (final a in assets)
              if (goal.id != null && goalOf(a) == goal.id) a,
          ],
        ),
    ];
  }
}
