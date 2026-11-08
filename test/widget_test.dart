import 'package:flutter_test/flutter_test.dart';
import 'package:checknow1/core/constants/app_colors.dart';
import 'package:checknow1/core/constants/app_constants.dart';
import 'package:checknow1/core/utils/date_time_utils.dart';
import 'package:checknow1/data/models/task_model.dart';

void main() {
  group('Task Model Unit Tests', () {
    test('Task should correctly serialize to and from JSON', () {
      final task = Task(
        id: 1,
        title: 'Complete Refactoring',
        note: 'Make codebase clean and production ready',
        date: '11/8/2026',
        startTime: '08:00 AM',
        endTime: '10:00 AM',
        color: 0,
        remind: 5,
        repeat: AppConstants.repeatDaily,
        isCompleted: 0,
      );

      final json = task.toJson();
      expect(json['id'], 1);
      expect(json['title'], 'Complete Refactoring');
      expect(json['repeat'], AppConstants.repeatDaily);

      final deserialized = Task.fromJson(json);
      expect(deserialized.id, task.id);
      expect(deserialized.title, task.title);
      expect(deserialized.note, task.note);
      expect(deserialized.date, task.date);
      expect(deserialized.startTime, task.startTime);
      expect(deserialized.endTime, task.endTime);
      expect(deserialized.color, task.color);
      expect(deserialized.remind, task.remind);
      expect(deserialized.repeat, task.repeat);
      expect(deserialized.isCompleted, task.isCompleted);
    });

    test('Task copyWith should modify specified fields and keep others intact', () {
      final task = Task(
        id: 1,
        title: 'Original Title',
        isCompleted: 0,
      );

      final updated = task.copyWith(
        title: 'Updated Title',
        isCompleted: 1,
      );

      expect(updated.id, 1);
      expect(updated.title, 'Updated Title');
      expect(updated.isCompleted, 1);
    });
  });

  group('DateTimeUtils Unit Tests', () {
    test('Leap year detection', () {
      expect(DateTimeUtils.isLeapYear(2024), true);
      expect(DateTimeUtils.isLeapYear(2028), true);
      expect(DateTimeUtils.isLeapYear(2000), true);
      expect(DateTimeUtils.isLeapYear(1900), false);
      expect(DateTimeUtils.isLeapYear(2025), false);
      expect(DateTimeUtils.isLeapYear(2026), false);
    });

    test('Days in month calculation', () {
      expect(DateTimeUtils.daysInMonth(1, 2026), 31);
      expect(DateTimeUtils.daysInMonth(2, 2024), 29); // Leap year
      expect(DateTimeUtils.daysInMonth(2, 2026), 28); // Non-leap year
      expect(DateTimeUtils.daysInMonth(4, 2026), 30);
      expect(DateTimeUtils.daysInMonth(12, 2026), 31);
    });

    test('Daily recurring task scheduling', () {
      final today = DateTime.now();
      expect(
        DateTimeUtils.isTaskScheduledForDate(
          selectedDate: today,
          taskDateStr: '1/1/2020',
          repeat: AppConstants.repeatDaily,
        ),
        true,
      );
    });

    test('Non-repeating task should match exact date only', () {
      final selectedDate = DateTime(2026, 11, 8);
      expect(
        DateTimeUtils.isTaskScheduledForDate(
          selectedDate: selectedDate,
          taskDateStr: '11/8/2026',
          repeat: AppConstants.repeatNone,
        ),
        true,
      );

      expect(
        DateTimeUtils.isTaskScheduledForDate(
          selectedDate: selectedDate,
          taskDateStr: '11/9/2026',
          repeat: AppConstants.repeatNone,
        ),
        false,
      );
    });
  });

  group('AppColors Palette Tests', () {
    test('getTaskColor returns distinct colors for indices', () {
      expect(AppColors.getTaskColor(0), AppColors.bluishCls);
      expect(AppColors.getTaskColor(1), AppColors.pinkCls);
      expect(AppColors.getTaskColor(2), AppColors.yellowCls);
      expect(AppColors.getTaskColor(99), AppColors.bluishCls);
    });
  });
}
