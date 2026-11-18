import 'dart:convert';
import 'dart:io';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/db/app_database.dart';
import 'package:invest_young/features/learn/data/lesson_progress_repository.dart';
import 'package:invest_young/features/onboarding/data/profile_repository.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/pump_app.dart';
import '../../helpers/test_database.dart';

const _lesson = 'El presupuesto 50/30/20';

/// Number of lessons shipped, so adding a module does not break these tests.
final int _totalLessons = [
  for (final module
      in jsonDecode(
            File('assets/learn/index.json').readAsStringSync(),
          )['modules']
          as List)
    ...module['lessons'] as List,
].length;

void main() {
  late AppDatabase db;

  setUp(() => db = createTestDatabase());

  Future<void> openLesson(WidgetTester tester) async {
    await tester.runAsync(
      () => ProfileRepository(db.profileDao).saveProfile(onboardedProfile()),
    );
    await pumpApp(tester, database: db, startupProfile: onboardedProfile());
    await tester.tap(find.byIcon(Icons.school_outlined));
    await tester.pump();
    await pumpUntilFound(tester, find.text(_lesson));
    expect(
      find.text('Has leído 0 de $_totalLessons lecciones'),
      findsOneWidget,
    );
    await tester.tap(find.text(_lesson));
    await tester.pump();
    await pumpUntilFound(tester, find.text('La regla en una frase'));
  }

  Future<void> answer(WidgetTester tester, List<String> options) async {
    for (final option in options) {
      await tapVisible(tester, find.text(option));
    }
  }

  testWidgets('marks a lesson as read', (tester) async {
    await openLesson(tester);
    await tapVisible(tester, find.text('Marcar como leída'));
    expect(find.text('Lección leída'), findsOneWidget);

    final status = (await tester.runAsync(
      LessonProgressRepository(db.lessonProgressDao).getAll,
    ))!['fundamentals-budget']!;
    expect(status.isRead, isTrue);
    expect(status.isQuizPassed, isFalse);
  });

  testWidgets('failing the quiz shows the right answers and allows retry', (
    tester,
  ) async {
    await openLesson(tester);
    await tapVisible(tester, find.text('Hacer el test'));

    final check = find.widgetWithText(FilledButton, 'Comprobar');
    await answer(tester, ['El 50 %', 'Necesidades']);
    expect(tester.widget<FilledButton>(check).onPressed, isNull);
    await answer(tester, ['120 €']);
    await tapVisible(tester, check);

    expect(find.text('1 de 3 correctas'), findsOneWidget);
    expect(find.byIcon(Icons.cancel), findsWidgets);

    await tapVisible(tester, find.text('Volver a intentarlo'));
    expect(find.byIcon(Icons.cancel), findsNothing);
    expect(
      (await tester.runAsync(
        LessonProgressRepository(db.lessonProgressDao).getAll,
      ))!,
      isEmpty,
    );
  });

  testWidgets('passing the quiz saves progress and shows it', (tester) async {
    await openLesson(tester);
    await tapVisible(tester, find.text('Hacer el test'));
    await answer(tester, ['El 20 %', 'Necesidades', '240 €']);
    await tapVisible(tester, find.widgetWithText(FilledButton, 'Comprobar'));

    expect(find.text('3 de 3 correctas'), findsOneWidget);
    expect(find.text('¡Perfecto! Has superado el test.'), findsOneWidget);

    await tapVisible(tester, find.text('Volver a la lección'));
    expect(find.text('Test superado'), findsOneWidget);
    expect(find.text('Lección leída'), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(
      find.text('Has leído 1 de $_totalLessons lecciones'),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.verified), findsOneWidget);

    final status = (await tester.runAsync(
      LessonProgressRepository(db.lessonProgressDao).getAll,
    ))!['fundamentals-budget']!;
    expect(status.isQuizPassed, isTrue);
  });
}
