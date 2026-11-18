import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/app_theme_mode.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/l10n/locale_provider.dart';
import '../../../core/theme/theme_mode_provider.dart';
import '../../onboarding/data/profile_repository.dart';
import '../domain/contribution_reminder.dart';
import 'reminder_scheduler.dart';

part 'preferences_service.g.dart';

/// Applies language, theme and reminder changes immediately and saves them.
class PreferencesService {
  const PreferencesService(this._ref);

  final Ref _ref;

  ProfileRepository get _profiles => _ref.read(profileRepositoryProvider);
  ReminderScheduler get _scheduler => _ref.read(reminderSchedulerProvider);

  Future<void> setLanguage(String languageCode) async {
    _ref.read(appLocaleProvider.notifier).set(Locale(languageCode));
    await _profiles.updatePreferences(locale: languageCode);
    // The notification text is in the saved language.
    await syncReminder();
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    _ref.read(themePreferenceProvider.notifier).set(mode);
    await _profiles.updatePreferences(themeMode: mode);
  }

  /// Turns the reminder on or changes it (`null` turns it off). Returns
  /// `false`, saving nothing, if notifications are not allowed.
  Future<bool> setReminder(ContributionReminder? reminder) async {
    if (reminder != null && !await _scheduler.requestPermission()) {
      return false;
    }
    await _profiles.updateReminder(reminder);
    await syncReminder();
    return true;
  }

  /// Schedules or cancels the notification to match the saved profile, e.g.
  /// at startup or after importing a backup.
  Future<void> syncReminder() async {
    final profile = await _profiles.getProfile();
    final reminder = profile?.reminder;
    if (reminder == null) return _scheduler.cancel();
    final l10n = lookupAppLocalizations(Locale(profile!.locale));
    await _scheduler.schedule(
      reminder,
      title: l10n.reminderNotificationTitle,
      body: l10n.reminderNotificationBody,
      channelName: l10n.reminderChannelName,
    );
  }
}

@Riverpod(keepAlive: true)
PreferencesService preferencesService(Ref ref) => PreferencesService(ref);
