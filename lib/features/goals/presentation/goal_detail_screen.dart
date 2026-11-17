import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/router/routes.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../investments/presentation/widgets/asset_tile.dart';
import '../domain/goal_progress.dart';
import '../domain/goal_type.dart';
import '../domain/retirement_projection.dart';
import 'goals_providers.dart';
import 'widgets/assign_assets_dialog.dart';
import 'widgets/goal_inputs_card.dart';
import 'widgets/goal_plan_card.dart';
import 'widgets/goal_progress_card.dart';
import 'widgets/retirement_chart.dart';

/// One goal: progress, plan, inputs and the assets counted for it.
class GoalDetailScreen extends ConsumerWidget {
  const GoalDetailScreen({super.key, required this.goalId});

  final int goalId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueView(
      value: ref.watch(goalProgressListProvider),
      data: (list) {
        final progress = list.where((p) => p.goal.id == goalId).firstOrNull;
        return progress == null
            ? const Scaffold(body: SizedBox.shrink())
            : _GoalDetail(progress: progress);
      },
    );
  }
}

class _GoalDetail extends StatelessWidget {
  const _GoalDetail({required this.progress});

  final GoalProgress progress;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final goal = progress.goal;
    final theme = Theme.of(context);
    final projection = goal.type == GoalType.retirement
        ? RetirementProjection.fromProgress(progress, DateTime.now())
        : null;
    return Scaffold(
      appBar: AppBar(
        title: Text(goal.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: l10n.goalsEditGoal,
            onPressed: () => context.push(Routes.editGoal(goal.id!)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          GoalProgressCard(progress: progress),
          const SizedBox(height: 12),
          GoalPlanCard(progress: progress),
          const SizedBox(height: 12),
          GoalInputsCard(goal: goal),
          if (projection != null) ...[
            const SizedBox(height: 12),
            RetirementChart(projection: projection),
          ],
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.goalsAssignedAssets,
                  style: theme.textTheme.titleMedium,
                ),
              ),
              TextButton.icon(
                onPressed: () => showAssignAssetsDialog(context, goal),
                icon: const Icon(Icons.link),
                label: Text(l10n.goalsAssignAssets),
              ),
            ],
          ),
          if (goal.type == GoalType.emergency)
            Text(
              l10n.goalsEmergencyAutoAssets,
              style: theme.textTheme.bodySmall,
            ),
          if (progress.assets.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(l10n.goalsNoAssets, textAlign: TextAlign.center),
            )
          else
            for (final summary in progress.assets)
              AssetTile(
                summary: summary,
                onTap: () => context.go(Routes.asset(summary.asset.id!)),
              ),
        ],
      ),
    );
  }
}
