// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learn_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(learnRepository)
final learnRepositoryProvider = LearnRepositoryProvider._();

final class LearnRepositoryProvider
    extends
        $FunctionalProvider<LearnRepository, LearnRepository, LearnRepository>
    with $Provider<LearnRepository> {
  LearnRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'learnRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$learnRepositoryHash();

  @$internal
  @override
  $ProviderElement<LearnRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LearnRepository create(Ref ref) {
    return learnRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LearnRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LearnRepository>(value),
    );
  }
}

String _$learnRepositoryHash() => r'0e475a8e29f6277d8237610def4fd4316d7482bb';

@ProviderFor(learnIndex)
final learnIndexProvider = LearnIndexProvider._();

final class LearnIndexProvider
    extends
        $FunctionalProvider<
          AsyncValue<LearnIndex>,
          LearnIndex,
          FutureOr<LearnIndex>
        >
    with $FutureModifier<LearnIndex>, $FutureProvider<LearnIndex> {
  LearnIndexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'learnIndexProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$learnIndexHash();

  @$internal
  @override
  $FutureProviderElement<LearnIndex> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<LearnIndex> create(Ref ref) {
    return learnIndex(ref);
  }
}

String _$learnIndexHash() => r'64ce4b753e43c3ee2abb70f97abfdb9bf4064a57';

/// Markdown of a lesson in the given language.

@ProviderFor(lessonMarkdown)
final lessonMarkdownProvider = LessonMarkdownFamily._();

/// Markdown of a lesson in the given language.

final class LessonMarkdownProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  /// Markdown of a lesson in the given language.
  LessonMarkdownProvider._({
    required LessonMarkdownFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'lessonMarkdownProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$lessonMarkdownHash();

  @override
  String toString() {
    return r'lessonMarkdownProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument = this.argument as (String, String);
    return lessonMarkdown(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is LessonMarkdownProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$lessonMarkdownHash() => r'856a1bac76ca32a360eddea48306dd90115f3ef2';

/// Markdown of a lesson in the given language.

final class LessonMarkdownFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String>, (String, String)> {
  LessonMarkdownFamily._()
    : super(
        retry: null,
        name: r'lessonMarkdownProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Markdown of a lesson in the given language.

  LessonMarkdownProvider call(String lessonId, String languageCode) =>
      LessonMarkdownProvider._(argument: (lessonId, languageCode), from: this);

  @override
  String toString() => r'lessonMarkdownProvider';
}
