import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/learn_content.dart';

part 'learn_repository.g.dart';

/// Reads the lesson index and lesson Markdown from the app assets.
///
/// Assets are read with `cache: false`: the providers already cache what
/// they need, and the bundle cache would otherwise share futures across
/// widget tests (each with its own fake clock), which then never complete.
class LearnRepository {
  const LearnRepository(this._bundle);

  final AssetBundle _bundle;

  Future<LearnIndex> loadIndex() async => LearnIndex.fromJson(
    jsonDecode(
      await _bundle.loadString('assets/learn/index.json', cache: false),
    ) as Map<String, dynamic>,
  );

  Future<String> loadLesson(LessonInfo lesson, String languageCode) =>
      _bundle.loadString(lesson.assetPath(languageCode), cache: false);
}

@Riverpod(keepAlive: true)
LearnRepository learnRepository(Ref ref) => LearnRepository(rootBundle);

@Riverpod(keepAlive: true)
Future<LearnIndex> learnIndex(Ref ref) =>
    ref.watch(learnRepositoryProvider).loadIndex();

/// Markdown of a lesson in the given language.
@riverpod
Future<String> lessonMarkdown(
  Ref ref,
  String lessonId,
  String languageCode,
) async {
  final index = await ref.watch(learnIndexProvider.future);
  final lesson = index.lesson(lessonId);
  if (lesson == null) throw ArgumentError.value(lessonId, 'lessonId');
  return ref.watch(learnRepositoryProvider).loadLesson(lesson, languageCode);
}
