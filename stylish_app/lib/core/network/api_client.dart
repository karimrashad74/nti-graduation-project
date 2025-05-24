import 'package:dio/dio.dart';

import 'api_constants.dart';

class ApiClient {
  final Dio _dio;
  ApiClient({Dio? dio})
    : _dio = dio ?? Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  Future<Response> post(
    String endpoint, {
    Map<String, dynamic>? headers,
    Object? body,
  }) async {
    return await _dio.post(
      endpoint,
      data: body,
      options: Options(headers: headers),
    );
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? headers}) async {
    return await _dio.get(endpoint, options: Options(headers: headers));
  }
}
