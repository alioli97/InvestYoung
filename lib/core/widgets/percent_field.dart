import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../l10n/money_input.dart';

/// Text field for a percentage; reports the value as a ratio (`2,5` → 0.025).
class PercentField extends StatelessWidget {
  const PercentField({
    super.key,
    required this.label,
    required this.initialRatio,
    required this.onChanged,
    this.helperText,
    this.required = false,
  });

  final String label;
  final double? initialRatio;
  final ValueChanged<double?> onChanged;
  final String? helperText;
  final bool required;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final initial = initialRatio;
    return TextFormField(
      initialValue: initial == null ? null : formatRatioForInput(initial),
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: true,
      ),
      decoration: InputDecoration(
        labelText: label,
        helperText: helperText,
        suffixText: '%',
      ),
      validator: (v) {
        if (v == null || v.trim().isEmpty) {
          return required ? l10n.commonRequired : null;
        }
        return parsePercentToRatio(v) == null ? l10n.commonInvalidNumber : null;
      },
      onChanged: (v) => onChanged(parsePercentToRatio(v)),
    );
  }
}
