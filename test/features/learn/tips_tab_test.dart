import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:invest_young/features/learn/presentation/widgets/tips_tab.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/pump_app.dart';

final _tipsList = find
    .descendant(of: find.byType(TipsTab), matching: find.byType(Scrollable))
    .first;

Future<void> _openTips(WidgetTester tester, String locale) async {
  await pumpApp(
    tester,
    locale: Locale(locale),
    startupProfile: onboardedProfile(locale: locale),
  );
  await tester.tap(find.byIcon(Icons.school_outlined));
  await tester.pump();
  await pumpUntilFound(
    tester,
    find.text(locale == 'es' ? 'Consejos rápidos' : 'Consells ràpids'),
  );
  await tester.tap(
    find.text(locale == 'es' ? 'Consejos rápidos' : 'Consells ràpids'),
  );
  await tester.pump();
}

void main() {
  testWidgets('lists the tips with the tip of the day first', (tester) async {
    await _openTips(tester, 'es');
    await pumpUntilFound(tester, find.text('Consejo del día'));

    expect(find.text('Consejo del día'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text(
        'Las rentabilidades pasadas no garantizan rentabilidades futuras.',
      ),
      200,
      scrollable: _tipsList,
    );
  });

  testWidgets('shows Catalan tips in Catalan', (tester) async {
    await _openTips(tester, 'ca');
    await pumpUntilFound(tester, find.text('Consell del dia'));
    await tester.scrollUntilVisible(
      find.text(
        'Les rendibilitats passades no garanteixen rendibilitats futures.',
      ),
      200,
      scrollable: _tipsList,
    );
  });
}
