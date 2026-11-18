import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../data/backup_service.dart';
import '../../../investments/presentation/investment_labels.dart';
import '../../../investments/presentation/transaction_labels.dart';
import '../../data/data_management.dart';
import '../../domain/transactions_csv.dart';

/// Export (backup and CSV), import and delete all data.
class DataSection extends ConsumerWidget {
  const DataSection({super.key});

  Future<void> _export(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    try {
      await ref.read(dataManagementProvider).exportBackup();
    } on Exception {
      messenger.showSnackBar(SnackBar(content: Text(l10n.profileExportError)));
    }
  }

  Future<void> _exportCsv(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    final labels = TransactionsCsvLabels(
      headers: [
        l10n.profileCsvDate,
        l10n.profileCsvAsset,
        l10n.profileCsvCategory,
        l10n.profileCsvType,
        l10n.profileCsvAmount,
        l10n.profileCsvQuantity,
        l10n.profileCsvFee,
        l10n.profileCsvNote,
      ],
      category: l10n.assetCategory,
      type: l10n.transactionType,
    );
    try {
      final exported = await ref
          .read(dataManagementProvider)
          .exportTransactionsCsv(labels);
      if (!exported) {
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.profileExportCsvEmpty)),
        );
      }
    } on Exception {
      messenger.showSnackBar(SnackBar(content: Text(l10n.profileExportError)));
    }
  }

  Future<void> _import(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    final data = ref.read(dataManagementProvider);
    final json = await data.pickBackup();
    if (json == null || !context.mounted) return;
    final confirmed = await showConfirmDialog(
      context: context,
      title: l10n.profileImportConfirmTitle,
      message: l10n.profileImportConfirmBody,
      confirmLabel: l10n.profileImportConfirm,
      destructive: true,
    );
    if (!confirmed) return;
    try {
      await data.importBackup(json);
      messenger.showSnackBar(SnackBar(content: Text(l10n.profileImportDone)));
    } on BackupFormatException {
      messenger.showSnackBar(SnackBar(content: Text(l10n.profileImportError)));
    }
  }

  Future<void> _deleteAll(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final confirmed = await showConfirmDialog(
      context: context,
      title: l10n.profileDeleteAllTitle,
      message: l10n.profileDeleteAllBody,
      confirmLabel: l10n.profileDeleteAllConfirm,
      destructive: true,
    );
    if (confirmed) await ref.read(dataManagementProvider).deleteAll();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final error = Theme.of(context).colorScheme.error;
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.upload_file),
          title: Text(l10n.profileExport),
          subtitle: Text(l10n.profileExportSubtitle),
          onTap: () => _export(context, ref),
        ),
        ListTile(
          leading: const Icon(Icons.table_view_outlined),
          title: Text(l10n.profileExportCsv),
          subtitle: Text(l10n.profileExportCsvSubtitle),
          onTap: () => _exportCsv(context, ref),
        ),
        ListTile(
          leading: const Icon(Icons.download_outlined),
          title: Text(l10n.profileImport),
          subtitle: Text(l10n.profileImportSubtitle),
          onTap: () => _import(context, ref),
        ),
        ListTile(
          leading: Icon(Icons.delete_forever_outlined, color: error),
          title: Text(l10n.profileDeleteAll, style: TextStyle(color: error)),
          subtitle: Text(l10n.profileDeleteAllSubtitle),
          onTap: () => _deleteAll(context, ref),
        ),
      ],
    );
  }
}
