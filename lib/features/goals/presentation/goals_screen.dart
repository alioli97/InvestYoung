import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/router/routes.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/empty_state.dart';
import '../domain/goal_progress.dart';
import '../domain/goal_type.dart';
import 'goal_labels.dart';
import 'goals_providers.dart';
import 'widgets/goal_progress_card.dart';

/// Goals tab: progress of every goal and a button to add new ones.
class GoalsScreen extends ConsumerWidget {
  const GoalsScreen({super.key});

  Future<void> _add(BuildContext context, Set<GoalType> existing) async {
    final l10n = context.l10n;
    // Only one housing and one retirement goal; custom goals are unlimited.
    final types = [
      for (final type in [GoalType.housing, GoalType.retirement])
        if (!existing.contains(type)) type,
      GoalType.custom,
    ];
    final type = await showModalBottomSheet<GoalType>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final type in types)
              ListTile(
                leading: Icon(goalIcon(type)),
                title: Text(l10n.goalTypeName(type)),
                onTap: () => Navigator.pop(context, type),
              ),
          ],
        ),
      ),
    );
    if (type != null && context.mounted) context.push(Routes.newGoal(type));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(goalProgressListProvider);
    final existing = <GoalType>{
      for (final p in progress.value ?? const <GoalProgress>[]) p.goal.type,
    };
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.goalsTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _add(context, existing),
        icon: const Icon(Icons.add),
        label: Text(context.l10n.goalsAddGoal),
      ),
      body: AsyncValueView(
        value: progress,
        data: (list) => list.isEmpty
            ? EmptyState(
                icon: Icons.flag_outlined,
                title: context.l10n.goalsEmptyTitle,
                message: context.l10n.goalsEmptyBody,
                actionLabel: context.l10n.goalsAddGoal,
                onAction: () => _add(context, existing),
              )
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                itemCount: list.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, i) => GoalProgressCard(
                  progress: list[i],
                  onTap: () => context.push(Routes.goal(list[i].goal.id!)),
                ),
              ),
      ),
    );
  }
}
