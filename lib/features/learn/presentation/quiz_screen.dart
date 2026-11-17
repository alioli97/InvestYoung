import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/widgets/option_tile.dart';
import '../data/learn_repository.dart';
import '../data/lesson_progress_repository.dart';
import '../domain/learn_content.dart';
import '../domain/quiz.dart';

/// Quiz of a lesson. Passing it (all answers right) is saved as progress.
class QuizScreen extends ConsumerWidget {
  const QuizScreen({super.key, required this.lessonId});

  final String lessonId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lesson = ref.watch(learnIndexProvider).value?.lesson(lessonId);
    if (lesson == null || lesson.quiz.isEmpty) {
      return const Scaffold(body: SizedBox.shrink());
    }
    return _Quiz(lesson: lesson);
  }
}

class _Quiz extends ConsumerStatefulWidget {
  const _Quiz({required this.lesson});

  final LessonInfo lesson;

  @override
  ConsumerState<_Quiz> createState() => _QuizState();
}

class _QuizState extends ConsumerState<_Quiz> {
  late List<int?> _answers = List.filled(widget.lesson.quiz.length, null);
  QuizResult? _result;

  Future<void> _check() async {
    final result = QuizResult.grade(widget.lesson.quiz, _answers);
    setState(() => _result = result);
    if (result.passed) {
      final repo = ref.read(lessonProgressRepositoryProvider);
      await repo.markRead(widget.lesson.id);
      await repo.markQuizPassed(widget.lesson.id);
    }
  }

  void _retry() => setState(() {
    _answers = List.filled(widget.lesson.quiz.length, null);
    _result = null;
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final language = Localizations.localeOf(context).languageCode;
    final quiz = widget.lesson.quiz;
    final result = _result;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.learnQuizTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            widget.lesson.title.of(language),
            style: theme.textTheme.titleMedium,
          ),
          for (final (i, question) in quiz.indexed) ...[
            const SizedBox(height: 16),
            Text(
              '${i + 1}. ${question.question.of(language)}',
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            for (final (j, option) in question.options.indexed)
              OptionTile(
                label: option.of(language),
                selected: _answers[i] == j,
                correct: result == null
                    ? null
                    : j == question.answer
                    ? true
                    : _answers[i] == j
                    ? false
                    : null,
                onTap: result == null
                    ? () => setState(() => _answers[i] = j)
                    : null,
              ),
          ],
          const SizedBox(height: 16),
          if (result != null) _ResultCard(result: result),
          const SizedBox(height: 16),
          if (result == null)
            FilledButton(
              onPressed: _answers.contains(null) ? null : _check,
              child: Text(l10n.learnQuizCheck),
            )
          else if (result.passed)
            FilledButton(
              onPressed: () => context.pop(),
              child: Text(l10n.learnBackToLesson),
            )
          else
            FilledButton(onPressed: _retry, child: Text(l10n.learnQuizRetry)),
        ],
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result});

  final QuizResult result;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;
    return Card(
      color: result.passed ? colors.primaryContainer : colors.errorContainer,
      child: ListTile(
        leading: Icon(result.passed ? Icons.emoji_events : Icons.refresh),
        title: Text(l10n.learnQuizScore(result.correct, result.total)),
        subtitle: Text(
          result.passed ? l10n.learnQuizPassed : l10n.learnQuizFailed,
        ),
      ),
    );
  }
}
