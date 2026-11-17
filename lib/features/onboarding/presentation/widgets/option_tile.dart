import 'package:flutter/material.dart';

/// Full-width selectable card, used for single-choice lists of long options.
class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
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
          trailing: Icon(
            selected ? Icons.check_circle : Icons.circle_outlined,
            color: selected ? colors.primary : colors.outline,
          ),
          selected: selected,
          onTap: onTap,
        ),
      ),
    );
  }
}
