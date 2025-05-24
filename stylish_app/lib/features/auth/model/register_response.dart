class RegisterResponse {
  final String token;
  final String? message;

  RegisterResponse({required this.token, this.message});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      token: json['token'] ?? '',
      message: json['message'],
    );
  }
}
