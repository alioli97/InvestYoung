import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/l10n/l10n.dart';
import 'core/l10n/locale_provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

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
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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
