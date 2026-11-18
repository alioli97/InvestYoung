import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';
import 'core/db/app_database.dart';
import 'features/onboarding/data/profile_repository.dart';
import 'features/onboarding/presentation/onboarding_status_provider.dart';
import 'features/profile/data/preferences_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  // Load the profile up front so the router knows where to start and the
  // saved language applies from the first frame.
  final db = AppDatabase();
  final profile = await ProfileRepository(db.profileDao).getProfile();

  final container = ProviderContainer(
    overrides: [
      appDatabaseProvider.overrideWithValue(db),
      startupProfileProvider.overrideWithValue(profile),
    ],
  );
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const InvestYoungApp(),
    ),
  );

  // Keep the scheduled reminder in line with the saved profile (e.g. after
  // a time zone change). Not critical: never block or crash the app.
  if (profile?.reminder != null) {
    unawaited(
      container
          .read(preferencesServiceProvider)
          .syncReminder()
          .catchError((Object _) {}),
    );
  }
}
