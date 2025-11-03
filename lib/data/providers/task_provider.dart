import 'package:flutter/material.dart';
import 'package:todo_frontend/core/utils/toast.dart';
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

  // ADD THIS METHOD for updating task completion status
  Future<void> updateTaskCompletion(BuildContext context, String id, bool completed) async {
    // TODO: Implement when you have update endpoint ready
    // This would call your backend PUT /api/v1/tasks/{id} endpoint
    // For now, we'll just show a message
    showInfoToast(context, "Update feature coming soon!");
    
    // Once implemented, it would look like:
    // await _taskService.updateTask(context, id, completed);
    // await fetchTasks(context);
  }
}