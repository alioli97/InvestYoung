import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:invest_young/core/db/app_database.dart';

/// A fresh in-memory [AppDatabase] for tests.
///
/// `package:sqlite3` 3.x bundles SQLite through build hooks, so no system
/// library is needed.
AppDatabase createTestDatabase() => AppDatabase(
  DatabaseConnection(NativeDatabase.memory(), closeStreamsSynchronously: true),
);
