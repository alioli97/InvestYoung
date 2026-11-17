// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// App language. `null` follows the device (falling back to Spanish).
/// Starts with the language saved in the profile, if any.

@ProviderFor(AppLocale)
final appLocaleProvider = AppLocaleProvider._();

/// App language. `null` follows the device (falling back to Spanish).
/// Starts with the language saved in the profile, if any.
final class AppLocaleProvider extends $NotifierProvider<AppLocale, Locale?> {
  /// App language. `null` follows the device (falling back to Spanish).
  /// Starts with the language saved in the profile, if any.
  AppLocaleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLocaleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLocaleHash();

  @$internal
  @override
  AppLocale create() => AppLocale();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale?>(value),
    );
  }
}

String _$appLocaleHash() => r'51d44ebefacb7c0f9d8bf88019cba29ee65e5dcb';

/// App language. `null` follows the device (falling back to Spanish).
/// Starts with the language saved in the profile, if any.

abstract class _$AppLocale extends $Notifier<Locale?> {
  Locale? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Locale?, Locale?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Locale?, Locale?>,
              Locale?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
