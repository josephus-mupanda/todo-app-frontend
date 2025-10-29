import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_frontend/core/config/app_config.dart';

class ApiClient {
  final http.Client _client = http.Client();
  String? _token;

  void setToken(String? token) => _token = token;

  Map<String, String> _headers({bool authorized = false}) {
    final headers = {'Content-Type': 'application/json'};
    if (authorized && _token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  Future<http.Response> post(String path, Map<String, dynamic> body,
      {bool authorized = false}) async {
    final uri = Uri.parse("${AppConfig.baseUrl}$path");
    return await _client.post(uri,
        headers: _headers(authorized: authorized), body: jsonEncode(body));
  }

  Future<http.Response> get(String path, {bool authorized = false}) async {
    final uri = Uri.parse("${AppConfig.baseUrl}$path");
    return await _client.get(uri, headers: _headers(authorized: authorized));
  }

  Future<http.Response> put(String path, Map<String, dynamic> body,
      {bool authorized = false}) async {
    final uri = Uri.parse("${AppConfig.baseUrl}$path");
    return await _client.put(uri,
        headers: _headers(authorized: authorized), body: jsonEncode(body));
  }

  Future<http.Response> delete(String path, {bool authorized = false}) async {
    final uri = Uri.parse("${AppConfig.baseUrl}$path");
    return await _client.delete(uri, headers: _headers(authorized: authorized));
  }
}

final apiClient = ApiClient();
