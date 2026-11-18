import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/formatters.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/l10n/money_input.dart';
import '../../../../core/widgets/date_field.dart';
import '../../domain/asset.dart';
import '../../domain/asset_transaction.dart';
import '../../domain/investment_enums.dart';
import '../../domain/transaction_rules.dart';
import '../transaction_labels.dart';

/// Fields of a transaction. Which ones appear depends on the asset category
/// and the transaction type (see [TransactionRules]).
class TransactionForm extends StatefulWidget {
  const TransactionForm({
    super.key,
    required this.asset,
    required this.transactions,
    required this.onSubmit,
    this.initial,
  });

  final Asset asset;

  /// Existing transactions of the asset, to validate sells against holdings.
  final List<AssetTransaction> transactions;
  final AssetTransaction? initial;
  final Future<void> Function(AssetTransaction tx) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  late TransactionType _type =
      widget.initial?.type ??
      TransactionRules.typesFor(widget.asset.category).first;
  late DateTime _date = (widget.initial?.date ?? DateTime.now()).toLocal();
  late String _amount = _centsText(widget.initial?.amountCents);
  late String _quantity = widget.initial?.quantity?.toString() ?? '';
  late String _fee = _centsText(widget.initial?.feeCents);
  late String _note = widget.initial?.note ?? '';
  bool _saving = false;

  static String _centsText(int? cents) =>
      cents == null ? '' : formatCentsForInput(cents);

  bool get _showQuantity =>
      TransactionRules.allowsQuantity(widget.asset.category, _type);

  bool get _quantityRequired =>
      TransactionRules.requiresQuantity(widget.asset.category, _type);

  bool get _showFee => TransactionRules.allowsFee(_type);

  String? _validateAmount(String? value) {
    final cents = parseEurosToCents(value ?? '');
    if (cents == null) return context.l10n.commonInvalidAmount;
    if (cents == 0 && _type != TransactionType.valuation) {
      return context.l10n.investmentsAmountPositive;
    }
    return null;
  }

  String? _validateQuantity(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return _quantityRequired ? context.l10n.commonRequired : null;
    }
    final quantity = parseQuantity(text);
    if (quantity == null) return context.l10n.commonInvalidNumber;
    if (_type == TransactionType.sell && _quantityRequired) {
      final available = TransactionRules.availableToSell(
        widget.transactions,
        excludingId: widget.initial?.id,
      );
      if (quantity > available) {
        return context.l10n.investmentsSellTooMuch(
          context.formatQuantity(available),
        );
      }
    }
    return null;
  }

  String? _validateFee(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return null;
    return parseEurosToCents(text) == null
        ? context.l10n.commonInvalidAmount
        : null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final fee = _showFee ? parseEurosToCents(_fee) : null;
    // Picked dates are calendar days: store local noon in UTC so the day
    // never shifts; today keeps the current time.
    final now = DateTime.now();
    final isToday =
        _date.year == now.year &&
        _date.month == now.month &&
        _date.day == now.day;
    final date = widget.initial == null && isToday
        ? now
        : DateTime(_date.year, _date.month, _date.day, 12);
    await widget.onSubmit(
      AssetTransaction(
        id: widget.initial?.id,
        assetId: widget.asset.id!,
        type: _type,
        date: date.toUtc(),
        amountCents: parseEurosToCents(_amount)!,
        quantity: _showQuantity ? parseQuantity(_quantity) : null,
        feeCents: fee == 0 ? null : fee,
        note: _note.trim().isEmpty ? null : _note.trim(),
      ),
    );
    if (mounted) setState(() => _saving = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final types = TransactionRules.typesFor(widget.asset.category);
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final type in types)
                ChoiceChip(
                  avatar: Icon(transactionIcon(type), size: 18),
                  label: Text(l10n.transactionType(type)),
                  selected: type == _type,
                  onSelected: (_) => setState(() => _type = type),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (_type == TransactionType.valuation) ...[
            Text(l10n.investmentsValuationHint),
            const SizedBox(height: 16),
          ],
          DateField(
            label: l10n.investmentsFieldDate,
            value: _date,
            lastDate: DateTime.now(),
            onChanged: (d) => setState(() => _date = d ?? _date),
          ),
          const SizedBox(height: 16),
          TextFormField(
            key: ValueKey('amount-$_type'),
            initialValue: _amount,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.transactionAmountLabel(_type),
              suffixText: '€',
            ),
            validator: _validateAmount,
            onChanged: (v) => _amount = v,
          ),
          if (_showQuantity) ...[
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _quantity,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: l10n.investmentsFieldQuantity,
                helperText: _quantityRequired ? null : l10n.commonOptional,
              ),
              validator: _validateQuantity,
              onChanged: (v) => _quantity = v,
            ),
          ],
          if (_showFee) ...[
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _fee,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: l10n.investmentsFieldFee,
                helperText: l10n.commonOptional,
                suffixText: '€',
              ),
              validator: _validateFee,
              onChanged: (v) => _fee = v,
            ),
          ],
          const SizedBox(height: 16),
          TextFormField(
            initialValue: _note,
            decoration: InputDecoration(labelText: l10n.investmentsFieldNote),
            onChanged: (v) => _note = v,
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _saving ? null : _submit,
            child: Text(l10n.commonSave),
          ),
        ],
      ),
    );
  }
}
