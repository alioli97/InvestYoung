import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/l10n.dart';
import '../l10n/money_input.dart';

/// Text field for euro amounts. Reports cents, or `null` when empty or invalid.
class MoneyField extends StatefulWidget {
  const MoneyField({
    super.key,
    required this.label,
    required this.onChanged,
    this.initialCents,
    this.helperText,
    this.showZeroAsEmpty = true,
  });

  final String label;
  final ValueChanged<int?> onChanged;
  final int? initialCents;
  final String? helperText;

  /// When `true`, an initial value of 0 shows an empty field with a `0` hint.
  final bool showZeroAsEmpty;

  @override
  State<MoneyField> createState() => _MoneyFieldState();
}

class _MoneyFieldState extends State<MoneyField> {
  late final TextEditingController _controller;
  bool _invalid = false;

  @override
  void initState() {
    super.initState();
    final cents = widget.initialCents;
    final empty = cents == null || (cents == 0 && widget.showZeroAsEmpty);
    _controller = TextEditingController(
      text: empty ? '' : formatCentsForInput(cents),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String text) {
    final cents = parseEurosToCents(text);
    setState(() => _invalid = text.trim().isNotEmpty && cents == null);
    widget.onChanged(cents);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: _onChanged,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: '0',
        suffixText: '€',
        helperText: widget.helperText,
        errorText: _invalid ? context.l10n.commonInvalidAmount : null,
      ),
    );
  }
}
