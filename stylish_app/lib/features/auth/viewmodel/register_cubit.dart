import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/register_request.dart';
import '../model/register_response.dart';
import '../repository/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository repository;
  RegisterCubit({required this.repository}) : super(RegisterInitial());

  Future<void> register(String name, String email, String password) async {
    emit(RegisterLoading());
    try {
      final response = await repository.register(
        RegisterRequest(name: name, email: email, password: password),
      );
      emit(RegisterSuccess(response));
    } catch (e) {
      String errorMsg = 'حدث خطأ غير متوقع';
      if (e is DioException) {
        if (e.response?.statusCode == 409 ||
            (e.response?.data.toString().contains('already exists') ?? false) ||
            (e.response?.data.toString().contains('user already exists') ??
                false)) {
          errorMsg = 'البريد الإلكتروني مسجل من قبل';
        } else if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          errorMsg = 'انتهت مهلة الاتصال بالخادم';
        } else if (e.type == DioExceptionType.unknown) {
          errorMsg = 'خطأ في الشبكة، يرجى التحقق من اتصالك بالإنترنت';
        } else if (e.response?.statusCode == 500) {
          errorMsg = 'خطأ في الخادم، يرجى المحاولة لاحقًا';
        } else if (e.response?.data != null &&
            e.response?.data['message'] != null) {
          errorMsg = e.response?.data['message'];
        }
      }
      emit(RegisterError(errorMsg));
    }
  }
}
