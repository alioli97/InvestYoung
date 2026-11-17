/// An enum with a stable value used for persistence (database and backups).
///
/// The [dbValue] must never change once released, even if the Dart name does.
abstract interface class DbEnum {
  String get dbValue;
}

/// Looks up the value of [values] whose [DbEnum.dbValue] is [dbValue].
T enumFromDb<T extends DbEnum>(List<T> values, String dbValue) {
  for (final value in values) {
    if (value.dbValue == dbValue) return value;
  }
  throw ArgumentError.value(dbValue, 'dbValue', 'Unknown value for $T');
}
