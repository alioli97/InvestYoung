import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/db/app_database.dart';

part 'backup_service.g.dart';

/// The backup file is not valid, or is from a newer app version.
class BackupFormatException implements Exception {
  const BackupFormatException(this.message);

  final String message;

  @override
  String toString() => 'BackupFormatException: $message';
}

/// Exports and imports every table as JSON (docs/SPEC.md §9).
///
/// Rows are copied as raw SQL values, so the backup mirrors the database
/// exactly: `{"app", "schemaVersion", "exportedAt", "tables": {name: [rows]}}`.
class BackupService {
  const BackupService(this._db);

  static const appId = 'invest_young';

  final AppDatabase _db;

  /// Tables in dependency order (parents first) for inserting.
  List<TableInfo<Table, Object?>> get _tables => [
    _db.userProfiles,
    _db.monthlyExpenses,
    _db.goals,
    _db.assets,
    _db.transactions,
    _db.lessonProgress,
  ];

  Future<String> exportJson({DateTime? now}) async {
    final tables = <String, Object?>{};
    for (final table in _tables) {
      final rows = await _db
          .customSelect('SELECT * FROM "${table.actualTableName}"')
          .get();
      tables[table.actualTableName] = [for (final row in rows) row.data];
    }
    return const JsonEncoder.withIndent('  ').convert({
      'app': appId,
      'schemaVersion': _db.schemaVersion,
      'exportedAt': (now ?? DateTime.now()).toUtc().toIso8601String(),
      'tables': tables,
    });
  }

  /// Replaces **all** data with the backup. Nothing changes if it fails.
  Future<void> importJson(String json) async {
    final tables = _parse(json);
    try {
      await _db.transaction(() async {
        await _deleteAllTables();
        for (final table in _tables) {
          final columns = {for (final c in table.$columns) c.name};
          for (final row in tables[table.actualTableName] ?? const []) {
            await _insert(table, columns, row);
          }
        }
      });
    } on BackupFormatException {
      rethrow;
    } on Exception catch (e) {
      throw BackupFormatException('Rows could not be restored: $e');
    }
  }

  /// Deletes every row of every table.
  Future<void> deleteAll() => _db.transaction(_deleteAllTables);

  Future<void> _deleteAllTables() async {
    for (final table in _tables.reversed) {
      await _db.delete(table).go();
    }
  }

  Future<void> _insert(
    TableInfo<Table, Object?> table,
    Set<String> columns,
    Map<String, Object?> row,
  ) async {
    if (row.isEmpty) return;
    for (final name in row.keys) {
      // Only real column names reach the SQL text.
      if (!columns.contains(name)) {
        throw BackupFormatException(
          'Unknown column ${table.actualTableName}.$name',
        );
      }
    }
    final names = row.keys.map((n) => '"$n"').join(', ');
    final placeholders = List.filled(row.length, '?').join(', ');
    await _db.customInsert(
      'INSERT INTO "${table.actualTableName}" ($names) VALUES ($placeholders)',
      variables: [for (final value in row.values) Variable(value)],
      updates: {table},
    );
  }

  Map<String, List<Map<String, Object?>>> _parse(String json) {
    final Object? data;
    try {
      data = jsonDecode(json);
    } on FormatException {
      throw const BackupFormatException('Not valid JSON');
    }
    if (data is! Map<String, dynamic> || data['app'] != appId) {
      throw const BackupFormatException('Not an Invertir siendo Joven backup');
    }
    final version = data['schemaVersion'];
    if (version is! int || version < 1 || version > _db.schemaVersion) {
      throw BackupFormatException('Unsupported schemaVersion $version');
    }
    final tables = data['tables'];
    if (tables is! Map<String, dynamic>) {
      throw const BackupFormatException('Missing tables');
    }
    final known = {for (final t in _tables) t.actualTableName};
    final result = <String, List<Map<String, Object?>>>{};
    for (final entry in tables.entries) {
      if (!known.contains(entry.key)) {
        throw BackupFormatException('Unknown table ${entry.key}');
      }
      final rows = entry.value;
      if (rows is! List) {
        throw BackupFormatException('Bad rows in ${entry.key}');
      }
      result[entry.key] = [
        for (final row in rows)
          if (row is Map<String, dynamic> &&
              row.values.every((v) => v == null || v is num || v is String))
            row
          else
            throw BackupFormatException('Bad row in ${entry.key}'),
      ];
    }
    return result;
  }
}

@Riverpod(keepAlive: true)
BackupService backupService(Ref ref) =>
    BackupService(ref.watch(appDatabaseProvider));
