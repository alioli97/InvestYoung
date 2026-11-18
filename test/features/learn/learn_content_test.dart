import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/features/learn/data/learn_repository.dart';
import 'package:invest_young/features/learn/domain/learn_content.dart';
import 'package:invest_young/features/onboarding/domain/onboarding_logic.dart';

/// Validates the shipped content, so a broken index or a missing
/// translation fails the build instead of the app.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const languages = ['es', 'ca'];
  late LearnIndex index;
  final repo = LearnRepository(rootBundle);

  setUpAll(() async => index = await repo.loadIndex());

  void expectTranslated(LocalizedText text, String what) {
    for (final lang in languages) {
      expect(text.values[lang]?.trim(), isNotEmpty, reason: '$what [$lang]');
    }
  }

  test('modules follow the SPEC order and LearnModule ids', () {
    expect(index.modules.map((m) => m.id), LearnModule.values.map((m) => m.id));
  });

  test('lesson ids are unique', () {
    final ids = index.lessons.map((l) => l.id).toList();
    expect(ids.toSet(), hasLength(ids.length));
  });

  test('every lesson is translated and has a 2–3 question quiz', () {
    for (final lesson in index.lessons) {
      expectTranslated(lesson.title, lesson.id);
      expect(lesson.minutes, greaterThan(0));
      expect(lesson.quiz.length, inInclusiveRange(2, 3), reason: lesson.id);
      for (final q in lesson.quiz) {
        expectTranslated(q.question, '${lesson.id} question');
        expect(q.options.length, greaterThanOrEqualTo(2));
        expect(q.answer, inInclusiveRange(0, q.options.length - 1));
        for (final o in q.options) {
          expectTranslated(o, '${lesson.id} option');
        }
      }
    }
  });

  test('every lesson has Markdown in Spanish and Catalan', () async {
    for (final lesson in index.lessons) {
      for (final lang in languages) {
        final text = await repo.loadLesson(lesson, lang);
        expect(text, startsWith('# '), reason: '${lesson.id} [$lang]');
      }
    }
  });

  test('modules 1–4 have two lessons each', () {
    for (final module in index.modules.take(4)) {
      expect(module.lessons, hasLength(2), reason: module.id);
    }
  });

  test('es and ca versions have the same structure', () async {
    List<String> skeleton(String md) => [
      for (final line in md.split('\n'))
        if (line.startsWith('#'))
          line.split(' ').first
        else if (line.startsWith('|'))
          '|'
        else if (line.startsWith('> '))
          '>',
    ];
    for (final lesson in index.lessons) {
      expect(
        skeleton(await repo.loadLesson(lesson, 'ca')),
        skeleton(await repo.loadLesson(lesson, 'es')),
        reason: lesson.id,
      );
    }
  });

  test('LocalizedText falls back to Spanish', () {
    const text = LocalizedText({'es': 'Hola'});
    expect(text.of('ca'), 'Hola');
  });
}
