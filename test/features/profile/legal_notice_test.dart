import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/pump_app.dart';

void main() {
  Future<void> openProfile(WidgetTester tester, {String locale = 'es'}) async {
    await pumpApp(
      tester,
      locale: Locale(locale),
      startupProfile: onboardedProfile(locale: locale),
    );
    await tapVisible(tester, find.byIcon(Icons.person_outline));
  }

  testWidgets('legal notice is reachable from Profile', (tester) async {
    await openProfile(tester);
    await tapVisible(tester, find.text('Aviso legal'));

    expect(find.widgetWithText(AppBar, 'Aviso legal'), findsOneWidget);
    expect(
      find.textContaining('no constituyen asesoramiento financiero'),
      findsOneWidget,
    );
    expect(find.textContaining('CNMV'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.textContaining('no garantizan resultados'),
      200,
    );
  });

  testWidgets('legal notice is translated', (tester) async {
    await openProfile(tester, locale: 'ca');
    await tapVisible(tester, find.text('Avís legal'));
    expect(
      find.textContaining('no constitueixen assessorament financer'),
      findsOneWidget,
    );
  });

  testWidgets('about dialog explains the app is offline and educational', (
    tester,
  ) async {
    await openProfile(tester);
    await tapVisible(tester, find.text('Acerca de'));
    expect(find.textContaining('Aplicación educativa'), findsOneWidget);
    expect(find.textContaining('solo en tu dispositivo'), findsOneWidget);
    expect(find.text('1.2.3 (45)'), findsOneWidget);
  });

  testWidgets('onboarding shows the same legal notice', (tester) async {
    await pumpApp(tester);
    await tapVisible(tester, find.widgetWithText(FilledButton, 'Continuar'));
    expect(
      find.textContaining('no constituyen asesoramiento financiero'),
      findsOneWidget,
    );
  });
}
