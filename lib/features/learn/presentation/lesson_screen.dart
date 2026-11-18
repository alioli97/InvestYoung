import 'package:material_ui/material_ui.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/widgets/async_value_view.dart';
import '../data/learn_repository.dart';
import '../domain/learn_content.dart';
import 'widgets/lesson_actions.dart';

/// Reads a lesson in the current language.
class LessonScreen extends ConsumerWidget {
  const LessonScreen({super.key, required this.lessonId});

  final String lessonId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = Localizations.localeOf(context).languageCode;
    final lesson = ref.watch(learnIndexProvider).value?.lesson(lessonId);
    final markdown = ref.watch(lessonMarkdownProvider(lessonId, language));

    return Scaffold(
      appBar: AppBar(title: Text(lesson?.title.of(language) ?? '')),
      body: AsyncValueView(
        value: markdown,
        data: (text) => ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            if (lesson != null) _ReadingTime(lesson: lesson),
            // The default style sheet follows the (bridged) app theme.
            MarkdownBody(data: text),
            if (lesson != null) LessonActions(lesson: lesson),
          ],
        ),
      ),
    );
  }
}

class _ReadingTime extends StatelessWidget {
  const _ReadingTime({required this.lesson});

  final LessonInfo lesson;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        const Icon(Icons.schedule, size: 16),
        const SizedBox(width: 4),
        Text(
          context.l10n.learnMinutes(lesson.minutes),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    ),
  );
}
