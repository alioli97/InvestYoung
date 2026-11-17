import 'package:flutter/widgets.dart';

import '../../../core/l10n/formatters.dart';
import '../../../core/l10n/l10n.dart';
import '../domain/asset.dart';
import '../domain/asset_metadata.dart';
import '../domain/investment_enums.dart';

/// Localized labels for asset metadata.
extension AssetMetadataLabels on AppLocalizations {
  String equitySubtype(EquitySubtype value) => switch (value) {
    EquitySubtype.indexFund => investmentsSubtypeIndexFund,
    EquitySubtype.etf => investmentsSubtypeEtf,
    EquitySubtype.stock => investmentsSubtypeStock,
    EquitySubtype.other => investmentsSubtypeOther,
  };

  /// Short summary of the category-specific fields, e.g. `BTC · Binance`.
  String assetDetailsLine(BuildContext context, Asset asset) {
    final m = asset.metadata;
    String? percent(String key) {
      final ratio = AssetMetadata.ratio(m, key);
      return ratio == null
          ? null
          : context.formatPercent(ratio, decimalDigits: 2);
    }

    final parts = switch (asset.category) {
      AssetCategory.emergency => [
        AssetMetadata.text(m, AssetMetadata.institution),
        if (percent(AssetMetadata.apy) case final apy?)
          investmentsApyShort(apy),
      ],
      AssetCategory.fixedIncome => [
        AssetMetadata.text(m, AssetMetadata.issuer),
        percent(AssetMetadata.yieldRate),
        if (AssetMetadata.date(m, AssetMetadata.maturityDate) case final d?)
          investmentsMaturityShort(context.formatShortDate(d)),
      ],
      AssetCategory.equity => [
        AssetMetadata.text(m, AssetMetadata.ticker),
        if (AssetMetadata.equitySubtype(m) case final s?) equitySubtype(s),
      ],
      AssetCategory.crypto => [
        AssetMetadata.text(m, AssetMetadata.symbol),
        AssetMetadata.text(m, AssetMetadata.exchange),
      ],
    };
    return parts.whereType<String>().join(' · ');
  }
}
