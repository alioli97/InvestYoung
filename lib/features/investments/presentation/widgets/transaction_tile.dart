import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/formatters.dart';
import '../../../../core/l10n/l10n.dart';
import '../../domain/asset_transaction.dart';
import '../../domain/investment_enums.dart';
import '../transaction_labels.dart';

/// One transaction: type, date, units and amount.
class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.tx, required this.onTap});

  final AssetTransaction tx;
  final VoidCallback onTap;

  /// `+` money in, `−` money out, `=` a valuation (sets the value).
  String _sign() => switch (tx.type) {
    TransactionType.deposit ||
    TransactionType.buy ||
    TransactionType.income => '+',
    TransactionType.withdrawal || TransactionType.sell => '−',
    TransactionType.valuation => '=',
  };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final quantity = tx.quantity;
    final details = [
      context.formatShortDate(tx.date),
      if (quantity != null)
        l10n.investmentsUnits(context.formatQuantity(quantity)),
    ].join(' · ');
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      leading: CircleAvatar(child: Icon(transactionIcon(tx.type), size: 20)),
      title: Text(l10n.transactionType(tx.type)),
      subtitle: Text(details),
      trailing: Text(
        '${_sign()} ${context.formatCurrency(tx.amountCents)}',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      onTap: onTap,
    );
  }
}
