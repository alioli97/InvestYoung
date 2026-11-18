import 'package:material_ui/material_ui.dart';

/// Simple single-choice dialog; returns the chosen value or `null`.
Future<T?> showChoiceDialog<T>({
  required BuildContext context,
  required String title,
  required List<T> values,
  required T selected,
  required String Function(T value) labelOf,
}) => showDialog<T>(
  context: context,
  builder: (context) => SimpleDialog(
    title: Text(title),
    children: [
      for (final value in values)
        ListTile(
          title: Text(labelOf(value)),
          trailing: value == selected
              ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
              : null,
          selected: value == selected,
          onTap: () => Navigator.pop(context, value),
        ),
    ],
  ),
);
