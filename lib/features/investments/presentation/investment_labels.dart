import 'package:material_ui/material_ui.dart';

import '../../../core/l10n/l10n.dart';
import '../domain/investment_enums.dart';

/// Localized labels and icons for investment enums.
extension InvestmentLabels on AppLocalizations {
  String assetCategory(AssetCategory value) => switch (value) {
    AssetCategory.emergency => investmentsCategoryEmergency,
    AssetCategory.fixedIncome => investmentsCategoryFixedIncome,
    AssetCategory.equity => investmentsCategoryEquity,
    AssetCategory.crypto => investmentsCategoryCrypto,
  };

  String assetCategoryExamples(AssetCategory value) => switch (value) {
    AssetCategory.emergency => investmentsCategoryEmergencyExamples,
    AssetCategory.fixedIncome => investmentsCategoryFixedIncomeExamples,
    AssetCategory.equity => investmentsCategoryEquityExamples,
    AssetCategory.crypto => investmentsCategoryCryptoExamples,
  };
}

IconData assetCategoryIcon(AssetCategory category) => switch (category) {
  AssetCategory.emergency => Icons.savings_outlined,
  AssetCategory.fixedIncome => Icons.account_balance_outlined,
  AssetCategory.equity => Icons.show_chart,
  AssetCategory.crypto => Icons.currency_bitcoin,
};
