import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/app.dart';
import 'package:invest_young/core/router/app_router.dart';
import 'package:invest_young/core/router/routes.dart';

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

  testWidgets('opens onboarding, then shows the 5 tabs', (tester) async {
    tester.platformDispatcher.localesTestValue = const [Locale('es')];
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);

    await tester.pumpWidget(const ProviderScope(child: InvestYoungApp()));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsNothing);
    await tester.tap(find.text('Empezar'));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationDestination), findsNWidgets(5));

    await tester.tap(find.text('Perfil'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Perfil'), findsOneWidget);
  });

  testWidgets('uses Catalan when the device locale is Catalan', (tester) async {
    tester.platformDispatcher.localesTestValue = const [Locale('ca', 'ES')];
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);

    await tester.pumpWidget(const ProviderScope(child: InvestYoungApp()));
    await tester.pumpAndSettle();

    expect(find.text('Començar'), findsOneWidget);
  });
}
