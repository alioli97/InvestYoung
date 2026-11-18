import 'package:decimal/decimal.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/goals/data/goals_dao.dart';
import '../../features/goals/domain/goal_type.dart';
import '../../features/investments/data/investments_dao.dart';
import '../../features/investments/domain/investment_enums.dart';
import '../../features/learn/data/lesson_progress_dao.dart';
import '../../features/onboarding/data/profile_dao.dart';
import '../../features/onboarding/domain/profile_enums.dart';
import '../domain/app_theme_mode.dart';
import 'app_database.steps.dart';
import 'converters.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    UserProfiles,
    MonthlyExpenses,
    Goals,
    Assets,
    Transactions,
    LessonProgress,
  ],
  daos: [ProfileDao, GoalsDao, InvestmentsDao, LessonProgressDao],
)
class AppDatabase extends _$AppDatabase {
  /// Opens the on-device database, or uses [executor] (e.g. in-memory in tests).
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  static QueryExecutor _openConnection() => driftDatabase(
    name: 'invest_young',
    // Web is only used for local previews (`flutter run -d chrome`). Both
    // files live in web/ and must match the drift / sqlite3 package versions.
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
    ),
  );

  /// Bump on every schema change and add the matching migration step.
  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: stepByStep(
      from1To2: (m, schema) async {
        await m.addColumn(schema.userProfiles, schema.userProfiles.themeMode);
      },
      from2To3: (m, schema) async {
        await m.addColumn(schema.userProfiles, schema.userProfiles.reminderDay);
        await m.addColumn(
          schema.userProfiles,
          schema.userProfiles.reminderMinuteOfDay,
        );
      },
    ),
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}
