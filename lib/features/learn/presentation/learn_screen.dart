import 'package:material_ui/material_ui.dart';

import '../../../core/l10n/l10n.dart';
import 'widgets/lessons_tab.dart';
import 'widgets/tips_tab.dart';

/// Learn tab: lessons by module and quick tips.
class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.learnTitle),
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.learnLessonsTab),
              Tab(text: l10n.learnTipsTab),
            ],
          ),
        ),
        body: const TabBarView(children: [LessonsTab(), TipsTab()]),
      ),
    );
  }
}
