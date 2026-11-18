import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../domain/contribution_reminder.dart';

part 'reminder_scheduler.g.dart';

/// Schedules the monthly contribution notification on the device.
abstract interface class ReminderScheduler {
  /// Whether this platform can show scheduled notifications (not on web).
  bool get isSupported;

  /// Asks the user for permission to show notifications.
  Future<bool> requestPermission();

  /// Replaces any scheduled reminder with [reminder].
  Future<void> schedule(
    ContributionReminder reminder, {
    required String title,
    required String body,
    required String channelName,
  });

  Future<void> cancel();
}

/// [ReminderScheduler] backed by `flutter_local_notifications`.
class LocalNotificationsReminderScheduler implements ReminderScheduler {
  LocalNotificationsReminderScheduler([FlutterLocalNotificationsPlugin? plugin])
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  static const _notificationId = 1;
  static const _channelId = 'contribution_reminder';

  final FlutterLocalNotificationsPlugin _plugin;
  Future<void>? _initialized;

  @override
  bool get isSupported => !kIsWeb;

  Future<void> _ensureInitialized() => _initialized ??= _initialize();

  Future<void> _initialize() async {
    tz_data.initializeTimeZones();
    try {
      final zone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(zone.identifier));
    } on Object {
      // Unknown zone: keep UTC rather than failing to schedule.
    }
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        // Permission is requested when the user turns the reminder on.
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestSoundPermission: false,
          requestBadgePermission: false,
        ),
      ),
    );
  }

  @override
  Future<bool> requestPermission() async {
    if (!isSupported) return false;
    await _ensureInitialized();
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (android != null) {
      return await android.requestNotificationsPermission() ?? false;
    }
    final ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    if (ios != null) {
      return await ios.requestPermissions(alert: true, sound: true) ?? false;
    }
    return false;
  }

  @override
  Future<void> schedule(
    ContributionReminder reminder, {
    required String title,
    required String body,
    required String channelName,
  }) async {
    if (!isSupported) return;
    await _ensureInitialized();
    await _plugin.cancel(id: _notificationId);
    // Compare wall-clock times in the device zone.
    final now = tz.TZDateTime.now(tz.local);
    final next = reminder.nextAfter(
      DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second),
    );
    await _plugin.zonedSchedule(
      id: _notificationId,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime(
        tz.local,
        next.year,
        next.month,
        next.day,
        next.hour,
        next.minute,
      ),
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(_channelId, channelName),
        iOS: const DarwinNotificationDetails(),
      ),
      // Inexact: a few minutes late is fine and needs no exact-alarm permission.
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
    );
  }

  @override
  Future<void> cancel() async {
    if (!isSupported) return;
    await _ensureInitialized();
    await _plugin.cancel(id: _notificationId);
  }
}

@Riverpod(keepAlive: true)
ReminderScheduler reminderScheduler(Ref ref) =>
    LocalNotificationsReminderScheduler();
