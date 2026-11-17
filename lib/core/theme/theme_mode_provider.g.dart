// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_mode_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Theme preference; starts from the saved profile.

@ProviderFor(ThemePreference)
final themePreferenceProvider = ThemePreferenceProvider._();

/// Theme preference; starts from the saved profile.
final class ThemePreferenceProvider
    extends $NotifierProvider<ThemePreference, AppThemeMode> {
  /// Theme preference; starts from the saved profile.
  ThemePreferenceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themePreferenceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themePreferenceHash();

  @$internal
  @override
  ThemePreference create() => ThemePreference();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppThemeMode>(value),
    );
  }
}

String _$themePreferenceHash() => r'6af271f193596467b6c468fc12d45e3760364d42';

/// Theme preference; starts from the saved profile.

abstract class _$ThemePreference extends $Notifier<AppThemeMode> {
  AppThemeMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AppThemeMode, AppThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppThemeMode, AppThemeMode>,
              AppThemeMode,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
