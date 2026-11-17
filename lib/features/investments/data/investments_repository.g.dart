// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investments_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(investmentsRepository)
final investmentsRepositoryProvider = InvestmentsRepositoryProvider._();

final class InvestmentsRepositoryProvider
    extends
        $FunctionalProvider<
          InvestmentsRepository,
          InvestmentsRepository,
          InvestmentsRepository
        >
    with $Provider<InvestmentsRepository> {
  InvestmentsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'investmentsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$investmentsRepositoryHash();

  @$internal
  @override
  $ProviderElement<InvestmentsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  InvestmentsRepository create(Ref ref) {
    return investmentsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InvestmentsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InvestmentsRepository>(value),
    );
  }
}

String _$investmentsRepositoryHash() =>
    r'1334c69e441dd56d7ab6f6474bbc4786c61f2169';
