/// Saved progress for one lesson.
class LessonStatus {
  const LessonStatus({required this.lessonId, this.readAt, this.quizPassedAt});

  final String lessonId;

  /// UTC.
  final DateTime? readAt;

  /// UTC.
  final DateTime? quizPassedAt;

  bool get isRead => readAt != null;
  bool get isQuizPassed => quizPassedAt != null;
}
