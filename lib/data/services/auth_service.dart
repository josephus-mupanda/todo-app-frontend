import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_frontend/core/utils/toast.dart';
import 'package:http/http.dart' as http ;
import '../models/auth_dto.dart';
import '../models/user.dart';

class AuthService {
  final String baseUrl = "http://localhost:8080/api/auth"; // adjust for your server

  Future<User?> register(BuildContext context, RegisterDTO dto) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': dto.username,
          'email': dto.email,
          'password': dto.password,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        showSuccessToast(context, "Registration successful! Please confirm your email.");
        return User.fromJson(data['data']);
      } else {
        final err = jsonDecode(response.body);
        showErrorToast(context, err['message'] ?? 'Registration failed.');
      }
    } catch (e) {
      showErrorToast(context, "Error: ${e.toString()}");
    }
    return null;
  }

  Future<User?> login(BuildContext context, LoginDTO dto) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': dto.email,
          'password': dto.password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final loginData = data['data'];
        showSuccessToast(context, "Welcome back ${loginData['username']}!");
        return User(
          id: '',
          username: loginData['username'],
          email: dto.email,
          token: loginData['accessToken'],
        );
      } else {
        final err = jsonDecode(response.body);
        showErrorToast(context, err['message'] ?? 'Login failed.');
      }
    } catch (e) {
      showErrorToast(context, "Error: ${e.toString()}");
    }
    return null;
  }

  Future<void> logout(BuildContext context, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        showSuccessToast(context, "Logged out successfully");
      } else {
        showWarningToast(context, "Could not log out properly");
      }
    } catch (e) {
      showErrorToast(context, "Error: ${e.toString()}");
    }
  }
  Future<http.Response?> resetPassword(BuildContext context, String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showSuccessToast(context, data['message'] ?? "Reset link sent to your email.");
      } else {
        showErrorToast(context, data['message'] ?? "Failed to reset password.");
      }
      return response;
    } catch (e) {
      showErrorToast(context, "Error: ${e.toString()}");
      return null;
    }
  }
}