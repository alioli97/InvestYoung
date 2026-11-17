import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../onboarding/domain/onboarding_logic.dart';
import '../../onboarding/presentation/profile_providers.dart';
import '../data/learn_repository.dart';
import 'learn_providers.dart';
import 'widgets/learn_progress_card.dart';
import 'widgets/module_card.dart';

/// Learn tab: modules and their lessons, recommended ones marked.
class LearnScreen extends ConsumerWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(learnIndexProvider);
    final level = ref.watch(profileProvider).value?.knowledgeLevel;
    final recommended = level == null
        ? const <String>{}
        : {for (final m in recommendedModules(level)) m.id};
    final progress = ref.watch(lessonProgressProvider).value ?? const {};

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.learnTitle)),
      body: AsyncValueView(
        value: index,
        data: (index) {
          final lessons = index.lessons.toList();
          final read = lessons
              .where((l) => progress[l.id]?.isRead ?? false)
              .length;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              LearnProgressCard(read: read, total: lessons.length),
              for (final (i, module) in index.modules.indexed) ...[
                const SizedBox(height: 12),
                ModuleCard(
                  number: i + 1,
                  module: module,
                  recommended: recommended.contains(module.id),
                  lessonTrailing: (lesson) => switch (progress[lesson.id]) {
                    final s? when s.isQuizPassed => const Icon(Icons.verified),
                    final s? when s.isRead => const Icon(Icons.check_circle),
                    _ => null,
                  },
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
