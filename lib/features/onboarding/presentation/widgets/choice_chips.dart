import 'package:flutter/material.dart';

/// Single-choice group of chips.
class ChoiceChips<T> extends StatelessWidget {
  const ChoiceChips({
    super.key,
    required this.values,
    required this.selected,
    required this.labelOf,
    required this.onSelected,
  });

  final List<T> values;
  final T? selected;
  final String Function(T value) labelOf;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final value in values)
          ChoiceChip(
            label: Text(labelOf(value)),
            selected: value == selected,
            onSelected: (_) => onSelected(value),
          ),
      ],
    );
  }
}

/// Yes/No choice. `null` means unanswered.
class YesNoChips extends StatelessWidget {
  const YesNoChips({
    super.key,
    required this.value,
    required this.yesLabel,
    required this.noLabel,
    required this.onChanged,
  });

  final bool? value;
  final String yesLabel;
  final String noLabel;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return ChoiceChips<bool>(
      values: const [true, false],
      selected: value,
      labelOf: (v) => v ? yesLabel : noLabel,
      onSelected: onChanged,
    );
  }
}
