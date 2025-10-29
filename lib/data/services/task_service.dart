import 'package:todo_frontend/data/models/task.dart';


class TaskService {
  final List<Task> _mockTasks = [];

  Future<List<Task>> getTasks() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockTasks;
  }

  Future<void> addTask(Task task) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _mockTasks.add(task);
  }

  Future<void> deleteTask(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _mockTasks.removeWhere((task) => task.id == id);
  }
}
