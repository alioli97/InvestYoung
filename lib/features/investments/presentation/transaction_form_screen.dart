import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/widgets/async_value_view.dart';
import '../data/investments_repository.dart';
import '../domain/asset.dart';
import '../domain/asset_transaction.dart';
import 'investments_providers.dart';
import 'widgets/transaction_form.dart';

/// Adds a transaction to an asset, or edits/deletes an existing one.
class TransactionFormScreen extends ConsumerWidget {
  const TransactionFormScreen({
    super.key,
    required this.assetId,
    this.transactionId,
  });

  final int assetId;
  final int? transactionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asset = ref.watch(assetProvider(assetId));
    final transactions = ref.watch(assetTransactionsProvider(assetId));
    return AsyncValueView(
      value: asset,
      data: (asset) => AsyncValueView(
        value: transactions,
        data: (transactions) {
          if (asset == null) return const Scaffold(body: SizedBox.shrink());
          final initial = transactionId == null
              ? null
              : transactions.where((t) => t.id == transactionId).firstOrNull;
          if (transactionId != null && initial == null) {
            // Deleted while open.
            return const Scaffold(body: SizedBox.shrink());
          }
          return _TransactionFormPage(
            asset: asset,
            transactions: transactions,
            initial: initial,
          );
        },
      ),
    );
  }
}

class _TransactionFormPage extends ConsumerWidget {
  const _TransactionFormPage({
    required this.asset,
    required this.transactions,
    this.initial,
  });

  final Asset asset;
  final List<AssetTransaction> transactions;
  final AssetTransaction? initial;

  Future<void> _save(
    BuildContext context,
    WidgetRef ref,
    AssetTransaction tx,
  ) async {
    final repo = ref.read(investmentsRepositoryProvider);
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    final l10n = context.l10n;
    try {
      if (tx.id == null) {
        await repo.addTransaction(tx);
      } else {
        await repo.updateTransaction(tx);
      }
      router.pop();
    } on Exception {
      messenger.showSnackBar(SnackBar(content: Text(l10n.commonSaveError)));
    }
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final router = GoRouter.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.investmentsDeleteTransactionTitle),
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
    if (confirmed != true) return;
    await ref
        .read(investmentsRepositoryProvider)
        .deleteTransaction(initial!.id!);
    router.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          initial == null
              ? l10n.investmentsNewTransaction
              : l10n.investmentsEditTransaction,
        ),
        actions: [
          if (initial != null)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: l10n.commonDelete,
              onPressed: () => _delete(context, ref),
            ),
        ],
      ),
      body: TransactionForm(
        asset: asset,
        transactions: transactions,
        initial: initial,
        onSubmit: (tx) => _save(context, ref, tx),
      ),
    );
  }
}
