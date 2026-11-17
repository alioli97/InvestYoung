import 'package:decimal/decimal.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/goals/domain/goal_type.dart';
import '../../features/investments/domain/investment_enums.dart';
import '../../features/onboarding/domain/profile_enums.dart';
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
)
class AppDatabase extends _$AppDatabase {
  /// Opens the on-device database, or uses [executor] (e.g. in-memory in tests).
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'invest_young'));

  /// Bump on every schema change and add the matching migration step.
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
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
