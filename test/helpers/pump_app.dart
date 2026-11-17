import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/app.dart';
import 'package:invest_young/core/db/app_database.dart';
import 'package:invest_young/features/onboarding/domain/user_profile.dart';
import 'package:invest_young/features/onboarding/presentation/onboarding_status_provider.dart';

import 'test_database.dart';

/// Pumps the whole app with the device locale set to [locale], backed by an
/// in-memory database (returned so tests can inspect it).
Future<AppDatabase> pumpApp(
  WidgetTester tester, {
  Locale locale = const Locale('es'),
  Size size = const Size(400, 900),
  AppDatabase? database,
  UserProfile? startupProfile,
}) async {
  final db = database ?? createTestDatabase();
  // Unmount first so no stream query is left waiting, then close outside the
  // fake-async zone; otherwise a failing test can hang the whole suite.
  addTearDown(() async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.runAsync(db.close);
  });
  tester.platformDispatcher.localesTestValue = [locale];
  addTearDown(tester.platformDispatcher.clearLocalesTestValue);
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        startupProfileProvider.overrideWithValue(startupProfile),
      ],
      child: const InvestYoungApp(),
    ),
  );
  await tester.pumpAndSettle();
  return db;
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

String _normalizeSpaces(String s) =>
    s.replaceAll(' ', ' ').replaceAll(' ', ' ');

/// Finds [Text] widgets whose text equals [text] ignoring non-breaking
/// spaces (intl uses them in currency and percent formats).
Finder findMoney(String text, {bool contains = false}) =>
    find.byWidgetPredicate((w) {
      if (w is! Text) return false;
      final data = w.data ?? w.textSpan?.toPlainText();
      if (data == null) return false;
      final normalized = _normalizeSpaces(data);
      return contains ? normalized.contains(text) : normalized == text;
    }, description: 'text "$text"');
