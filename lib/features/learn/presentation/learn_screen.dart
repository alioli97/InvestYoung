import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../onboarding/domain/onboarding_logic.dart';
import '../../onboarding/presentation/profile_providers.dart';
import '../data/learn_repository.dart';
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

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.learnTitle)),
      body: AsyncValueView(
        value: index,
        data: (index) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: index.modules.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, i) => ModuleCard(
            number: i + 1,
            module: index.modules[i],
            recommended: recommended.contains(index.modules[i].id),
          ),
        ),
      ),
    );
  }
}
