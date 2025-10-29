import 'package:flutter/material.dart';
import 'package:todo_frontend/core/utils/toast.dart';
import 'package:todo_frontend/data/models/auth_dto.dart';
import 'package:todo_frontend/data/models/user.dart';
import 'package:todo_frontend/data/services/secure_storage_service.dart';
import '../services/auth_service.dart';


class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final SecureStorageService _storage = SecureStorageService();

  User? _user;
  User? get user => _user;

  bool get isAuthenticated => _user != null;

  Future<void> login(BuildContext context, LoginDTO dto) async {
    final user = await _authService.login(dto);
    if (user != null) {
      _user = user;
      await _storage.saveToken(user.token);
      showSuccessToast(context, 'Welcome back, ${user.username}!');
      notifyListeners();
    } else {
      showErrorToast(context, 'Invalid email or password');
    }
  }

  Future<void> register(BuildContext context, RegisterDTO dto) async {
    final user = await _authService.register(dto);
    if (user != null) {
      _user = user;
      await _storage.saveToken(user.token);
      showSuccessToast(context, 'Account created successfully!');
      notifyListeners();
    } else {
      showErrorToast(context, 'Registration failed.');
    }
  }

  Future<void> logout(BuildContext context) async {
    _user = null;
    await _storage.deleteToken();
    showInfoToast(context, 'You have been logged out.');
    notifyListeners();
  }
}
