import 'package:material_ui/material_ui.dart';

import '../l10n/formatters.dart';
import '../l10n/l10n.dart';

/// Read-only field that opens a date picker. Works with calendar dates
/// (local midnight); callers convert to UTC when storing timestamps.
class DateField extends StatelessWidget {
  const DateField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.firstDate,
    this.lastDate,
    this.clearable = false,
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool clearable;

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: value ?? now,
      firstDate: firstDate ?? DateTime(now.year - 50),
      lastDate: lastDate ?? DateTime(now.year + 50),
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final current = value;
    return InkWell(
      onTap: () => _pick(context),
      borderRadius: BorderRadius.circular(4),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: clearable && current != null
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  tooltip: context.l10n.commonClear,
                  onPressed: () => onChanged(null),
                )
              : const Icon(Icons.calendar_today_outlined),
        ),
        isEmpty: current == null,
        child: current == null ? null : Text(context.formatShortDate(current)),
      ),
    );
  }
}
