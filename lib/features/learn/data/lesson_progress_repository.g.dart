// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_progress_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(lessonProgressRepository)
final lessonProgressRepositoryProvider = LessonProgressRepositoryProvider._();

final class LessonProgressRepositoryProvider
    extends
        $FunctionalProvider<
          LessonProgressRepository,
          LessonProgressRepository,
          LessonProgressRepository
        >
    with $Provider<LessonProgressRepository> {
  LessonProgressRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lessonProgressRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lessonProgressRepositoryHash();

  @$internal
  @override
  $ProviderElement<LessonProgressRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LessonProgressRepository create(Ref ref) {
    return lessonProgressRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LessonProgressRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LessonProgressRepository>(value),
    );
  }
}

String _$lessonProgressRepositoryHash() =>
    r'138cdfa40df3707e873c555ce13e3b8c31848d25';
