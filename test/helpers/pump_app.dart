import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/app.dart';

/// Pumps the whole app with the device locale set to [locale].
Future<void> pumpApp(
  WidgetTester tester, {
  Locale locale = const Locale('es'),
  Size size = const Size(400, 900),
}) async {
  tester.platformDispatcher.localesTestValue = [locale];
  addTearDown(tester.platformDispatcher.clearLocalesTestValue);
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(const ProviderScope(child: InvestYoungApp()));
  await tester.pumpAndSettle();
}

/// Taps the widget found by [finder], scrolling it into view first (lazy
/// lists may not have built it yet).
Future<void> tapVisible(WidgetTester tester, Finder finder) async {
  if (finder.evaluate().isEmpty) {
    await tester.scrollUntilVisible(
      finder,
      200,
      scrollable: find.byType(Scrollable).first,
    );
  }
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}
