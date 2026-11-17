// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goals_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Every goal, oldest first.

@ProviderFor(goals)
final goalsProvider = GoalsProvider._();

/// Every goal, oldest first.

final class GoalsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Goal>>,
          List<Goal>,
          Stream<List<Goal>>
        >
    with $FutureModifier<List<Goal>>, $StreamProvider<List<Goal>> {
  /// Every goal, oldest first.
  GoalsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalsHash();

  @$internal
  @override
  $StreamProviderElement<List<Goal>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Goal>> create(Ref ref) {
    return goals(ref);
  }
}

String _$goalsHash() => r'b9862f36dfa9e48ac3f1d7511976979aaf0cd666';

/// Progress of every goal, updated when goals, assets or transactions change.

@ProviderFor(goalProgressList)
final goalProgressListProvider = GoalProgressListProvider._();

/// Progress of every goal, updated when goals, assets or transactions change.

final class GoalProgressListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<GoalProgress>>,
          List<GoalProgress>,
          FutureOr<List<GoalProgress>>
        >
    with
        $FutureModifier<List<GoalProgress>>,
        $FutureProvider<List<GoalProgress>> {
  /// Progress of every goal, updated when goals, assets or transactions change.
  GoalProgressListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalProgressListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalProgressListHash();

  @$internal
  @override
  $FutureProviderElement<List<GoalProgress>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<GoalProgress>> create(Ref ref) {
    return goalProgressList(ref);
  }
}

String _$goalProgressListHash() => r'acf20b4d19777f869bb5cb050cd0a4e088c974c1';

/// Progress of the emergency goal, or `null` if there is none.

@ProviderFor(emergencyProgress)
final emergencyProgressProvider = EmergencyProgressProvider._();

/// Progress of the emergency goal, or `null` if there is none.

final class EmergencyProgressProvider
    extends
        $FunctionalProvider<
          AsyncValue<GoalProgress?>,
          GoalProgress?,
          FutureOr<GoalProgress?>
        >
    with $FutureModifier<GoalProgress?>, $FutureProvider<GoalProgress?> {
  /// Progress of the emergency goal, or `null` if there is none.
  EmergencyProgressProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emergencyProgressProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emergencyProgressHash();

  @$internal
  @override
  $FutureProviderElement<GoalProgress?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GoalProgress?> create(Ref ref) {
    return emergencyProgress(ref);
  }
}

String _$emergencyProgressHash() => r'ee5fd8c7fa3893f7310cc04ef21402495ad672f8';
