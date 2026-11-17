import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/router/routes.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../goals/domain/goal_progress.dart';
import '../../goals/domain/goal_type.dart';
import '../../goals/presentation/goals_providers.dart';
import '../../goals/presentation/widgets/goal_progress_card.dart';
import '../../investments/domain/asset_metrics.dart';
import '../../investments/presentation/investments_providers.dart';
import 'widgets/allocation_chart.dart';
import 'widgets/net_worth_card.dart';
import 'widgets/tip_card.dart';

/// Home: net worth, goals (emergency fund first), allocation and a tip.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  /// Emergency goal first; the rest keep their order.
  static List<GoalProgress> _ordered(List<GoalProgress> goals) => [
    ...goals.where((g) => g.goal.type == GoalType.emergency),
    ...goals.where((g) => g.goal.type != GoalType.emergency),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final totals = ref.watch(categoryTotalsProvider);
    final goals = ref.watch(goalProgressListProvider).value ?? const [];
    const gap = SizedBox(height: 12);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.dashboardTitle)),
      body: AsyncValueView(
        value: totals,
        data: (totals) {
          final overall = AssetMetrics.sum(totals.values);
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              NetWorthCard(metrics: overall),
              gap,
              for (final progress in _ordered(goals)) ...[
                GoalProgressCard(
                  progress: progress,
                  highlighted:
                      progress.goal.type == GoalType.emergency &&
                      !progress.isComplete,
                  onTap: () => context.go(Routes.goal(progress.goal.id!)),
                ),
                gap,
              ],
              if (overall.currentValueCents > 0)
                AllocationChart(totals: totals)
              else
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.add_chart),
                    title: Text(l10n.dashboardNoInvestments),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.go(Routes.investments),
                  ),
                ),
              gap,
              const TipCard(),
            ],
          );
        },
      ),
    );
  }
}
