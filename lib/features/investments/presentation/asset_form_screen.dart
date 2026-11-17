import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/router/routes.dart';
import '../../../core/widgets/async_value_view.dart';
import '../data/investments_repository.dart';
import '../domain/asset.dart';
import '../domain/asset_metadata.dart';
import '../domain/investment_enums.dart';
import 'investment_labels.dart';
import 'investments_providers.dart';
import 'widgets/asset_metadata_fields.dart';
import 'widgets/goal_dropdown.dart';

/// Creates a new asset in a category, or edits an existing one.
class AssetFormScreen extends ConsumerWidget {
  const AssetFormScreen.create({super.key, required AssetCategory category})
    : _category = category,
      _assetId = null;

  const AssetFormScreen.edit({super.key, required int assetId})
    : _assetId = assetId,
      _category = null;

  final AssetCategory? _category;
  final int? _assetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = _assetId;
    if (id == null) return _AssetForm(category: _category!);

    return AsyncValueView(
      value: ref.watch(assetProvider(id)),
      data: (asset) => asset == null
          ? const Scaffold(body: SizedBox.shrink())
          : _AssetForm(category: asset.category, initial: asset),
    );
  }
}

class _AssetForm extends ConsumerStatefulWidget {
  const _AssetForm({required this.category, this.initial});

  final AssetCategory category;
  final Asset? initial;

  @override
  ConsumerState<_AssetForm> createState() => _AssetFormState();
}

class _AssetFormState extends ConsumerState<_AssetForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name = widget.initial?.name ?? '';
  late String _notes = widget.initial?.notes ?? '';
  late int? _goalId = widget.initial?.goalId;
  late Map<String, Object?> _metadata = {...?widget.initial?.metadata};
  bool _saving = false;

  bool get _isEdit => widget.initial != null;

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final repo = ref.read(investmentsRepositoryProvider);
    final initial = widget.initial;
    final asset = Asset(
      id: initial?.id,
      category: widget.category,
      name: _name.trim(),
      goalId: _goalId,
      metadata: AssetMetadata.clean(widget.category, _metadata),
      notes: _notes.trim().isEmpty ? null : _notes.trim(),
      createdAt: initial?.createdAt ?? DateTime.now().toUtc(),
      archived: initial?.archived ?? false,
    );
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    try {
      if (initial == null) {
        await repo.addAsset(asset);
      } else {
        await repo.updateAsset(asset);
      }
      if (mounted) context.pop();
    } on Exception {
      messenger.showSnackBar(SnackBar(content: Text(l10n.commonSaveError)));
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _delete() async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.investmentsDeleteAssetTitle),
        content: Text(l10n.investmentsDeleteAssetBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    await ref
        .read(investmentsRepositoryProvider)
        .deleteAsset(widget.initial!.id!);
    if (mounted) context.go(Routes.investmentCategory(widget.category));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEdit ? l10n.investmentsEditAsset : l10n.investmentsNewAsset,
        ),
        actions: [
          if (_isEdit)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: l10n.commonDelete,
              onPressed: _saving ? null : _delete,
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Chip(
                avatar: Icon(assetCategoryIcon(widget.category), size: 18),
                label: Text(l10n.assetCategory(widget.category)),
              ),
            ),
            TextFormField(
              initialValue: _name,
              autofocus: !_isEdit,
              textCapitalization: TextCapitalization.sentences,
              maxLength: 60,
              decoration: InputDecoration(labelText: l10n.investmentsFieldName),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? l10n.commonRequired : null,
              onChanged: (v) => _name = v,
            ),
            const SizedBox(height: 8),
            AssetMetadataFields(
              category: widget.category,
              metadata: _metadata,
              onChanged: (m) => setState(() => _metadata = m),
            ),
            GoalDropdown(
              value: _goalId,
              onChanged: (id) => setState(() => _goalId = id),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _notes,
              minLines: 2,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: l10n.investmentsFieldNotes,
              ),
              onChanged: (v) => _notes = v,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: Text(l10n.commonSave),
            ),
          ],
        ),
      ),
    );
  }
}
