import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';
import 'core/db/app_database.dart';
import 'features/onboarding/data/profile_repository.dart';
import 'features/onboarding/presentation/onboarding_status_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  // Load the profile up front so the router knows where to start and the
  // saved language applies from the first frame.
  final db = AppDatabase();
  final profile = await ProfileRepository(db.profileDao).getProfile();

  runApp(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        startupProfileProvider.overrideWithValue(profile),
      ],
      child: const InvestYoungApp(),
    ),
  );
}
