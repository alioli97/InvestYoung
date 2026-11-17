// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The saved profile (live).

@ProviderFor(profile)
final profileProvider = ProfileProvider._();

/// The saved profile (live).

final class ProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserProfile?>,
          UserProfile?,
          Stream<UserProfile?>
        >
    with $FutureModifier<UserProfile?>, $StreamProvider<UserProfile?> {
  /// The saved profile (live).
  ProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileHash();

  @$internal
  @override
  $StreamProviderElement<UserProfile?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<UserProfile?> create(Ref ref) {
    return profile(ref);
  }
}

String _$profileHash() => r'e765f2e7adefed9ec4b3465ce530ea4015f44772';

/// Sum of the saved monthly expenses, in cents (live).

@ProviderFor(monthlyExpensesTotal)
final monthlyExpensesTotalProvider = MonthlyExpensesTotalProvider._();

/// Sum of the saved monthly expenses, in cents (live).

final class MonthlyExpensesTotalProvider
    extends $FunctionalProvider<AsyncValue<int>, int, Stream<int>>
    with $FutureModifier<int>, $StreamProvider<int> {
  /// Sum of the saved monthly expenses, in cents (live).
  MonthlyExpensesTotalProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'monthlyExpensesTotalProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$monthlyExpensesTotalHash();

  @$internal
  @override
  $StreamProviderElement<int> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int> create(Ref ref) {
    return monthlyExpensesTotal(ref);
  }
}

String _$monthlyExpensesTotalHash() =>
    r'71d2ff41cdc03cfd1fb495aefa183ecd3f6d3e2a';

/// Recommended emergency fund range for the saved profile.

@ProviderFor(recommendedEmergencyRange)
final recommendedEmergencyRangeProvider = RecommendedEmergencyRangeProvider._();

/// Recommended emergency fund range for the saved profile.

final class RecommendedEmergencyRangeProvider
    extends
        $FunctionalProvider<
          AsyncValue<EmergencyMonthsRange?>,
          EmergencyMonthsRange?,
          FutureOr<EmergencyMonthsRange?>
        >
    with
        $FutureModifier<EmergencyMonthsRange?>,
        $FutureProvider<EmergencyMonthsRange?> {
  /// Recommended emergency fund range for the saved profile.
  RecommendedEmergencyRangeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recommendedEmergencyRangeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recommendedEmergencyRangeHash();

  @$internal
  @override
  $FutureProviderElement<EmergencyMonthsRange?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EmergencyMonthsRange?> create(Ref ref) {
    return recommendedEmergencyRange(ref);
  }
}

String _$recommendedEmergencyRangeHash() =>
    r'0ec8a4d446ebe6fcefe6176415c384394e624fd6';
