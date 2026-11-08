import 'package:intl/intl.dart';

/// Utilities for date and time calculations in task scheduling.
class DateTimeUtils {
  DateTimeUtils._();

  /// Check if the given year is a leap year.
  static bool isLeapYear(int year) {
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
  }

  /// Get the total number of days in a given month and year.
  static int daysInMonth(int month, int year) {
    if (month == 2) {
      return isLeapYear(year) ? 29 : 28;
    } else if ([1, 3, 5, 7, 8, 10, 12].contains(month)) {
      return 31;
    } else {
      return 30;
    }
  }

  /// Check if a task should appear on [selectedDate] given its date and repeat rule.
  static bool isTaskScheduledForDate({
    required DateTime selectedDate,
    required String? taskDateStr,
    required String? repeat,
  }) {
    if (repeat == 'Mỗi Ngày') {
      return true;
    }

    if (taskDateStr == null || taskDateStr.isEmpty) {
      return false;
    }

    final formattedSelected = DateFormat.yMd().format(selectedDate);
    if (taskDateStr == formattedSelected) {
      return true;
    }

    if (repeat == 'Mỗi Tuần') {
      try {
        final DateTime taskDate = DateFormat.yMd().parse(taskDateStr);
        final int dayDifference = selectedDate.difference(taskDate).inDays;
        return dayDifference >= 0 && dayDifference % 7 == 0;
      } catch (_) {
        return false;
      }
    }

    if (repeat == 'Mỗi Tháng') {
      try {
        final DateTime taskDate = DateFormat.yMd().parse(taskDateStr);
        final int dim = daysInMonth(taskDate.month, taskDate.year);
        final int dayDifference = selectedDate.difference(taskDate).inDays;
        return dayDifference >= 0 && dayDifference % dim == 0;
      } catch (_) {
        return false;
      }
    }

    return false;
  }
}
