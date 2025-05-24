import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_constants.dart';
import 'token_storage.dart';

class NetworkHelper {
  static Future<http.Response> authorizedGet(String endpoint) async {
    final token = await TokenStorage.getToken();
    final url = Uri.parse(ApiConstants.baseUrl + endpoint);
    return await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }

  static Future<http.Response> authorizedPost(
    String endpoint, {
    Object? body,
  }) async {
    final token = await TokenStorage.getToken();
    final url = Uri.parse(ApiConstants.baseUrl + endpoint);
    return await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    );
  }
}
