import 'package:invest_young/features/profile/data/reminder_scheduler.dart';
import 'package:invest_young/features/profile/domain/contribution_reminder.dart';

/// In-memory [ReminderScheduler] that records what would be on the device.
class FakeReminderScheduler implements ReminderScheduler {
  FakeReminderScheduler({this.permissionGranted = true});

  bool permissionGranted;
  int permissionRequests = 0;

  ContributionReminder? scheduled;
  String? title;
  String? body;

  @override
  bool get isSupported => true;

  @override
  Future<bool> requestPermission() async {
    permissionRequests++;
    return permissionGranted;
  }

  @override
  Future<void> schedule(
    ContributionReminder reminder, {
    required String title,
    required String body,
    required String channelName,
  }) async {
    scheduled = reminder;
    this.title = title;
    this.body = body;
  }

  @override
  Future<void> cancel() async {
    scheduled = null;
    title = null;
    body = null;
  }
}
