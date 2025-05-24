import 'package:dio/dio.dart';

import '../local/local_data.dart';
import 'api_response.dart';

class ApiHelper {
  static final ApiHelper _apiHelper = ApiHelper._internal();
  factory ApiHelper() => _apiHelper;
  ApiHelper._internal();

  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://ecommerce-shop-api-production.up.railway.app/api/',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      sendTimeout: Duration(seconds: 10),
    ),
  );

  Future<ApiResponse> getRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isAuthorized = true,
  }) async {
    try {
      print('Access Token before request: ${LocalData.accessToken}');

      var response = await dio.get(
        endPoint,
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
        options: Options(
          headers: {
            if (isAuthorized)
              "Authorization": "Bearer ${LocalData.accessToken}",
          },
        ),
      );

      if (response.data['message'] == "Token has expired.") {
        bool refreshed = await _refreshAccessToken();
        if (refreshed) {
          response = await dio.get(
            endPoint,
            data: isFormData ? FormData.fromMap(data ?? {}) : data,
            options: Options(
              headers: {
                if (isAuthorized)
                  "Authorization": "Bearer ${LocalData.accessToken}",
              },
            ),
          );
        } else {
          return ApiResponse(
            status: false,
            statusCode: 401,
            message: "Token expired and refresh failed.",
          );
        }
      }

      print('Response data: ${response.data}');
      return ApiResponse.fromResponse(response);
    } catch (e) {
      print('Error in getRequest: $e');
      return ApiResponse.fromError(e);
    }
  }

  Future<ApiResponse> postRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isAuthorized = true,
  }) async {
    try {
      var response = await dio.post(
        endPoint,
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
        options: Options(
          headers: {
            if (isAuthorized)
              "Authorization": "Bearer ${LocalData.accessToken}",
          },
        ),
      );

      if (response.data['message'] == "Token has expired.") {
        bool refreshed = await _refreshAccessToken();
        if (refreshed) {
          response = await dio.post(
            endPoint,
            data: isFormData ? FormData.fromMap(data ?? {}) : data,
            options: Options(
              headers: {
                if (isAuthorized)
                  "Authorization": "Bearer ${LocalData.accessToken}",
              },
            ),
          );
        } else {
          return ApiResponse(
            status: false,
            statusCode: 401,
            message: "Token expired and refresh failed.",
          );
        }
      }

      return ApiResponse.fromResponse(response);
    } catch (e) {
      print('Error in postRequest: $e');
      return ApiResponse.fromError(e);
    }
  }

  Future<ApiResponse> putRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isAuthorized = true,
  }) async {
    try {
      var response = await dio.put(
        endPoint,
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
        options: Options(
          headers: {
            if (isAuthorized)
              "Authorization": "Bearer ${LocalData.accessToken}",
          },
        ),
      );

      if (response.data['message'] == "Token has expired.") {
        bool refreshed = await _refreshAccessToken();
        if (refreshed) {
          response = await dio.put(
            endPoint,
            data: isFormData ? FormData.fromMap(data ?? {}) : data,
            options: Options(
              headers: {
                if (isAuthorized)
                  "Authorization": "Bearer ${LocalData.accessToken}",
              },
            ),
          );
        } else {
          return ApiResponse(
            status: false,
            statusCode: 401,
            message: "Token expired and refresh failed.",
          );
        }
      }

      return ApiResponse.fromResponse(response);
    } catch (e) {
      print('Error in putRequest: $e');
      return ApiResponse.fromError(e);
    }
  }

  Future<ApiResponse> deleteRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isAuthorized = true,
  }) async {
    try {
      var response = await dio.delete(
        endPoint,
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
        options: Options(
          headers: {
            if (isAuthorized)
              "Authorization": "Bearer ${LocalData.accessToken}",
          },
        ),
      );

      if (response.data['message'] == "Token has expired.") {
        bool refreshed = await _refreshAccessToken();
        if (refreshed) {
          response = await dio.delete(
            endPoint,
            data: isFormData ? FormData.fromMap(data ?? {}) : data,
            options: Options(
              headers: {
                if (isAuthorized)
                  "Authorization": "Bearer ${LocalData.accessToken}",
              },
            ),
          );
        } else {
          return ApiResponse(
            status: false,
            statusCode: 401,
            message: "Token expired and refresh failed.",
          );
        }
      }

      return ApiResponse.fromResponse(response);
    } catch (e) {
      print('Error in deleteRequest: $e');
      return ApiResponse.fromError(e);
    }
  }

  Future<bool> _refreshAccessToken() async {
    try {
      final refreshToken = await LocalData.getRefreshToken();
      if (refreshToken == null) return false;

      final response = await dio.post(
        'auth/refresh',
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['access_token'];
        final newRefreshToken = response.data['refresh_token'];

        await LocalData.setAccessToken(newAccessToken);
        if (newRefreshToken != null) {
          await LocalData.saveRefreshToken(newRefreshToken);
        }

        print('Token refreshed successfully.');
        return true;
      } else {
        print('Failed to refresh token, statusCode: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error refreshing token: $e');
      return false;
    }
  }
}
