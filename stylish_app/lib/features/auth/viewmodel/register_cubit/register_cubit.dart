import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/register_request.dart';
import '../../model/register_response.dart';
import '../../repository/auth_repository.dart';
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
      emit(RegisterError(e.toString()));
    }
  }
}
