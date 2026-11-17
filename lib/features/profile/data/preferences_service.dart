import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/app_theme_mode.dart';
import '../../../core/l10n/locale_provider.dart';
import '../../../core/theme/theme_mode_provider.dart';
import '../../onboarding/data/profile_repository.dart';

part 'preferences_service.g.dart';

/// Applies language and theme changes immediately and saves them.
class PreferencesService {
  const PreferencesService(this._ref);

  final Ref _ref;

  Future<void> setLanguage(String languageCode) async {
    _ref.read(appLocaleProvider.notifier).set(Locale(languageCode));
    await _ref
        .read(profileRepositoryProvider)
        .updatePreferences(locale: languageCode);
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    _ref.read(themePreferenceProvider.notifier).set(mode);
    await _ref
        .read(profileRepositoryProvider)
        .updatePreferences(themeMode: mode);
  }
}

@Riverpod(keepAlive: true)
PreferencesService preferencesService(Ref ref) => PreferencesService(ref);
