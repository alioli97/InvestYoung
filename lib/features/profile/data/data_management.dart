import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/app_theme_mode.dart';
import '../../../core/l10n/locale_provider.dart';
import '../../../core/theme/theme_mode_provider.dart';
import '../../onboarding/data/profile_repository.dart';
import '../../onboarding/presentation/onboarding_status_provider.dart';
import 'backup_files.dart';
import 'backup_service.dart';

part 'data_management.g.dart';

/// Backup and delete actions from Profile, keeping app state (onboarding
/// status, language and theme) in sync with the data afterwards.
class DataManagement {
  const DataManagement(this._ref);

  final Ref _ref;

  static String fileName(DateTime now) {
    String two(int n) => n.toString().padLeft(2, '0');
    return 'invest-young-backup-${now.year}-${two(now.month)}-${two(now.day)}.json';
  }

  Future<void> exportBackup() async {
    final json = await _ref.read(backupServiceProvider).exportJson();
    await _ref.read(backupFilesProvider).share(json, fileName(DateTime.now()));
  }

  /// Asks for a file and returns its contents (`null` if cancelled).
  Future<String?> pickBackup() => _ref.read(backupFilesProvider).pick();

  /// Replaces all data with [json]. Throws [BackupFormatException].
  Future<void> importBackup(String json) async {
    await _ref.read(backupServiceProvider).importJson(json);
    await _syncState();
  }

  Future<void> deleteAll() async {
    await _ref.read(backupServiceProvider).deleteAll();
    await _syncState();
  }

  Future<void> _syncState() async {
    final profile = await _ref.read(profileRepositoryProvider).getProfile();
    _ref
        .read(onboardingStatusProvider.notifier)
        .set(completed: profile?.onboardingCompleted ?? false);
    _ref
        .read(appLocaleProvider.notifier)
        .set(profile == null ? null : Locale(profile.locale));
    _ref
        .read(themePreferenceProvider.notifier)
        .set(profile?.themeMode ?? AppThemeMode.system);
  }
}

@Riverpod(keepAlive: true)
DataManagement dataManagement(Ref ref) => DataManagement(ref);
