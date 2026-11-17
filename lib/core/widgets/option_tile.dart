import 'package:flutter/material.dart';

import '../theme/finance_colors.dart';

/// Full-width selectable card, used for single-choice lists of long options.
///
/// With [correct] set (after grading), it shows whether the option was the
/// right one: green check for correct, red cross for a wrong selection.
class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.correct,
  });

  final String label;
  final bool selected;

  /// `null` disables the tile.
  final VoidCallback? onTap;
  final bool? correct;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final finance = FinanceColors.of(context);
    final (icon, iconColor) = switch (correct) {
      true => (Icons.check_circle, finance.positive),
      false when selected => (Icons.cancel, finance.negative),
      _ when selected => (Icons.check_circle, colors.primary),
      _ => (Icons.circle_outlined, colors.outline),
    };
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        color: selected
            ? colors.secondaryContainer
            : colors.surfaceContainerHighest,
        child: ListTile(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          title: Text(label),
          trailing: Icon(icon, color: iconColor),
          selected: selected,
          onTap: onTap,
        ),
      ),
    );
  }
}
