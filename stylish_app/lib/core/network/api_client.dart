import 'package:http/http.dart' as http;

import 'api_constants.dart';

class ApiClient {
  final http.Client _client;
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  Future<http.Response> post(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final url = Uri.parse(ApiConstants.baseUrl + endpoint);
    return await _client.post(url, headers: headers, body: body);
  }

  Future<http.Response> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse(ApiConstants.baseUrl + endpoint);
    return await _client.get(url, headers: headers);
  }

  // يمكنك إضافة put/delete لاحقاً
}
