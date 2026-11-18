import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/db/app_database.dart';
import 'package:invest_young/features/onboarding/data/profile_repository.dart';
import 'package:invest_young/features/profile/domain/contribution_reminder.dart';

import '../../helpers/fake_reminder_scheduler.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/pump_app.dart';
import '../../helpers/test_database.dart';

void main() {
  late AppDatabase db;
  late ProfileRepository profiles;
  late FakeReminderScheduler reminders;

  setUp(() {
    db = createTestDatabase();
    profiles = ProfileRepository(db.profileDao);
    reminders = FakeReminderScheduler();
  });

  Future<void> openProfile(
    WidgetTester tester, {
    ContributionReminder? reminder,
  }) async {
    final profile = onboardedProfile();
    await tester.runAsync(() async {
      await profiles.saveProfile(profile);
      await profiles.updateReminder(reminder);
    });
    await pumpApp(
      tester,
      database: db,
      startupProfile: profile,
      reminders: reminders,
    );
    await tapVisible(tester, find.text('Perfil'));
  }

  Future<ContributionReminder?> savedReminder(WidgetTester tester) async =>
      (await tester.runAsync(profiles.getProfile))!.reminder;

  const switchLabel = 'Recordatorio mensual para aportar';

  testWidgets('turning it on schedules day 1 at 9:00 and saves it', (
    tester,
  ) async {
    await openProfile(tester);
    expect(find.textContaining('Te avisamos un día al mes'), findsOneWidget);

    await tapVisible(tester, find.text(switchLabel));
    await pumpUntilFound(tester, find.text('El día 1 de cada mes a las 9:00'));

    expect(await savedReminder(tester), ContributionReminder.initial);
    expect(reminders.scheduled, ContributionReminder.initial);
    expect(reminders.title, '¿Has aportado este mes?');
  });

  testWidgets('without permission it stays off and explains why', (
    tester,
  ) async {
    reminders.permissionGranted = false;
    await openProfile(tester);

    await tapVisible(tester, find.text(switchLabel));

    expect(find.textContaining('Sin permiso'), findsOneWidget);
    expect(await savedReminder(tester), isNull);
    expect(reminders.scheduled, isNull);
  });

  testWidgets('changes the day of the month', (tester) async {
    await openProfile(tester, reminder: ContributionReminder.initial);

    await tapVisible(tester, find.text('Día del mes'));
    await tapVisible(tester, find.text('Día 15'));
    await pumpUntilFound(tester, find.text('El día 15 de cada mes a las 9:00'));

    const expected = ContributionReminder(dayOfMonth: 15);
    expect(await savedReminder(tester), expected);
    expect(reminders.scheduled, expected);
  });

  testWidgets('turning it off cancels the notification', (tester) async {
    await openProfile(tester, reminder: ContributionReminder.initial);
    await tester.runAsync(
      () => reminders.schedule(
        ContributionReminder.initial,
        title: 't',
        body: 'b',
        channelName: 'c',
      ),
    );

    await tapVisible(tester, find.text(switchLabel));
    await pumpUntilFound(tester, find.textContaining('Te avisamos'));

    expect(await savedReminder(tester), isNull);
    expect(reminders.scheduled, isNull);
    expect(find.text('Día del mes'), findsNothing);
  });

  testWidgets('switching language reschedules it in that language', (
    tester,
  ) async {
    await openProfile(tester, reminder: ContributionReminder.initial);

    await tapVisible(tester, find.text('Idioma'));
    await tapVisible(tester, find.text('Catalán'));
    await pumpUntilFound(tester, find.text('Les teves dades'));

    expect(reminders.title, 'Has aportat aquest mes?');
  });

  testWidgets('deleting all data cancels it', (tester) async {
    await openProfile(tester, reminder: ContributionReminder.initial);
    await tester.runAsync(
      () => reminders.schedule(
        ContributionReminder.initial,
        title: 't',
        body: 'b',
        channelName: 'c',
      ),
    );

    await tapVisible(tester, find.text('Borrar todos los datos'));
    await tapVisible(tester, find.text('Borrar todo'));

    expect(find.text('Paso 1 de 8'), findsOneWidget);
    expect(reminders.scheduled, isNull);
  });
}
