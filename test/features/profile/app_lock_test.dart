import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/db/app_database.dart';
import 'package:invest_young/features/onboarding/data/profile_repository.dart';
import 'package:invest_young/features/onboarding/presentation/onboarding_status_provider.dart';
import 'package:invest_young/features/profile/data/device_auth.dart';
import 'package:invest_young/features/profile/presentation/lock/app_lock_controller.dart';

import '../../helpers/fake_device_auth.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/pump_app.dart';
import '../../helpers/test_database.dart';

void main() {
  group('AppLock', () {
    late AppDatabase db;
    late FakeDeviceAuth auth;

    setUp(() {
      db = createTestDatabase();
      auth = FakeDeviceAuth();
    });
    tearDown(() => db.close());

    Future<ProviderContainer> container({bool enabled = false}) async {
      final profile = onboardedProfile(appLockEnabled: enabled);
      await ProfileRepository(db.profileDao).saveProfile(profile);
      await ProfileRepository(db.profileDao).updateAppLock(enabled: enabled);
      final c = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          startupProfileProvider.overrideWithValue(profile),
          deviceAuthProvider.overrideWithValue(auth),
        ],
      );
      addTearDown(c.dispose);
      return c;
    }

    final t0 = DateTime(2026, 11, 19, 12);

    test('starts locked only when it is turned on', () async {
      expect((await container()).read(appLockProvider).locked, isFalse);
      final c = await container(enabled: true);
      expect(c.read(appLockProvider).locked, isTrue);
    });

    test('unlocks only when the device lock passes', () async {
      final c = await container(enabled: true);
      auth.passes = false;
      expect(await c.read(appLockProvider.notifier).unlock('r'), isFalse);
      expect(c.read(appLockProvider).locked, isTrue);

      auth.passes = true;
      expect(await c.read(appLockProvider.notifier).unlock('r'), isTrue);
      expect(c.read(appLockProvider).locked, isFalse);
    });

    test('never locks the user out if the device lock was removed', () async {
      final c = await container(enabled: true);
      auth
        ..available = false
        ..passes = false;
      expect(await c.read(appLockProvider.notifier).unlock('r'), isTrue);
      expect(auth.prompts, 0);
    });

    test('locks again after a minute in the background, not before', () async {
      final c = await container(enabled: true);
      final lock = c.read(appLockProvider.notifier);
      await lock.unlock('r');

      lock
        ..wentToBackground(t0)
        ..cameToForeground(t0.add(const Duration(seconds: 30)));
      expect(c.read(appLockProvider).locked, isFalse);

      lock
        ..wentToBackground(t0)
        ..cameToForeground(t0.add(AppLock.relockAfter));
      expect(c.read(appLockProvider).locked, isTrue);
    });

    test('does not lock on resume when it is off', () async {
      final c = await container();
      c.read(appLockProvider.notifier)
        ..wentToBackground(t0)
        ..cameToForeground(t0.add(const Duration(hours: 1)));
      expect(c.read(appLockProvider).locked, isFalse);
    });

    test('turning it on needs the device lock and saves it', () async {
      final c = await container();
      final lock = c.read(appLockProvider.notifier);

      auth.passes = false;
      expect(await lock.setEnabled(true, reason: 'r'), AppLockChange.cancelled);
      expect(c.read(appLockProvider).enabled, isFalse);

      auth.passes = true;
      expect(await lock.setEnabled(true, reason: 'r'), AppLockChange.done);
      expect(c.read(appLockProvider).enabled, isTrue);
      expect(c.read(appLockProvider).locked, isFalse);
      expect(
        (await ProfileRepository(db.profileDao).getProfile())!.appLockEnabled,
        isTrue,
      );
    });

    test('cannot be turned on without a screen lock on the device', () async {
      final c = await container();
      auth.available = false;
      expect(
        await c.read(appLockProvider.notifier).setEnabled(true, reason: 'r'),
        AppLockChange.unavailable,
      );
      expect(c.read(appLockProvider).enabled, isFalse);
    });
  });

  group('lock screen', () {
    Future<FakeDeviceAuth> openLocked(
      WidgetTester tester, {
      bool passes = true,
    }) async {
      final db = createTestDatabase();
      final profile = onboardedProfile(appLockEnabled: true);
      await tester.runAsync(() async {
        await ProfileRepository(db.profileDao).saveProfile(profile);
        await ProfileRepository(db.profileDao).updateAppLock(enabled: true);
      });
      final auth = FakeDeviceAuth(passes: passes);
      await pumpApp(
        tester,
        database: db,
        startupProfile: profile,
        deviceAuth: auth,
      );
      return auth;
    }

    testWidgets('asks for the device lock on opening and then shows the app', (
      tester,
    ) async {
      final auth = await openLocked(tester);
      expect(auth.prompts, 1);
      expect(auth.lastReason, 'Desbloquea la app para ver tus datos');
      expect(find.text('La app está bloqueada'), findsNothing);
      await pumpUntilFound(tester, find.text('Patrimonio total'));
    });

    testWidgets('stays locked if cancelled and retries with the button', (
      tester,
    ) async {
      final auth = await openLocked(tester, passes: false);
      expect(find.text('La app está bloqueada'), findsOneWidget);

      auth.passes = true;
      await tester.tap(find.text('Desbloquear'));
      await tester.pumpAndSettle();

      expect(auth.prompts, 2);
      expect(find.text('La app está bloqueada'), findsNothing);
    });
  });

  testWidgets('Profile switch turns the lock on', (tester) async {
    final db = createTestDatabase();
    final profile = onboardedProfile();
    await tester.runAsync(
      () => ProfileRepository(db.profileDao).saveProfile(profile),
    );
    final auth = FakeDeviceAuth();
    await pumpApp(
      tester,
      database: db,
      startupProfile: profile,
      deviceAuth: auth,
    );
    await tapVisible(tester, find.text('Perfil'));
    await tapVisible(tester, find.text('Bloquear la app'));

    expect(auth.lastReason, 'Confirma que eres tú para cambiar el bloqueo');
    final saved = await tester.runAsync(
      ProfileRepository(db.profileDao).getProfile,
    );
    expect(saved!.appLockEnabled, isTrue);
  });
}
