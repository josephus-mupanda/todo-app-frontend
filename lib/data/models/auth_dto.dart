class LoginDTO {
  final String email;
  final String password;

  LoginDTO({required this.email, required this.password});
}

class RegisterDTO {
  final String email;
  final String username;
  final String password;

  RegisterDTO({
    required this.email,
    required this.username,
    required this.password,
  });
}
