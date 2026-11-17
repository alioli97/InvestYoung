import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/onboarding/presentation/onboarding_status_provider.dart';

part 'locale_provider.g.dart';

/// App language. `null` follows the device (falling back to Spanish).
/// Starts with the language saved in the profile, if any.
@Riverpod(keepAlive: true)
class AppLocale extends _$AppLocale {
  @override
  Locale? build() {
    final saved = ref.read(startupProfileProvider)?.locale;
    return saved == null ? null : Locale(saved);
  }

  void set(Locale? locale) => state = locale;
}
