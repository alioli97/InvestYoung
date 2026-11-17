import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/db/app_database.dart';
import '../domain/lesson_status.dart';
import 'lesson_progress_dao.dart';

part 'lesson_progress_repository.g.dart';

class LessonProgressRepository {
  const LessonProgressRepository(this._dao);

  final LessonProgressDao _dao;

  Future<Map<String, LessonStatus>> getAll() async =>
      _toMap(await _dao.getAll());

  /// Progress of every lesson that has any, keyed by lesson id.
  Stream<Map<String, LessonStatus>> watchAll() => _dao.watchAll().map(_toMap);

  /// Marks [lessonId] as read at [at] (UTC now by default).
  Future<void> markRead(String lessonId, {DateTime? at}) => _dao.upsert(
    LessonProgressCompanion(
      lessonId: Value(lessonId),
      readAt: Value((at ?? DateTime.now()).toUtc()),
    ),
  );

  /// Marks the quiz of [lessonId] as passed at [at] (UTC now by default).
  Future<void> markQuizPassed(String lessonId, {DateTime? at}) => _dao.upsert(
    LessonProgressCompanion(
      lessonId: Value(lessonId),
      quizPassedAt: Value((at ?? DateTime.now()).toUtc()),
    ),
  );

  static Map<String, LessonStatus> _toMap(List<LessonProgressRow> rows) => {
    for (final r in rows)
      r.lessonId: LessonStatus(
        lessonId: r.lessonId,
        readAt: r.readAt,
        quizPassedAt: r.quizPassedAt,
      ),
  };
}

@Riverpod(keepAlive: true)
LessonProgressRepository lessonProgressRepository(Ref ref) =>
    LessonProgressRepository(ref.watch(appDatabaseProvider).lessonProgressDao);
