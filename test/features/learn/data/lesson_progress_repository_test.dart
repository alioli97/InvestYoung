import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/db/app_database.dart';
import 'package:invest_young/features/learn/data/lesson_progress_repository.dart';

import '../../../helpers/test_database.dart';

void main() {
  late AppDatabase db;
  late LessonProgressRepository repo;

  setUp(() {
    db = createTestDatabase();
    repo = LessonProgressRepository(db.lessonProgressDao);
  });

  tearDown(() => db.close());

  test('marking read then quiz passed keeps both timestamps', () async {
    final readAt = DateTime.utc(2026, 4, 1);
    final passedAt = DateTime.utc(2026, 4, 2);
    await repo.markRead('m1-l1', at: readAt);
    await repo.markQuizPassed('m1-l1', at: passedAt);

    final status = (await repo.getAll())['m1-l1']!;
    expect(status.readAt, readAt);
    expect(status.quizPassedAt, passedAt);
    expect(status.isRead && status.isQuizPassed, isTrue);
  });

  test('quiz can be passed before the lesson is marked read', () async {
    await repo.markQuizPassed('m2-l1');
    final status = (await repo.getAll())['m2-l1']!;
    expect(status.isQuizPassed, isTrue);
    expect(status.isRead, isFalse);
    expect(status.quizPassedAt!.isUtc, isTrue);
  });

  test('lessons without progress are absent', () async {
    await repo.markRead('m1-l1');
    final all = await repo.getAll();
    expect(all.keys, ['m1-l1']);
  });
}
