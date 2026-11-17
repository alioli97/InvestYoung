import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/onboarding/presentation/onboarding_status_provider.dart';
import '../domain/app_theme_mode.dart';

part 'theme_mode_provider.g.dart';

/// Theme preference; starts from the saved profile.
@Riverpod(keepAlive: true)
class ThemePreference extends _$ThemePreference {
  @override
  AppThemeMode build() =>
      ref.read(startupProfileProvider)?.themeMode ?? AppThemeMode.system;

  void set(AppThemeMode mode) => state = mode;
}
