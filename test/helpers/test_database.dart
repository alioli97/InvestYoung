import 'dart:ffi';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:invest_young/core/db/app_database.dart';
import 'package:sqlite3/open.dart';

bool _configured = false;

/// Linux hosts often ship only `libsqlite3.so.0` (no `-dev` package), which
/// the default loader does not find. Fall back to it when needed.
void configureSqliteForTests() {
  if (_configured) return;
  _configured = true;
  if (!Platform.isLinux) return;
  open.overrideFor(OperatingSystem.linux, () {
    try {
      return DynamicLibrary.open('libsqlite3.so');
    } on ArgumentError {
      return DynamicLibrary.open('libsqlite3.so.0');
    }
  });
}

/// A fresh in-memory [AppDatabase] for tests.
AppDatabase createTestDatabase() {
  configureSqliteForTests();
  return AppDatabase(
    DatabaseConnection(
      NativeDatabase.memory(),
      closeStreamsSynchronously: true,
    ),
  );
}
