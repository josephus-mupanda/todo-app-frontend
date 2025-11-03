import 'package:flutter/material.dart';
import 'package:todo_frontend/data/models/auth_dto.dart';
import 'package:todo_frontend/data/models/user.dart';
import 'package:todo_frontend/data/services/secure_storage_service.dart';
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

  Future<void> logout(BuildContext context) async {
    final token = await _storage.getToken();
    if (token != null) await _authService.logout(context, token);
    await _storage.deleteToken();
    _user = null;
    notifyListeners();
  }

  Future<http.Response?> resetPassword(BuildContext context, String email) async {
    return await _authService.resetPassword(context, email);
  }

  Future<bool> changePassword(BuildContext context, String code, String newPassword) async {
    return await _authService.changePassword(context, code, newPassword);
  }

  Future<bool> confirmEmail(BuildContext context, String code) async {
    return await _authService.confirmEmail(context, code);
  }

}