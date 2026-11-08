/// Application-wide constants.
class AppConstants {
  AppConstants._();

  // Database Constants
  static const String dbName = 'task1.db';
  static const int dbVersion = 1;
  static const String taskTableName = 'tasks1';

  // Storage Keys
  static const String isDarkModeKey = 'isDarkMode';

  // Task Repeat Options
  static const String repeatNone = 'Không';
  static const String repeatDaily = 'Mỗi Ngày';
  static const String repeatWeekly = 'Mỗi Tuần';
  static const String repeatMonthly = 'Mỗi Tháng';

  static const List<String> repeatOptions = [
    repeatNone,
    repeatDaily,
    repeatWeekly,
    repeatMonthly,
  ];

  // Task Reminder Options (minutes)
  static const List<int> reminderOptions = [
    1,
    5,
    10,
    15,
    20,
  ];

  // Notification Configuration
  static const String notificationChannelId = 'importance_channel';
  static const String notificationChannelName = 'Task Reminder Channel';
  static const String notificationChannelDesc =
      'This channel is used for TodoList task notifications and reminders';
}

