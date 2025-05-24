import 'dart:core';

import 'package:dio/dio.dart';

class ApiResponse {
  final bool status;
  final int statusCode;
  final dynamic data;
  final String message;

  ApiResponse({
    required this.status,
    required this.statusCode,
    this.data,
    required this.message,
  });

  //factory constructor
  factory ApiResponse.fromResponse(Response response) {
    return ApiResponse(
      status: response.data['status'] ?? false,
      statusCode: response.data['statusCode'] ?? 500,
      data: response.data,
      message: response.data['message'] ?? "An error occurred",
    );
  }

  //factory constructor for error
  factory ApiResponse.fromError(dynamic error) {
    if (error is DioException) {
      print('Dio Error: $error');
      return ApiResponse(
        status: false,
        statusCode:
            error.response != null ? error.response!.statusCode ?? 500 : 500,
        message: _handleDioError(error),
      );
    } else {
      return ApiResponse(
        status: false,
        statusCode: 500,
        message: 'An error occurred',
      );
    }
  }

  static String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout,Please try again';
      case DioExceptionType.sendTimeout:
        return 'Send timeout,Please try again';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout,Please try again later';
      case DioExceptionType.badResponse:
        return _handleServerError(error.response);
      case DioExceptionType.cancel:
        return 'request canceled';
      case DioExceptionType.connectionError:
        return 'No Internet Connection';
      default:
        return 'An error occurred';
    }
  }

  // handeling server error
  static String _handleServerError(Response? response) {
    print(response?.data.toString());
    if (response == null) {
      return 'No server response';
    }
    if (response.data is Map<String, dynamic>) {
      return response.data['message'] ?? 'An error occurred';
    }
    return 'Server error: ${response.statusCode}';
  }
}
