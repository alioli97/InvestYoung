import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../goals/presentation/goals_providers.dart';
import '../../../goals/presentation/goal_labels.dart';

/// Optional goal assignment for an asset.
class GoalDropdown extends ConsumerWidget {
  const GoalDropdown({super.key, required this.value, required this.onChanged});

  final int? value;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goals = ref.watch(goalsProvider).value ?? const [];
    // Ignore a stale id (e.g. a deleted goal) instead of failing the assert.
    final selected = goals.any((g) => g.id == value) ? value : null;
    return DropdownButtonFormField<int?>(
      key: ValueKey(goals.length),
      initialValue: selected,
      decoration: InputDecoration(labelText: context.l10n.investmentsFieldGoal),
      items: [
        DropdownMenuItem(child: Text(context.l10n.investmentsNoGoal)),
        for (final goal in goals)
          DropdownMenuItem(
            value: goal.id,
            child: Text(context.l10n.goalName(goal)),
          ),
      ],
      onChanged: onChanged,
    );
  }
}
