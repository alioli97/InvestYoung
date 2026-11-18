import 'package:flutter/material.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/widgets/legal_notice_card.dart';

/// Legal notice, accessible at any time from Profile.
class LegalNoticeScreen extends StatelessWidget {
  const LegalNoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.commonLegalNoticeTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const LegalNoticeCard(showTitle: false),
          const SizedBox(height: 16),
          Text(l10n.profileLegalSimulations),
        ],
      ),
    );
  }
}
