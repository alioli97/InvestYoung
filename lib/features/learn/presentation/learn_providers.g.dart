// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learn_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Saved progress per lesson id (live).

@ProviderFor(lessonProgress)
final lessonProgressProvider = LessonProgressProvider._();

/// Saved progress per lesson id (live).

final class LessonProgressProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, LessonStatus>>,
          Map<String, LessonStatus>,
          Stream<Map<String, LessonStatus>>
        >
    with
        $FutureModifier<Map<String, LessonStatus>>,
        $StreamProvider<Map<String, LessonStatus>> {
  /// Saved progress per lesson id (live).
  LessonProgressProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lessonProgressProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lessonProgressHash();

  @$internal
  @override
  $StreamProviderElement<Map<String, LessonStatus>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Map<String, LessonStatus>> create(Ref ref) {
    return lessonProgress(ref);
  }
}

String _$lessonProgressHash() => r'5df6e373f99b61a93401dc404865795e015dfb00';
