import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/features/investments/domain/asset_metadata.dart';
import 'package:invest_young/features/investments/domain/investment_enums.dart';

void main() {
  test('every category has its own fields', () {
    expect(AssetMetadata.keysFor(AssetCategory.emergency), [
      AssetMetadata.institution,
      AssetMetadata.apy,
    ]);
    expect(
      AssetMetadata.keysFor(AssetCategory.fixedIncome),
      contains(AssetMetadata.maturityDate),
    );
  });

  test('typed accessors ignore missing or wrong values', () {
    const metadata = {
      'institution': ' ',
      'apy': 0.025,
      'maturityDate': '2027-03-15',
      'subtype': 'etf',
      'ticker': 42,
    };
    expect(AssetMetadata.text(metadata, AssetMetadata.institution), isNull);
    expect(AssetMetadata.text(metadata, AssetMetadata.ticker), isNull);
    expect(AssetMetadata.ratio(metadata, AssetMetadata.apy), 0.025);
    expect(
      AssetMetadata.date(metadata, AssetMetadata.maturityDate),
      DateTime(2027, 3, 15),
    );
    expect(AssetMetadata.equitySubtype(metadata), EquitySubtype.etf);
    expect(AssetMetadata.equitySubtype(const {}), isNull);
  });

  test('encodes dates as yyyy-MM-dd', () {
    expect(AssetMetadata.encodeDate(DateTime(2027, 3, 5)), '2027-03-05');
  });

  test('clean trims, drops empty values and foreign keys', () {
    final cleaned = AssetMetadata.clean(AssetCategory.crypto, const {
      'symbol': ' BTC ',
      'exchange': '',
      'ticker': 'VWCE',
      'apy': null,
    });
    expect(cleaned, {'symbol': 'BTC'});
  });
}
