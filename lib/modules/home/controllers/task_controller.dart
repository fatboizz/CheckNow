import 'package:get/get.dart';
import '../../../data/models/task_model.dart';
import '../../../data/repositories/task_repository.dart';

/// GetX controller managing Task state and CRUD operations.
class TaskController extends GetxController {
  final ITaskRepository _repository;

  TaskController({ITaskRepository? repository})
      : _repository = repository ?? const TaskRepository();

  final RxList<Task> taskList = <Task>[].obs;

  @override
  void onReady() {
    super.onReady();
    getTask();
  }

  /// Inserts a new task and updates the state.
  Future<int> addTask({required Task? task}) async {
    if (task == null) return -1;
    final int result = await _repository.insertTask(task);
    if (result > 0) {
      Get.snackbar("Thành công", "Đã hẹn giờ!");
      await getTask();
    } else {
      Get.snackbar("Lỗi", "Không thể thêm ghi chú!");
    }
    return result;
  }

  /// Fetches all stored tasks into [taskList].
  Future<void> getTask() async {
    final List<Task> tasks = await _repository.getAllTasks();
    taskList.assignAll(tasks);
  }

  /// Deletes a task and refreshes list.
  Future<void> delete(Task task) async {
    await _repository.deleteTask(task);
    await getTask();
  }

  /// Marks a task as completed and refreshes list.
  Future<void> markTaskCompleted(int id) async {
    await _repository.markTaskAsCompleted(id);
    await getTask();
  }
}

