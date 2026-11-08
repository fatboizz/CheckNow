import '../models/task_model.dart';
import '../providers/db_provider.dart';

/// Abstract contract for task persistence operations.
abstract class ITaskRepository {
  Future<int> insertTask(Task task);
  Future<List<Task>> getAllTasks();
  Future<int> deleteTask(Task task);
  Future<int> markTaskAsCompleted(int id);
  Future<int> resetDailyTasks();
}

/// Concrete implementation of [ITaskRepository] backed by [DBProvider].
class TaskRepository implements ITaskRepository {
  const TaskRepository();

  @override
  Future<int> insertTask(Task task) async {
    return await DBProvider.insert(task);
  }

  @override
  Future<List<Task>> getAllTasks() async {
    final List<Map<String, dynamic>> rawData = await DBProvider.query();
    return rawData.map((data) => Task.fromJson(data)).toList();
  }

  @override
  Future<int> deleteTask(Task task) async {
    return await DBProvider.delete(task);
  }

  @override
  Future<int> markTaskAsCompleted(int id) async {
    return await DBProvider.update(id);
  }

  @override
  Future<int> resetDailyTasks() async {
    return await DBProvider.updateIsCompletedToZero();
  }
}
