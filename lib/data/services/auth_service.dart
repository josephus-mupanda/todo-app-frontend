import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_frontend/core/utils/toast.dart';
import 'package:http/http.dart' as http ;
import '../models/auth_dto.dart';
import '../models/user.dart';

class AuthService {
  final String baseUrl = "http://localhost:8080/api/auth";

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

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 201) {
        showSuccessToast(context, data['message'] ?? "Registration successful! Please confirm your email.");
        
        // Extract user from payload
        if (data['payload'] != null) {
          return User.fromJson(data['payload']);
        }
        return null;
      } else {
        showErrorToast(context, data['message'] ?? 'Registration failed.');
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
          'username': dto.email, // Your backend expects 'username' field
          'password': dto.password,
        }),
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        final loginData = data['payload']; // Extract from payload
        showSuccessToast(context, "Welcome back ${loginData['username']}!");
        
        return User(
          id: loginData['id'] ?? '',
          username: loginData['username'],
          email: dto.email,
          token: loginData['accessToken'],
        );
      } else {
        showErrorToast(context, data['message'] ?? 'Login failed.');
      }
    } catch (e) {
      showErrorToast(context, "Error: ${e.toString()}");
    }
    return null;
  }

  Future<bool> confirmEmail(BuildContext context, String code) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/confirm?code=$code'),
        headers: {'Content-Type': 'application/json'},
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        showSuccessToast(context, data['message'] ?? "Email confirmed successfully!");
        return true;
      } else {
        // Your backend throws exceptions, so this might not be reached
        // But we'll handle it anyway
        showErrorToast(context, data['message'] ?? "Email confirmation failed.");
        return false;
      }
    } catch (e) {
      // This will catch the BadRequestException from your backend
      showErrorToast(context, "Email confirmation failed: ${e.toString()}");
      return false;
    }
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

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        showSuccessToast(context, data['message'] ?? "Logged out successfully");
      } else {
        showWarningToast(context, data['message'] ?? "Could not log out properly");
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

  // Add change password method
  Future<bool> changePassword(BuildContext context, String code, String newPassword) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/change-password?code=$code'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'password': newPassword}),
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        showSuccessToast(context, data['message'] ?? "Password changed successfully!");
        return true;
      } else {
        showErrorToast(context, data['message'] ?? "Failed to change password.");
        return false;
      }
    } catch (e) {
      showErrorToast(context, "Error changing password: ${e.toString()}");
      return false;
    }
  }
}