import 'dart:async';
import 'package:get/get.dart';
import '../../../data/providers/db_provider.dart';
import 'task_controller.dart';

/// Schedules automatic task status reset at midnight for recurring daily tasks.
class TaskResetScheduler {
  TaskResetScheduler._();

  static Timer? _dailyTimer;

  /// Schedules daily task reset at upcoming midnight.
  static void scheduleDailyReset() {
    _dailyTimer?.cancel();

    final DateTime now = DateTime.now();
    final DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
    final Duration durationUntilMidnight = tomorrow.difference(now);

    _dailyTimer = Timer(durationUntilMidnight, () async {
      await DBProvider.updateIsCompletedToZero();

      scheduleDailyReset();

      if (Get.isRegistered<TaskController>()) {
        final TaskController taskController = Get.find<TaskController>();
        await taskController.getTask();
      }
    });
  }

  /// Cancels any active scheduled reset timer.
  static void cancel() {
    _dailyTimer?.cancel();
  }
}

