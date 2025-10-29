import '../models/auth_dto.dart';
import '../models/user.dart';

class AuthService {
  Future<User?> login(LoginDTO dto) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network delay
    if (dto.email == "test@example.com" && dto.password == "1234") {
      return User(
        id: '1',
        email: dto.email,
        username: 'Test User',
        token: 'mock_token_12345',
      );
    }
    return null;
  }

  Future<User?> register(RegisterDTO dto) async {
    await Future.delayed(const Duration(seconds: 1));
    return User(
      id: '2',
      email: dto.email,
      username: dto.username,
      token: 'mock_token_67890',
    );
  }
}
