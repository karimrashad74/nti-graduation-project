import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/login_request.dart';
import '../../model/login_response.dart';
import '../../repository/auth_repository.dart';
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
      emit(LoginError(e.toString()));
    }
  }
}
