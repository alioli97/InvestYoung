import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_provider.g.dart';

/// App language. `null` follows the device (falling back to Spanish).
@Riverpod(keepAlive: true)
class AppLocale extends _$AppLocale {
  @override
  Locale? build() => null;

  void set(Locale? locale) => state = locale;
}
