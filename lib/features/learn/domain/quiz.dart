import 'learn_content.dart';

/// Result of answering a lesson quiz.
class QuizResult {
  const QuizResult({required this.correct, required this.total});

  /// Grades [answers] (selected option per question, `null` if unanswered).
  factory QuizResult.grade(List<QuizQuestion> quiz, List<int?> answers) {
    if (answers.length != quiz.length) {
      throw ArgumentError.value(answers, 'answers', 'One per question');
    }
    var correct = 0;
    for (var i = 0; i < quiz.length; i++) {
      if (answers[i] == quiz[i].answer) correct++;
    }
    return QuizResult(correct: correct, total: quiz.length);
  }

  final int correct;
  final int total;

  /// A quiz is passed when every answer is correct.
  bool get passed => total > 0 && correct == total;
}
