import 'package:flutter/material.dart';
import 'package:todo_frontend/data/models/task.dart';
import '../services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  final TaskService _taskService = TaskService();
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  Future<void> fetchTasks(BuildContext context) async {
    _tasks = await _taskService.fetchTasks(context);
    notifyListeners();
  }

  Future<void> addTask(BuildContext context, String title) async {
    await _taskService.addTask(context, title);
    await fetchTasks(context);
  }

  Future<void> deleteTask(BuildContext context, String id) async {
    await _taskService.deleteTask(context, id);
    await fetchTasks(context);
  }

  Future<void> updateTaskTitle(
    BuildContext context,
    String id,
    String title,
  ) async {
    await _taskService.updateTask(context, id, title: title);
    await fetchTasks(context);
  }

  Future<void> updateTaskCompletion(
    BuildContext context,
    String id,
    bool completed,
  ) async {
    
    final task = _tasks.firstWhere((t) => t.id == id); 

    await _taskService.updateTask(
      context,
      id,
      title: task.title,
      completed: completed,
    );
    await fetchTasks(context);
  }
}
