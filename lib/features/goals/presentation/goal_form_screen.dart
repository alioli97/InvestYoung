import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/formatters.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/l10n/money_input.dart';
import '../../../core/router/routes.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/date_field.dart';
import '../../../core/widgets/percent_field.dart';
import '../../onboarding/presentation/profile_providers.dart';
import '../data/goal_editor.dart';
import '../domain/goal.dart';
import '../domain/goal_params.dart';
import '../domain/goal_type.dart';
import 'goal_labels.dart';
import 'goals_providers.dart';
import 'widgets/goal_type_fields.dart';

/// Creates a goal of a type, or edits an existing goal.
class GoalFormScreen extends ConsumerWidget {
  const GoalFormScreen.create({super.key, required GoalType type})
    : _type = type,
      _goalId = null;

  const GoalFormScreen.edit({super.key, required int goalId})
    : _goalId = goalId,
      _type = null;

  final GoalType? _type;
  final int? _goalId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = _goalId;
    if (id == null) return _GoalForm(type: _type!);
    return AsyncValueView(
      value: ref.watch(goalsProvider),
      data: (goals) {
        final goal = goals.where((g) => g.id == id).firstOrNull;
        return goal == null
            ? const Scaffold(body: SizedBox.shrink())
            : _GoalForm(type: goal.type, initial: goal);
      },
    );
  }
}

class _GoalForm extends ConsumerStatefulWidget {
  const _GoalForm({required this.type, this.initial});

  final GoalType type;
  final Goal? initial;

  @override
  ConsumerState<_GoalForm> createState() => _GoalFormState();
}

class _GoalFormState extends ConsumerState<_GoalForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name =
      widget.initial?.name ??
      (widget.type == GoalType.custom
          ? ''
          : context.l10n.goalTypeName(widget.type));
  late Map<String, Object?> _params = {...?widget.initial?.params};
  late DateTime? _targetDate = widget.initial?.targetDate?.toLocal();
  late double? _rate =
      widget.initial?.expectedAnnualReturn ??
      (widget.type == GoalType.retirement
          ? GoalParams.defaultRetirementReturn
          : 0);
  late int? _customTargetCents = widget.type == GoalType.custom
      ? widget.initial?.targetCents
      : null;
  bool _saving = false;

  bool get _isEdit => widget.initial != null;

  /// Live target from the inputs (manual for custom goals).
  int? _target(int monthlyExpenses) => widget.type == GoalType.custom
      ? _customTargetCents
      : GoalParams.computeTarget(
          widget.type,
          _params,
          monthlyExpensesCents: monthlyExpenses,
        );

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final now = DateTime.now();
    final expenses = ref.read(monthlyExpensesTotalProvider).value ?? 0;
    var params = _params;
    if (widget.type == GoalType.emergency &&
        GoalParams.intValue(params, GoalParams.months) == null) {
      final range = ref.read(recommendedEmergencyRangeProvider).value;
      params = {...params, GoalParams.months: range?.defaultMonths ?? 6};
    }
    final targetDate = widget.type == GoalType.retirement
        ? GoalParams.retirementDate(params, now)
        : _targetDate;
    final base =
        widget.initial ??
        Goal(
          type: widget.type,
          name: '',
          targetCents: 0,
          createdAt: now.toUtc(),
        );
    final goal = base.copyWith(
      name: _name.trim(),
      targetCents: widget.type == GoalType.custom
          ? _customTargetCents
          : GoalParams.computeTarget(
              widget.type,
              params,
              monthlyExpensesCents: expenses,
            ),
      targetDate: () => targetDate == null
          ? null
          : DateTime(
              targetDate.year,
              targetDate.month,
              targetDate.day,
              12,
            ).toUtc(),
      expectedAnnualReturn: _rate ?? 0,
      params: params,
    );

    setState(() => _saving = true);
    final router = GoRouter.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    try {
      await ref.read(goalEditorProvider).save(goal);
      router.pop();
    } on Exception {
      messenger.showSnackBar(SnackBar(content: Text(l10n.commonSaveError)));
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _delete() async {
    final l10n = context.l10n;
    final router = GoRouter.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.goalsDeleteTitle),
        content: Text(l10n.goalsDeleteBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(goalEditorProvider).delete(widget.initial!.id!);
    router.go(Routes.goals);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final expenses = ref.watch(monthlyExpensesTotalProvider).value ?? 0;
    final target = _target(expenses);
    final type = widget.type;
    const gap = SizedBox(height: 16);
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? l10n.goalsEditGoal : l10n.goalsNewGoal),
        actions: [
          if (_isEdit && type != GoalType.emergency)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: l10n.commonDelete,
              onPressed: _saving ? null : _delete,
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              initialValue: _name,
              maxLength: 40,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: l10n.goalsFieldName),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? l10n.commonRequired : null,
              onChanged: (v) => _name = v,
            ),
            GoalTypeFields(
              type: type,
              params: _params,
              onChanged: (p) => setState(() => _params = p),
            ),
            if (type == GoalType.custom)
              TextFormField(
                initialValue: _customTargetCents == null
                    ? null
                    : formatCentsForInput(_customTargetCents!),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: l10n.goalsTargetAmount,
                  suffixText: '€',
                ),
                validator: (v) {
                  final cents = parseEurosToCents(v ?? '');
                  if (cents == null) return l10n.commonInvalidAmount;
                  return cents == 0 ? l10n.investmentsAmountPositive : null;
                },
                onChanged: (v) =>
                    setState(() => _customTargetCents = parseEurosToCents(v)),
              ),
            if (type != GoalType.retirement) ...[
              gap,
              FormField<DateTime>(
                initialValue: _targetDate,
                validator: (_) =>
                    type == GoalType.housing && _targetDate == null
                    ? l10n.commonRequired
                    : null,
                builder: (field) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DateField(
                      label: type == GoalType.housing
                          ? l10n.goalsTargetDate
                          : '${l10n.goalsTargetDate} (${l10n.commonOptional.toLowerCase()})',
                      value: _targetDate,
                      firstDate: DateTime.now(),
                      clearable: type != GoalType.housing,
                      onChanged: (d) {
                        setState(() => _targetDate = d);
                        field.didChange(d);
                      },
                    ),
                    if (field.errorText case final error?)
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 4),
                        child: Text(
                          error,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
            gap,
            PercentField(
              label: l10n.goalsExpectedReturn,
              helperText: l10n.goalsExpectedReturnHelp,
              initialRatio: _rate,
              onChanged: (r) => _rate = r,
            ),
            gap,
            if (target != null && type != GoalType.custom)
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: ListTile(
                  title: Text(l10n.goalsComputedTarget),
                  trailing: Text(
                    context.formatCurrency(target),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: Text(l10n.commonSave),
            ),
          ],
        ),
      ),
    );
  }
}
