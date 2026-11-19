import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/app_theme_mode.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/theme_mode_provider.dart';
import '../data/preferences_service.dart';
import 'app_version_provider.dart';
import 'widgets/choice_dialog.dart';
import 'widgets/data_section.dart';
import 'widgets/reminder_section.dart';
import 'widgets/security_section.dart';
import 'widgets/section_header.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final language = Localizations.localeOf(context).languageCode;
    final theme = ref.watch(themePreferenceProvider);
    final preferences = ref.read(preferencesServiceProvider);
    final version = ref.watch(appVersionProvider).value;

    String languageName(String code) => code == 'ca'
        ? l10n.onboardingLanguageCatalan
        : l10n.onboardingLanguageSpanish;
    String themeName(AppThemeMode mode) => switch (mode) {
      AppThemeMode.system => l10n.profileThemeSystem,
      AppThemeMode.light => l10n.profileThemeLight,
      AppThemeMode.dark => l10n.profileThemeDark,
    };

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: ListView(
        children: [
          SectionHeader(l10n.profilePreferences),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.profileLanguage),
            subtitle: Text(languageName(language)),
            onTap: () async {
              final code = await showChoiceDialog(
                context: context,
                title: l10n.profileLanguage,
                values: const ['es', 'ca'],
                selected: language,
                labelOf: languageName,
              );
              if (code != null) await preferences.setLanguage(code);
            },
          ),
          ListTile(
            leading: const Icon(Icons.brightness_6_outlined),
            title: Text(l10n.profileTheme),
            subtitle: Text(themeName(theme)),
            onTap: () async {
              final mode = await showChoiceDialog(
                context: context,
                title: l10n.profileTheme,
                values: AppThemeMode.values,
                selected: theme,
                labelOf: themeName,
              );
              if (mode != null) await preferences.setThemeMode(mode);
            },
          ),
          const ReminderSection(),
          const SecuritySection(),
          SectionHeader(l10n.profileYourData),
          ListTile(
            leading: const Icon(Icons.quiz_outlined),
            title: Text(l10n.profileRetakeQuestionnaire),
            subtitle: Text(l10n.profileRetakeQuestionnaireSubtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(Routes.retakeOnboarding),
          ),
          const DataSection(),
          SectionHeader(l10n.profileInformation),
          ListTile(
            leading: const Icon(Icons.gavel_outlined),
            title: Text(l10n.commonLegalNoticeTitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(Routes.legalNotice),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(l10n.profileAbout),
            onTap: () => showAboutDialog(
              context: context,
              applicationName: l10n.appTitle,
              applicationVersion: version,
              applicationIcon: Icon(
                Icons.savings_outlined,
                size: 40,
                color: Theme.of(context).colorScheme.primary,
              ),
              children: [Text(l10n.profileAboutBody)],
            ),
          ),
        ],
      ),
    );
  }
}
