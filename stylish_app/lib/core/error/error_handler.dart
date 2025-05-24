import 'dart:convert';

class ErrorHandler {
  static String parseError(dynamic error) {
    if (error is String) return error;
    if (error is Map && error['message'] != null) return error['message'];
    try {
      final decoded = json.decode(error.toString());
      if (decoded is Map && decoded['message'] != null) {
        return decoded['message'];
      }
    } catch (_) {}
    return 'حدث خطأ غير متوقع';
  }
}
