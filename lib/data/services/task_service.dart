import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_frontend/core/utils/toast.dart';
import 'package:todo_frontend/data/models/task.dart';
import 'package:todo_frontend/data/services/secure_storage_service.dart';
import 'package:http/http.dart' as http;

class TaskService {
  final String baseUrl = "http://localhost:8080/api/v1/tasks";
  final SecureStorageService _storage = SecureStorageService();

  Future<List<Task>> fetchTasks(BuildContext context) async {
    try {
      final token = await _storage.getToken();
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((task) => Task.fromJson(task)).toList();
      } else {
        showErrorToast(context, "Failed to fetch tasks");
      }
    } catch (e) {
      showErrorToast(context, "Error: ${e.toString()}");
    }
    return [];
  }

  Future<void> addTask(BuildContext context, String title) async {
    try {
      final token = await _storage.getToken();
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'title': title}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        showSuccessToast(context, "Task added successfully!");
      } else {
        showErrorToast(context, "Failed to add task");
      }
    } catch (e) {
      showErrorToast(context, "Error: ${e.toString()}");
    }
  }

  // Add this method to your TaskService class
  Future<void> updateTask(BuildContext context, String id, bool completed) async {
    try {
      final token = await _storage.getToken();
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'title': 'Existing Title', // You might need to send the existing title
          'completed': completed,
        }),
      );

      if (response.statusCode == 200) {
        showSuccessToast(context, "Task updated successfully!");
      } else {
        showErrorToast(context, "Failed to update task");
      }
    } catch (e) {
      showErrorToast(context, "Error: ${e.toString()}");
    }
  }

  Future<void> deleteTask(BuildContext context, String id) async {
    try {
      final token = await _storage.getToken();
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 204) {
        showDeleteToast(context, "Task deleted successfully");
      } else {
        showWarningToast(context, "Could not delete task");
      }
    } catch (e) {
      showErrorToast(context, "Error: ${e.toString()}");
    }
  }
}