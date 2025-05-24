import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/login_request.dart';
import '../model/login_response.dart';
import '../repository/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository repository;
  LoginCubit({required this.repository}) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final response = await repository.login(
        LoginRequest(email: email, password: password),
      );
      emit(LoginSuccess(response));
    } catch (e) {
      emit(LoginError(_mapErrorToMessage(e)));
    }
  }

  String _mapErrorToMessage(dynamic e) {
    if (e is DioException) {
      final data = e.response?.data;
      final status = e.response?.statusCode;
      if (status == 401 || (data.toString().contains('invalid credentials'))) {
        return 'بيانات الدخول غير صحيحة';
      } else if (data.toString().contains('user not found')) {
        return 'المستخدم غير موجود';
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return 'انتهت مهلة الاتصال بالخادم';
      } else if (e.type == DioExceptionType.unknown) {
        return 'خطأ في الشبكة، يرجى التحقق من اتصالك بالإنترنت';
      } else if (status == 500) {
        return 'خطأ في الخادم، يرجى المحاولة لاحقًا';
      } else if (data != null && data['message'] != null) {
        return data['message'].toString();
      } else {
        return 'خطأ غير معروف: ${e.toString()}';
      }
    } else {
      return 'خطأ غير متوقع: ${e.toString()}';
    }
  }
}
