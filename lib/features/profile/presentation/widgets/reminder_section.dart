import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../onboarding/presentation/profile_providers.dart';
import '../../data/preferences_service.dart';
import '../../data/reminder_scheduler.dart';
import '../../domain/contribution_reminder.dart';
import 'choice_dialog.dart';
import 'section_header.dart';

/// Monthly contribution reminder: on/off, day of the month and time.
/// Hidden where scheduled notifications are not available (web preview).
class ReminderSection extends ConsumerWidget {
  const ReminderSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!ref.watch(reminderSchedulerProvider).isSupported) {
      return const SizedBox.shrink();
    }
    final l10n = context.l10n;
    final reminder = ref.watch(profileProvider).value?.reminder;
    final time = reminder == null ? null : _formatTime(context, reminder);

    Future<void> save(ContributionReminder? value) async {
      final saved = await ref
          .read(preferencesServiceProvider)
          .setReminder(value);
      if (!saved && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.profileReminderPermissionDenied)),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(l10n.profileReminders),
        SwitchListTile(
          secondary: const Icon(Icons.notifications_outlined),
          title: Text(l10n.profileReminderMonthly),
          subtitle: Text(
            reminder == null
                ? l10n.profileReminderOff
                : l10n.profileReminderSchedule(reminder.dayOfMonth, time!),
          ),
          value: reminder != null,
          onChanged: (on) => save(on ? ContributionReminder.initial : null),
        ),
        if (reminder != null) ...[
          ListTile(
            leading: const Icon(Icons.calendar_today_outlined),
            title: Text(l10n.profileReminderDay),
            subtitle: Text(l10n.profileReminderDayOption(reminder.dayOfMonth)),
            onTap: () async {
              final day = await showChoiceDialog(
                context: context,
                title: l10n.profileReminderDay,
                values: [
                  for (var d = 1; d <= ContributionReminder.maxDay; d++) d,
                ],
                selected: reminder.dayOfMonth,
                labelOf: l10n.profileReminderDayOption,
              );
              if (day != null) await save(reminder.copyWith(dayOfMonth: day));
            },
          ),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: Text(l10n.profileReminderTime),
            subtitle: Text(time!),
            onTap: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay(
                  hour: reminder.hour,
                  minute: reminder.minute,
                ),
              );
              if (picked != null) {
                await save(
                  reminder.copyWith(
                    minuteOfDay: picked.hour * 60 + picked.minute,
                  ),
                );
              }
            },
          ),
        ],
      ],
    );
  }

  static String _formatTime(BuildContext context, ContributionReminder r) =>
      MaterialLocalizations.of(context).formatTimeOfDay(
        TimeOfDay(hour: r.hour, minute: r.minute),
        alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context),
      );
}
