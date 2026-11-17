// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_editor.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(goalEditor)
final goalEditorProvider = GoalEditorProvider._();

final class GoalEditorProvider
    extends $FunctionalProvider<GoalEditor, GoalEditor, GoalEditor>
    with $Provider<GoalEditor> {
  GoalEditorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalEditorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalEditorHash();

  @$internal
  @override
  $ProviderElement<GoalEditor> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoalEditor create(Ref ref) {
    return goalEditor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoalEditor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoalEditor>(value),
    );
  }
}

String _$goalEditorHash() => r'11c9fdf585991c044a67b88466b2e3b0af8b84fe';
