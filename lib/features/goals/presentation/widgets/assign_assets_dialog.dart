import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../investments/data/investments_repository.dart';
import '../../../investments/domain/asset.dart';
import '../../../investments/presentation/investments_providers.dart';
import '../../domain/goal.dart';
import '../goals_providers.dart';
import '../goal_labels.dart';

/// Lets the user pick which assets are assigned to [goal].
Future<void> showAssignAssetsDialog(BuildContext context, Goal goal) =>
    showDialog<void>(
      context: context,
      builder: (context) => _AssignAssetsDialog(goal: goal),
    );

class _AssignAssetsDialog extends ConsumerStatefulWidget {
  const _AssignAssetsDialog({required this.goal});

  final Goal goal;

  @override
  ConsumerState<_AssignAssetsDialog> createState() =>
      _AssignAssetsDialogState();
}

class _AssignAssetsDialogState extends ConsumerState<_AssignAssetsDialog> {
  Set<int>? _selected;
  bool _saving = false;

  Future<void> _save(List<Asset> assets) async {
    setState(() => _saving = true);
    final repo = ref.read(investmentsRepositoryProvider);
    final goalId = widget.goal.id;
    for (final asset in assets) {
      final want = _selected!.contains(asset.id);
      final has = asset.goalId == goalId;
      if (want && !has) await repo.updateAsset(asset.withGoal(goalId));
      if (!want && has) await repo.updateAsset(asset.withGoal(null));
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final assets = ref.watch(assetsProvider).value;
    final goals = ref.watch(goalsProvider).value ?? const [];
    final goalId = widget.goal.id;
    _selected ??= assets == null
        ? null
        : {
            for (final a in assets)
              if (a.goalId == goalId) a.id!,
          };

    String? otherGoal(Asset asset) =>
        asset.goalId == null || asset.goalId == goalId
        ? null
        : switch (goals.where((g) => g.id == asset.goalId).firstOrNull) {
            final goal? => l10n.goalName(goal),
            null => null,
          };

    return AlertDialog(
      title: Text(l10n.goalsAssignAssets),
      content: SizedBox(
        width: double.maxFinite,
        child: assets == null
            ? const Center(child: CircularProgressIndicator())
            : assets.isEmpty
            ? Text(l10n.goalsNoAssetsToAssign)
            : ListView(
                shrinkWrap: true,
                children: [
                  for (final asset in assets)
                    CheckboxListTile(
                      value: _selected!.contains(asset.id),
                      title: Text(asset.name),
                      subtitle: otherGoal(asset) == null
                          ? null
                          : Text(l10n.goalsAssignedTo(otherGoal(asset)!)),
                      onChanged: (v) => setState(() {
                        v == true
                            ? _selected!.add(asset.id!)
                            : _selected!.remove(asset.id);
                      }),
                    ),
                ],
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(
          onPressed: assets == null || _saving ? null : () => _save(assets),
          child: Text(l10n.commonSave),
        ),
      ],
    );
  }
}
