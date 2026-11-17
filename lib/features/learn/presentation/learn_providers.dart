import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/lesson_progress_repository.dart';
import '../domain/lesson_status.dart';

part 'learn_providers.g.dart';

/// Saved progress per lesson id (live).
@riverpod
Stream<Map<String, LessonStatus>> lessonProgress(Ref ref) =>
    ref.watch(lessonProgressRepositoryProvider).watchAll();
