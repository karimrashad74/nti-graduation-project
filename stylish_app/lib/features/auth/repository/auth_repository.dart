import '../../../core/network/api_client.dart';
import '../../../core/network/api_constants.dart';
import '../model/login_request.dart';
import '../model/login_response.dart';
import '../model/register_request.dart';
import '../model/register_response.dart';

class AuthRepository {
  final ApiClient apiClient;
  AuthRepository({required this.apiClient});

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await apiClient.post(
      ApiConstants.login,
      headers: {'Content-Type': 'application/json'},
      body: request.toJson(),
    );
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(response.body as Map<String, dynamic>);
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  Future<RegisterResponse> register(RegisterRequest request) async {
    final response = await apiClient.post(
      ApiConstants.register,
      headers: {'Content-Type': 'application/json'},
      body: request.toJson(),
    );
    if (response.statusCode == 200) {
      return RegisterResponse.fromJson(response.body as Map<String, dynamic>);
    } else {
      throw Exception('Register failed: ${response.body}');
    }
  }

  // يمكنك إضافة logout لاحقاً
}
