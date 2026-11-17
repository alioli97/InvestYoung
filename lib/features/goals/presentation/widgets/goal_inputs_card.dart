import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/formatters.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../onboarding/presentation/profile_providers.dart';
import '../../domain/goal.dart';
import '../../domain/goal_params.dart';
import '../../domain/goal_type.dart';

/// Summary of the inputs the target was computed from.
class GoalInputsCard extends ConsumerWidget {
  const GoalInputsCard({super.key, required this.goal});

  final Goal goal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final p = goal.params;
    String money(String key) =>
        context.formatCurrency(GoalParams.intValue(p, key) ?? 0);
    String percent(String key, double fallback) =>
        context.formatPercent(GoalParams.ratio(p, key) ?? fallback);

    final rows = switch (goal.type) {
      GoalType.emergency => [
        (
          l10n.goalsMonthlyExpenses,
          context.formatCurrency(
            ref.watch(monthlyExpensesTotalProvider).value ?? 0,
          ),
        ),
        if (GoalParams.intValue(p, GoalParams.months) case final m?)
          (l10n.goalsMonthsCovered, l10n.onboardingResultMonths(m)),
      ],
      GoalType.housing when p.containsKey(GoalParams.homePriceCents) => [
        (l10n.goalsHomePrice, money(GoalParams.homePriceCents)),
        (
          l10n.goalsDownPayment,
          percent(GoalParams.downPaymentPct, GoalParams.defaultDownPayment),
        ),
        (l10n.goalsFees, percent(GoalParams.feesPct, GoalParams.defaultFees)),
      ],
      GoalType.retirement when p.containsKey(GoalParams.currentAge) => [
        (
          l10n.goalsCurrentAge,
          '${GoalParams.intValue(p, GoalParams.currentAge)}',
        ),
        (
          l10n.goalsRetirementAge,
          '${GoalParams.intValue(p, GoalParams.retirementAge) ?? GoalParams.defaultRetirementAge}',
        ),
        (l10n.goalsMonthlySpending, money(GoalParams.monthlySpendingCents)),
        (l10n.goalsRetirementRule, ''),
      ],
      _ => <(String, String)>[],
    };
    if (rows.isEmpty) return const SizedBox.shrink();

    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            for (final (label, value) in rows)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(child: Text(label)),
                    if (value.isNotEmpty) Text(value),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
