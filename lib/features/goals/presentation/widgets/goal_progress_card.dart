import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/formatters.dart';
import '../../../../core/l10n/l10n.dart';
import '../../domain/goal_progress.dart';
import '../goal_labels.dart';

/// Goal name, progress bar and amounts. Used on Goals and Home.
class GoalProgressCard extends StatelessWidget {
  const GoalProgressCard({
    super.key,
    required this.progress,
    this.onTap,
    this.highlighted = false,
  });

  final GoalProgress progress;
  final VoidCallback? onTap;

  /// Emphasized style (e.g. an incomplete emergency fund on Home).
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final goal = progress.goal;
    return Card(
      color: highlighted
          ? colors.tertiaryContainer
          : colors.surfaceContainerHighest,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ExcludeSemantics(child: Icon(goalIcon(goal.type))),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.goalName(goal),
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  if (progress.isComplete)
                    Icon(
                      Icons.check_circle,
                      color: colors.primary,
                      semanticLabel: l10n.goalsCompleted,
                    )
                  else if (progress.hasTarget)
                    Text(
                      context.formatPercent(progress.ratio, decimalDigits: 0),
                      style: theme.textTheme.titleSmall,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: progress.ratio,
                semanticsLabel: l10n.goalsProgressSemantics(
                  l10n.goalName(goal),
                ),
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 8),
              Text(
                progress.hasTarget
                    ? l10n.goalsProgressAmounts(
                        context.formatCurrency(progress.currentCents),
                        context.formatCurrency(progress.targetCents),
                      )
                    : l10n.goalsNoTarget,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
