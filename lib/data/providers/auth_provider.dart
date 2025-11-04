import 'package:flutter/material.dart';
import 'package:todo_frontend/core/utils/toast.dart';
import 'package:todo_frontend/data/models/auth_dto.dart';
import 'package:todo_frontend/data/models/user.dart';
import 'package:todo_frontend/data/services/secure_storage_service.dart';
import 'package:todo_frontend/routes/app_routes.dart';
import '../services/auth_service.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final SecureStorageService _storage = SecureStorageService();

  User? _user;
  User? get user => _user;
  bool get isAuthenticated => _user != null;

  Future<void> login(BuildContext context, LoginDTO dto) async {
    final user = await _authService.login(context, dto);
    if (user != null) {
      _user = user;
      await _storage.saveToken(user.token ?? '');
      notifyListeners();
    }
  }

  Future<void> register(BuildContext context, RegisterDTO dto) async {
    final user = await _authService.register(context, dto);
    if (user != null) {
      _user = user;
      notifyListeners();
    }
  }

  Future<void> updateUser(
    BuildContext context, {
    String? username,
    String? email,
  }) async {
    if (_user == null) return;

    final token = await _storage.getToken();
    if (token == null) {
      showErrorToast(context, "No valid session found.");
      return;
    }

    final updatedUser = await _authService.updateUser(
      context,
      token,
      username: username,
      email: email,
    );

 if (updatedUser != null) {
    // IMPORTANT: Preserve the token from the current user
    _user = User(
      id: updatedUser.id,
      username: updatedUser.username,
      email: updatedUser.email,
      token: token, // Use the existing token instead of updatedUser.token
    );
    notifyListeners();
  }
    // if (updatedUser != null) {
    //   _user = updatedUser;
    //   notifyListeners();
    // }
  }

  Future<void> logout(BuildContext context) async {
    final token = await _storage.getToken();
    await _storage.deleteToken();
    _user = null;
    notifyListeners();

    // Call backend only if token exists
    if (token != null) {
      try {
        final success = await _authService.logout(token);
        if (success && context.mounted) {
          // Navigate first
          Navigator.pushReplacementNamed(context, AppRoutes.login);
          // Show toast after navigation
          _authService.showLogoutToast(context);
        }
      } catch (e) {
        if (context.mounted) {
          _authService.showLogoutErrorToast(context, e.toString());
        }
      }
    } else {
      // No token: just navigate
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  Future<http.Response?> resetPassword(
    BuildContext context,
    String email,
  ) async {
    return await _authService.resetPassword(context, email);
  }

  Future<bool> changePassword(
    BuildContext context,
    String code,
    String newPassword,
  ) async {
    return await _authService.changePassword(context, code, newPassword);
  }

  Future<bool> confirmEmail(BuildContext context, String code) async {
    return await _authService.confirmEmail(context, code);
  }
}
