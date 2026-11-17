import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/l10n/locale_provider.dart';
import '../../../../core/widgets/option_tile.dart';
import '../widgets/step_layout.dart';

/// Step 0: language, preselected from the device locale.
class LanguageStep extends ConsumerWidget {
  const LanguageStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final current = Localizations.localeOf(context).languageCode;
    void select(String code) =>
        ref.read(appLocaleProvider.notifier).set(Locale(code));

    return StepLayout(
      title: l10n.onboardingLanguageTitle,
      children: [
        OptionTile(
          label: l10n.onboardingLanguageSpanish,
          selected: current == 'es',
          onTap: () => select('es'),
        ),
        OptionTile(
          label: l10n.onboardingLanguageCatalan,
          selected: current == 'ca',
          onTap: () => select('ca'),
        ),
      ],
    );
  }
}
