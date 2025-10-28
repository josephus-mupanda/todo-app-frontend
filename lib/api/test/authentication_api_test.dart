import 'package:test/test.dart';
import 'package:todo_api_client/todo_api_client.dart';


/// tests for AuthenticationApi
void main() {
  final instance = TodoApiClient().getAuthenticationApi();

  group(AuthenticationApi, () {
    // Change password with token
    //
    //Future<GenericResponseString> changePassword(String code, ChangePasswordRequest changePasswordRequest) async
    test('test changePassword', () async {
      // TODO
    });

    // Confirm user email
    //
    //Future<GenericResponseString> confirmUser(String code) async
    test('test confirmUser', () async {
      // TODO
    });

    // Login a user and get JWT token
    //
    //Future<GenericResponseLoginResponse> login(LoginRequest loginRequest) async
    test('test login', () async {
      // TODO
    });

    // Logout a user
    //
    //Future<GenericResponseString> logout(String authorization) async
    test('test logout', () async {
      // TODO
    });

    // Register a new user
    //
    //Future<GenericResponseOutput> register(RegisterRequest registerRequest) async
    test('test register', () async {
      // TODO
    });

    // Request password reset
    //
    //Future<GenericResponseString> resetPassword(ResetPasswordRequest resetPasswordRequest) async
    test('test resetPassword', () async {
      // TODO
    });

  });
}
