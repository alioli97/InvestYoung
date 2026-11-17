import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/router/routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.quiz_outlined),
            title: Text(l10n.profileRetakeQuestionnaire),
            subtitle: Text(l10n.profileRetakeQuestionnaireSubtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(Routes.retakeOnboarding),
          ),
        ],
      ),
    );
  }
}
