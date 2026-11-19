import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/l10n/l10n.dart';
import 'core/l10n/locale_provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_mode_provider.dart';
import 'features/profile/presentation/lock/app_lock_gate.dart';

class InvestYoungApp extends ConsumerWidget {
  const InvestYoungApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ref.watch(themePreferenceProvider).themeMode,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      // fl_chart and flutter_markdown_plus still read the legacy
      // `package:flutter/material.dart` theme and localizations. Remove the
      // bridge once both have migrated to material_ui.
      builder: (context, child) =>
          // ignore: deprecated_member_use
          MaterialUiCompatibilityBridge(child: AppLockGate(child: child!)),
      locale: ref.watch(appLocaleProvider),
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: _resolveLocale,
      routerConfig: router,
    );
  }

  /// Uses the device language if supported (es/ca), otherwise Spanish.
  static Locale _resolveLocale(Locale? device, Iterable<Locale> supported) {
    for (final locale in supported) {
      if (locale.languageCode == device?.languageCode) return locale;
    }
    return const Locale('es');
  }
}
