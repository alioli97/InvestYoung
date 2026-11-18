import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/formatters.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/widgets/label_value_row.dart';
import '../../domain/goal_progress.dart';

/// What is left and how much to contribute per month to arrive on time.
class GoalPlanCard extends StatelessWidget {
  const GoalPlanCard({super.key, required this.progress, this.now});

  final GoalProgress progress;

  /// Reference date (defaults to today), injectable for tests.
  final DateTime? now;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final goal = progress.goal;
    final today = now ?? DateTime.now();

    if (!progress.hasTarget) {
      return Card(
        color: theme.colorScheme.secondaryContainer,
        child: ListTile(
          leading: const Icon(Icons.tune),
          title: Text(l10n.goalsSetUpPrompt),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push(Routes.editGoal(goal.id!)),
        ),
      );
    }

    final targetDate = goal.targetDate;
    final monthly = progress.requiredMonthlyCents(today);
    final months = progress.monthsLeft(today);
    return Card(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelValueRow(
              label: l10n.goalsRemaining,
              value: Text(
                context.formatCurrency(progress.remainingCents),
                style: theme.textTheme.titleSmall,
              ),
            ),
            if (targetDate != null)
              LabelValueRow(
                label: l10n.goalsTargetDate,
                value: Text(
                  context.formatDate(targetDate),
                  style: theme.textTheme.titleSmall,
                ),
              ),
            LabelValueRow(
              label: l10n.goalsExpectedReturn,
              value: Text(
                context.formatPercent(goal.expectedAnnualReturn),
                style: theme.textTheme.titleSmall,
              ),
            ),
            if (monthly != null && !progress.isComplete) ...[
              const Divider(height: 24),
              Text(
                l10n.goalsRequiredMonthly,
                style: theme.textTheme.labelLarge,
              ),
              Text(
                context.formatCurrency(monthly),
                style: theme.textTheme.headlineSmall,
              ),
              if (months == 0)
                Text(l10n.goalsDatePassed, style: theme.textTheme.bodySmall)
              else
                Text(
                  l10n.goalsMonthsLeft(months!),
                  style: theme.textTheme.bodySmall,
                ),
              if (goal.expectedAnnualReturn != 0) ...[
                const SizedBox(height: 8),
                Text(
                  l10n.commonSimulationDisclaimer,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
