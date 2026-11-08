import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../data/models/task_model.dart';
import '../../modules/notification/views/notified_page.dart';
import '../constants/app_constants.dart';

/// Helper service for local system notifications and scheduled reminders.
class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _notification =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationDetails androidDetails =
      AndroidNotificationDetails(
    AppConstants.notificationChannelId,
    AppConstants.notificationChannelName,
    channelDescription: AppConstants.notificationChannelDesc,
    importance: Importance.max,
    priority: Priority.high,
  );

  /// Initializes timezone data and notification plugin.
  static Future<void> init() async {
    await _configureLocalTimezone();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('checknow');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notification.initialize(
      initializationSettings,
      onSelectNotification: selectNotification,
    );
  }

  /// Immediately dispatches a heads-up notification.
  static Future<void> pushNotification({
    required String title,
    required String body,
  }) async {
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _notification.show(
      _createUniqueId(),
      title,
      body,
      notificationDetails,
    );
  }

  /// Schedules notification when the task starts.
  static Future<void> scheduleStartNotification(String time, Task task) async {
    try {
      final parts = time.split(":");
      final int hour = int.parse(parts[0]);
      final int minutes = int.parse(parts[1]);

      await _notification.zonedSchedule(
        _createUniqueId(),
        'Bắt đầu: ${task.title ?? ""}',
        '${task.note ?? ""}',
        _convertTime(hour, minutes),
        const NotificationDetails(android: androidDetails),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: "${task.title}|${task.note}|Start",
      );
    } catch (e) {
      // Graceful error logging
    }
  }

  /// Schedules repeat reminder notification before or after start.
  static Future<void> scheduleRepeatNotification(Task task, int remind) async {
    if (remind <= 0 || task.startTime == null) return;

    try {
      final startDate = DateFormat("hh:mm a").parse(task.startTime!);
      final startMyTime = DateFormat("HH:mm").format(startDate);
      final parts = startMyTime.split(":");
      final int startHour = int.parse(parts[0]);
      final int startMinutes = int.parse(parts[1]);

      final tz.TZDateTime startTime = _convertTime(startHour, startMinutes);
      final tz.TZDateTime remindTime = startTime.add(Duration(minutes: remind));

      await _notification.zonedSchedule(
        _createUniqueId(),
        'Lặp lại: ${task.title ?? ""}',
        '${task.note ?? ""}',
        remindTime,
        const NotificationDetails(android: androidDetails),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: "${task.title}|${task.note}|Repeat",
      );
    } catch (e) {
      // Graceful error logging
    }
  }

  /// Schedules notification when the task ends.
  static Future<void> scheduleEndNotification(String time, Task task) async {
    try {
      final parts = time.split(":");
      final int hour = int.parse(parts[0]);
      final int minutes = int.parse(parts[1]);

      await _notification.zonedSchedule(
        _createUniqueId(),
        'Kết thúc: ${task.title ?? ""}',
        '${task.note ?? ""}',
        _convertTime(hour, minutes),
        const NotificationDetails(android: androidDetails),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: "${task.title}|${task.note}|End",
      );
    } catch (e) {
      // Graceful error logging
    }
  }

  static int _createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }

  static tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );

    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  static Future<void> _configureLocalTimezone() async {
    tz.initializeTimeZones();
    try {
      final String timeZone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZone));
    } catch (_) {
      // Fallback if timezone detection fails
    }
  }

  static Future selectNotification(String? payload) async {
    if (payload != null) {
      Get.to(() => NotifiedPage(label: payload));
    }
  }
}
