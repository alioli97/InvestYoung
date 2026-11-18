import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
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
  List<Override> overrides = const [],
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
        ...overrides,
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

/// Pumps until [finder] matches something, letting real async work (asset
/// loading) progress between frames. Fails after [timeout].
Future<void> pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 10),
}) async {
  final end = DateTime.now().add(timeout);
  bool found() {
    try {
      return finder.evaluate().isNotEmpty;
    } on StateError {
      return false; // e.g. `.first` on an empty finder
    }
  }

  while (!found()) {
    if (DateTime.now().isAfter(end)) {
      throw TestFailure('Timed out waiting for $finder');
    }
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 20)),
    );
    // Advance the fake clock too, so animations (e.g. tab changes) progress.
    await tester.pump(const Duration(milliseconds: 50));
  }
  await tester.pumpAndSettle();
}
