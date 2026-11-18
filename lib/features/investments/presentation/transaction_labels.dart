import 'package:material_ui/material_ui.dart';

import '../../../core/l10n/l10n.dart';
import '../domain/investment_enums.dart';

extension TransactionLabels on AppLocalizations {
  String transactionType(TransactionType type) => switch (type) {
    TransactionType.deposit => investmentsTxDeposit,
    TransactionType.withdrawal => investmentsTxWithdrawal,
    TransactionType.buy => investmentsTxBuy,
    TransactionType.sell => investmentsTxSell,
    TransactionType.income => investmentsTxIncome,
    TransactionType.valuation => investmentsTxValuation,
  };

  /// Label of the amount field, which means something different per type.
  String transactionAmountLabel(TransactionType type) => switch (type) {
    TransactionType.deposit => investmentsTxAmountDeposit,
    TransactionType.withdrawal => investmentsTxAmountWithdrawal,
    TransactionType.buy => investmentsTxAmountBuy,
    TransactionType.sell => investmentsTxAmountSell,
    TransactionType.income => investmentsTxAmountIncome,
    TransactionType.valuation => investmentsTxAmountValuation,
  };
}

IconData transactionIcon(TransactionType type) => switch (type) {
  TransactionType.deposit => Icons.south_west,
  TransactionType.withdrawal => Icons.north_east,
  TransactionType.buy => Icons.add_shopping_cart,
  TransactionType.sell => Icons.sell_outlined,
  TransactionType.income => Icons.payments_outlined,
  TransactionType.valuation => Icons.edit_note,
};
