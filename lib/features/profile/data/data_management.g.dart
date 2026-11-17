// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_management.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dataManagement)
final dataManagementProvider = DataManagementProvider._();

final class DataManagementProvider
    extends $FunctionalProvider<DataManagement, DataManagement, DataManagement>
    with $Provider<DataManagement> {
  DataManagementProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dataManagementProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dataManagementHash();

  @$internal
  @override
  $ProviderElement<DataManagement> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DataManagement create(Ref ref) {
    return dataManagement(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DataManagement value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DataManagement>(value),
    );
  }
}

String _$dataManagementHash() => r'904be6ebdf5471b0db43f4e60caa1f3ce166270f';
