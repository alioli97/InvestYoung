import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/router/routes.dart';
import '../../data/lesson_progress_repository.dart';
import '../../domain/learn_content.dart';
import '../learn_providers.dart';

/// End of a lesson: mark it as read and take the quiz.
class LessonActions extends ConsumerWidget {
  const LessonActions({super.key, required this.lesson});

  final LessonInfo lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final status = ref.watch(lessonProgressProvider).value?[lesson.id];
    final read = status?.isRead ?? false;
    final passed = status?.isQuizPassed ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(height: 32),
        if (read)
          ListTile(
            leading: const Icon(Icons.check_circle),
            title: Text(l10n.learnRead),
          )
        else
          FilledButton.tonalIcon(
            onPressed: () =>
                ref.read(lessonProgressRepositoryProvider).markRead(lesson.id),
            icon: const Icon(Icons.done),
            label: Text(l10n.learnMarkRead),
          ),
        if (lesson.quiz.isNotEmpty) ...[
          const SizedBox(height: 8),
          if (passed)
            ListTile(
              leading: const Icon(Icons.verified),
              title: Text(l10n.learnQuizPassedShort),
              trailing: TextButton(
                onPressed: () => context.push(Routes.quiz(lesson.id)),
                child: Text(l10n.learnQuizRetake),
              ),
            )
          else
            FilledButton.icon(
              onPressed: () => context.push(Routes.quiz(lesson.id)),
              icon: const Icon(Icons.quiz_outlined),
              label: Text(l10n.learnTakeQuiz),
            ),
        ],
      ],
    );
  }
}
