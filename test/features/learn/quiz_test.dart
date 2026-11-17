import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/features/learn/domain/learn_content.dart';
import 'package:invest_young/features/learn/domain/quiz.dart';

const _option = LocalizedText({'es': 'x'});

QuizQuestion _q(int answer) => QuizQuestion(
  question: _option,
  options: const [_option, _option, _option],
  answer: answer,
);

void main() {
  final quiz = [_q(0), _q(2), _q(1)];

  test('passes only with every answer correct', () {
    final result = QuizResult.grade(quiz, [0, 2, 1]);
    expect(result.correct, 3);
    expect(result.passed, isTrue);
  });

  test('counts correct answers and fails otherwise', () {
    final result = QuizResult.grade(quiz, [0, 1, null]);
    expect(result.correct, 1);
    expect(result.total, 3);
    expect(result.passed, isFalse);
  });

  test('requires one answer per question', () {
    expect(() => QuizResult.grade(quiz, [0]), throwsArgumentError);
  });

  test('an empty quiz is never passed', () {
    expect(QuizResult.grade(const [], const []).passed, isFalse);
  });
}
