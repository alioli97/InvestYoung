import 'package:decimal/decimal.dart';
import 'package:drift/drift.dart';

import '../domain/db_enum.dart';

/// Stores a [DbEnum] as its stable [DbEnum.dbValue] text.
class DbEnumConverter<T extends DbEnum> extends TypeConverter<T, String> {
  const DbEnumConverter(this.values);

  final List<T> values;

  @override
  T fromSql(String fromDb) => enumFromDb(values, fromDb);

  @override
  String toSql(T value) => value.dbValue;
}

/// Stores a [Decimal] as TEXT to keep full precision.
class DecimalConverter extends TypeConverter<Decimal, String> {
  const DecimalConverter();

  @override
  Decimal fromSql(String fromDb) => Decimal.parse(fromDb);

  @override
  String toSql(Decimal value) => value.toString();
}
