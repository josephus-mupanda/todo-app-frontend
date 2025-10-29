import 'package:flutter/material.dart';
import 'package:todo_frontend/core/utils/toast.dart';
import 'package:todo_frontend/data/models/task.dart';
import 'package:uuid/uuid.dart';
import '../services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  final TaskService _taskService = TaskService();
  final List<Task> _tasks = [];

  List<Task> get tasks => List.unmodifiable(_tasks);

  Future<void> fetchTasks(BuildContext context) async {
    final data = await _taskService.getTasks();
    _tasks.clear();
    _tasks.addAll(data);
    notifyListeners();
  }

  Future<void> addTask(BuildContext context, String title, String description) async {
    if (title.isEmpty) {
      showWarningToast(context, 'Title cannot be empty');
      return;
    }

    final task = Task(
      id: const Uuid().v4(),
      title: title,
      description: description,
    );

    await _taskService.addTask(task);
    _tasks.add(task);
    notifyListeners();
    showSuccessToast(context, 'Task added successfully!');
  }

  Future<void> deleteTask(BuildContext context, String id) async {
    await _taskService.deleteTask(id);
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
    showDeleteToast(context, 'Task deleted');
  }

  void toggleComplete(BuildContext context, Task task) {
    task.isCompleted = !task.isCompleted;
    notifyListeners();
    showInfoToast(
      context,
      task.isCompleted ? 'Task marked as done' : 'Task marked as pending',
    );
  }
}
