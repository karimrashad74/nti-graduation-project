import 'package:dio/dio.dart';

import 'api_constants.dart';
import 'token_storage.dart';

class NetworkHelper {
  static Future<Response> authorizedGet(String endpoint) async {
    final token = await TokenStorage.getToken();
    final dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
    return await dio.get(
      endpoint,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  static Future<Response> authorizedPost(
    String endpoint, {
    Object? body,
  }) async {
    final token = await TokenStorage.getToken();
    final dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
    return await dio.post(
      endpoint,
      data: body,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );
  }
}
