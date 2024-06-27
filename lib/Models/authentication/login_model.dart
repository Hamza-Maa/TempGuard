class LogInData {
  final String email;
  final String password;


  LogInData({
    required this.email,
    required this.password,

  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

