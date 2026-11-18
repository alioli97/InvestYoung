import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/router/app_router.dart';
import 'package:invest_young/core/router/routes.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('onboardingRedirect', () {
    test('sends users to onboarding until completed', () {
      expect(onboardingRedirect(false, Routes.home), Routes.onboarding);
      expect(onboardingRedirect(false, Routes.profile), Routes.onboarding);
      expect(onboardingRedirect(false, Routes.onboarding), isNull);
    });

    test('keeps users out of onboarding once completed', () {
      expect(onboardingRedirect(true, Routes.onboarding), Routes.home);
      expect(onboardingRedirect(true, Routes.goals), isNull);
    });
  });

  testWidgets('opens onboarding when it is not completed', (tester) async {
    await pumpApp(tester);
    expect(find.byType(NavigationBar), findsNothing);
    expect(find.text('Elige tu idioma'), findsOneWidget);
  });

  testWidgets('uses Catalan when the device locale is Catalan', (tester) async {
    await pumpApp(tester, locale: const Locale('ca', 'ES'));
    expect(find.text('Tria el teu idioma'), findsOneWidget);
  });
}
