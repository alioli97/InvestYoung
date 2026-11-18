import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/features/investments/domain/asset.dart';
import 'package:invest_young/features/investments/domain/asset_transaction.dart';
import 'package:invest_young/features/investments/domain/investment_enums.dart';
import 'package:invest_young/features/profile/domain/transactions_csv.dart';

void main() {
  final labels = TransactionsCsvLabels(
    headers: [
      'Fecha',
      'Activo',
      'Categoría',
      'Tipo',
      'Importe',
      'Cantidad',
      'Comisiones',
      'Nota',
    ],
    category: (c) => c.name,
    type: (t) => t.name,
  );
  final fund = Asset(
    id: 1,
    category: AssetCategory.equity,
    name: 'Fondo indexado',
    createdAt: DateTime.utc(2026),
  );

  List<String> lines(String csv) => csv.substring(1).split('\r\n');

  test('starts with a BOM and a header row, ends with CRLF', () {
    final csv = buildTransactionsCsv(
      assets: [fund],
      transactions: const [],
      labels: labels,
    );
    expect(csv, startsWith('\uFEFF'));
    expect(csv, endsWith('\r\n'));
    expect(
      lines(csv).first,
      'Fecha;Activo;Categoría;Tipo;Importe;Cantidad;Comisiones;Nota',
    );
  });

  test('writes amounts with decimal comma and no thousands separator', () {
    final csv = buildTransactionsCsv(
      assets: [fund],
      transactions: [
        AssetTransaction(
          id: 1,
          assetId: 1,
          type: TransactionType.buy,
          date: DateTime.utc(2026, 3, 15, 10),
          amountCents: 123456,
          quantity: Decimal.parse('12.3456'),
          feeCents: 5,
        ),
      ],
      labels: labels,
    );
    expect(
      lines(csv)[1],
      '2026-03-15;Fondo indexado;equity;buy;1234,56;12,3456;0,05;',
    );
  });

  test('sorts by date and quotes fields with separators or quotes', () {
    final csv = buildTransactionsCsv(
      assets: [fund],
      transactions: [
        AssetTransaction(
          id: 2,
          assetId: 1,
          type: TransactionType.valuation,
          date: DateTime.utc(2026, 5, 1, 12),
          amountCents: 100,
          note: 'Dijo "vale"; ok',
        ),
        AssetTransaction(
          id: 1,
          assetId: 1,
          type: TransactionType.deposit,
          date: DateTime.utc(2026, 4, 1, 12),
          amountCents: 7,
        ),
      ],
      labels: labels,
    );
    final rows = lines(csv);
    expect(rows[1], startsWith('2026-04-01;'));
    expect(rows[1], endsWith(';deposit;0,07;;;'));
    expect(rows[2], endsWith(';"Dijo ""vale""; ok"'));
  });
}
