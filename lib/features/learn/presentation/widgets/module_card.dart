import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/router/routes.dart';
import '../../../onboarding/domain/onboarding_logic.dart';
import '../../../onboarding/presentation/onboarding_labels.dart';
import '../../domain/learn_content.dart';

/// A module with its lessons; modules without lessons show "Coming soon".
class ModuleCard extends StatelessWidget {
  const ModuleCard({
    super.key,
    required this.number,
    required this.module,
    required this.recommended,
    this.lessonTrailing,
  });

  final int number;
  final ModuleInfo module;
  final bool recommended;

  /// Optional status icon per lesson (read / quiz passed).
  final Widget? Function(LessonInfo lesson)? lessonTrailing;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final language = Localizations.localeOf(context).languageCode;
    final learnModule = LearnModule.values
        .where((m) => m.id == module.id)
        .firstOrNull;
    final title = learnModule == null
        ? module.id
        : l10n.learnModule(learnModule);

    return Card(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(child: Text('$number')),
              title: Text(title, style: theme.textTheme.titleMedium),
              subtitle: recommended ? Text(l10n.learnRecommended) : null,
              trailing: recommended
                  ? Icon(Icons.star, color: theme.colorScheme.primary)
                  : null,
            ),
            if (module.lessons.isEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(72, 0, 16, 8),
                child: Text(
                  l10n.commonComingSoon,
                  style: theme.textTheme.bodySmall,
                ),
              )
            else
              for (final lesson in module.lessons)
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 72, right: 16),
                  title: Text(lesson.title.of(language)),
                  subtitle: Text(l10n.learnMinutes(lesson.minutes)),
                  trailing: lessonTrailing?.call(lesson),
                  onTap: () => context.push(Routes.lesson(lesson.id)),
                ),
          ],
        ),
      ),
    );
  }
}
