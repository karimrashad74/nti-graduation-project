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
    try {
      final response = await apiClient.post(
        ApiConstants.login,
        headers: {'Content-Type': 'application/json'},
        body: request.toJson(),
      );
      print(
        'Login API response: ${response.data}, Status: ${response.statusCode}',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginResponse.fromJson(response.data);
      } else {
        throw Exception(
          'Login failed: ${response.data}, Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Login API error: $e');
      rethrow;
    }
  }

  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      final response = await apiClient.post(
        ApiConstants.register,
        headers: {'Content-Type': 'application/json'},
        body: request.toJson(),
      );
      print(
        'Register API response: ${response.data}, Status: ${response.statusCode}',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegisterResponse.fromJson(response.data);
      } else {
        throw Exception(
          'Register failed: ${response.data}, Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Register API error: $e');
      rethrow;
    }
  }
}
