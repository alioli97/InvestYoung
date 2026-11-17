import 'package:drift/drift.dart';

import '../../../core/db/app_database.dart';
import '../../../core/db/tables.dart';

part 'lesson_progress_dao.g.dart';

@DriftAccessor(tables: [LessonProgress])
class LessonProgressDao extends DatabaseAccessor<AppDatabase>
    with _$LessonProgressDaoMixin {
  LessonProgressDao(super.attachedDatabase);

  Future<List<LessonProgressRow>> getAll() => select(lessonProgress).get();

  Stream<List<LessonProgressRow>> watchAll() => select(lessonProgress).watch();

  /// Inserts or updates only the columns present in [entry].
  Future<void> upsert(LessonProgressCompanion entry) =>
      into(lessonProgress).insert(
        entry,
        onConflict: DoUpdate((_) => entry, target: [lessonProgress.lessonId]),
      );
}
