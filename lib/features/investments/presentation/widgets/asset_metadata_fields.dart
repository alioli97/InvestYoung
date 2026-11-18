import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/l10n/money_input.dart';
import '../../../../core/widgets/date_field.dart';
import '../../domain/asset_metadata.dart';
import '../../domain/investment_enums.dart';
import '../asset_metadata_labels.dart';

/// Category-specific fields of the asset form. Edits [metadata] in place
/// through [onChanged] with the updated map.
class AssetMetadataFields extends StatefulWidget {
  const AssetMetadataFields({
    super.key,
    required this.category,
    required this.metadata,
    required this.onChanged,
  });

  final AssetCategory category;
  final Map<String, Object?> metadata;
  final ValueChanged<Map<String, Object?>> onChanged;

  @override
  State<AssetMetadataFields> createState() => _AssetMetadataFieldsState();
}

class _AssetMetadataFieldsState extends State<AssetMetadataFields> {
  void _set(String key, Object? value) =>
      widget.onChanged({...widget.metadata, key: value});

  Widget _text(String key, String label, {bool upperCase = false}) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: TextFormField(
      initialValue: AssetMetadata.text(widget.metadata, key),
      textCapitalization: upperCase
          ? TextCapitalization.characters
          : TextCapitalization.words,
      decoration: InputDecoration(labelText: label),
      onChanged: (v) => _set(key, upperCase ? v.toUpperCase() : v),
    ),
  );

  Widget _percent(String key, String label) {
    final initial = AssetMetadata.ratio(widget.metadata, key);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        initialValue: initial == null ? null : formatRatioForInput(initial),
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
          signed: true,
        ),
        decoration: InputDecoration(labelText: label, suffixText: '%'),
        validator: (v) => v == null || v.trim().isEmpty
            ? null
            : parsePercentToRatio(v) == null
            ? context.l10n.commonInvalidNumber
            : null,
        onChanged: (v) => _set(key, parsePercentToRatio(v)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final m = widget.metadata;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: switch (widget.category) {
        AssetCategory.emergency => [
          _text(AssetMetadata.institution, l10n.investmentsFieldInstitution),
          _percent(AssetMetadata.apy, l10n.investmentsFieldApy),
        ],
        AssetCategory.fixedIncome => [
          _text(AssetMetadata.issuer, l10n.investmentsFieldIssuer),
          _percent(AssetMetadata.yieldRate, l10n.investmentsFieldYield),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: DateField(
              label: l10n.investmentsFieldMaturity,
              value: AssetMetadata.date(m, AssetMetadata.maturityDate),
              clearable: true,
              onChanged: (d) => _set(
                AssetMetadata.maturityDate,
                d == null ? null : AssetMetadata.encodeDate(d),
              ),
            ),
          ),
        ],
        AssetCategory.equity => [
          _text(
            AssetMetadata.ticker,
            l10n.investmentsFieldTicker,
            upperCase: true,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: DropdownButtonFormField<EquitySubtype>(
              initialValue: AssetMetadata.equitySubtype(m),
              decoration: InputDecoration(
                labelText: l10n.investmentsFieldSubtype,
              ),
              items: [
                for (final s in EquitySubtype.values)
                  DropdownMenuItem(
                    value: s,
                    child: Text(l10n.equitySubtype(s)),
                  ),
              ],
              onChanged: (s) => _set(AssetMetadata.subtype, s?.dbValue),
            ),
          ),
        ],
        AssetCategory.crypto => [
          _text(
            AssetMetadata.symbol,
            l10n.investmentsFieldSymbol,
            upperCase: true,
          ),
          _text(AssetMetadata.exchange, l10n.investmentsFieldExchange),
        ],
      },
    );
  }
}
