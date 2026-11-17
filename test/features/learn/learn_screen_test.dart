import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/features/learn/presentation/widgets/lessons_tab.dart';
import 'package:invest_young/features/onboarding/data/profile_repository.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/pump_app.dart';
import '../../helpers/test_database.dart';

final _lessonsList = find
    .descendant(of: find.byType(LessonsTab), matching: find.byType(Scrollable))
    .first;

/// Opens the Learn tab with a saved profile (basic knowledge).
Future<void> _openLearn(WidgetTester tester, {String locale = 'es'}) async {
  final db = createTestDatabase();
  final profile = onboardedProfile(locale: locale);
  await tester.runAsync(
    () => ProfileRepository(db.profileDao).saveProfile(profile),
  );
  await pumpApp(
    tester,
    database: db,
    locale: Locale(locale),
    startupProfile: profile,
  );
  // Plain taps: a loading spinner keeps animating until the assets load,
  // so pumpAndSettle would time out.
  await tester.tap(find.byIcon(Icons.school_outlined));
  await tester.pump();
  await pumpUntilFound(
    tester,
    find.text(locale == 'es' ? 'Fundamentos' : 'Fonaments'),
  );
}

Future<void> _openLesson(WidgetTester tester, String title) async {
  await tester.tap(find.text(title));
  await tester.pump();
  await pumpUntilFound(tester, find.text('La regla en una frase'));
}

void main() {
  testWidgets('lists modules and marks the recommended ones', (tester) async {
    await _openLearn(tester);

    expect(find.text('El presupuesto 50/30/20'), findsOneWidget);
    expect(find.text('4 min de lectura'), findsWidgets);
    // Basic knowledge → emergency fund, fixed income and equities.
    await pumpUntilFound(tester, find.text('Recomendado para ti'));
    await tester.scrollUntilVisible(
      find.text('Renta variable'),
      200,
      scrollable: _lessonsList,
    );
    expect(find.text('Próximamente'), findsWidgets);
  });

  testWidgets('opens a lesson in the current language', (tester) async {
    await _openLearn(tester);
    await _openLesson(tester, 'El presupuesto 50/30/20');
    expect(find.textContaining('ahorro e inversión'), findsWidgets);
  });

  testWidgets('shows Catalan content in Catalan', (tester) async {
    await _openLearn(tester, locale: 'ca');
    await _openLesson(tester, 'El pressupost 50/30/20');
    expect(find.textContaining('estalvi i inversió'), findsWidgets);
  });

  testWidgets('renders every lesson without errors', (tester) async {
    await _openLearn(tester);
    for (final title in [
      'Inflación e interés compuesto',
      'Qué es y cuánto necesitas',
      'Dónde guardar tu fondo de emergencia',
      'Deuda buena, deuda mala y su coste real',
      'Cómo salir de las deudas',
    ]) {
      await tester.scrollUntilVisible(
        find.text(title),
        200,
        scrollable: _lessonsList,
      );
      await tester.tap(find.text(title));
      await tester.pump();
      await pumpUntilFound(tester, find.widgetWithText(AppBar, title));
      await pumpUntilFound(tester, find.byType(MarkdownBody));
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
    }
  });
}
