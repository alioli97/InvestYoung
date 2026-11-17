import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'backup_files.g.dart';

/// Platform side of backups: sharing/saving the file and picking one.
/// Separate from [BackupService] so tests can replace it.
abstract interface class BackupFiles {
  /// Shares (or, on web, downloads) [json] as a file named [fileName].
  Future<void> share(String json, String fileName);

  /// Lets the user pick a backup; returns its contents or `null` if cancelled.
  Future<String?> pick();
}

class PlatformBackupFiles implements BackupFiles {
  const PlatformBackupFiles();

  @override
  Future<void> share(String json, String fileName) async {
    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile.fromData(
            utf8.encode(json),
            mimeType: 'application/json',
            name: fileName,
          ),
        ],
        fileNameOverrides: [fileName],
      ),
    );
  }

  @override
  Future<String?> pick() async {
    final file = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: const ['json'],
    );
    return file?.xFile.readAsString();
  }
}

@Riverpod(keepAlive: true)
BackupFiles backupFiles(Ref ref) => const PlatformBackupFiles();
