import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/formatters.dart';
import '../../../../core/theme/finance_colors.dart';

/// Signed return, e.g. `+120,00 € (+5,2 %)`, green for gains, red for losses.
class ReturnText extends StatelessWidget {
  const ReturnText({
    super.key,
    required this.returnCents,
    required this.ratio,
    this.style,
  });

  final int returnCents;

  /// `null` when there is no contributed capital to compare with.
  final double? ratio;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final sign = returnCents > 0 ? '+' : '';
    final amount = '$sign${context.formatCurrency(returnCents)}';
    final percent = ratio == null
        ? ''
        : ' (${ratio! > 0 ? '+' : ''}${context.formatPercent(ratio!)})';
    final base = style ?? Theme.of(context).textTheme.bodyMedium;
    return Text(
      '$amount$percent',
      style: base?.copyWith(
        color: FinanceColors.of(context).forSign(returnCents),
      ),
    );
  }
}
