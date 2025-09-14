import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ssvl_erp_system_bloc/features/auth/domain/usecases/login_usecase.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase}) : super(AuthInitial()) {
    on<LoginAsAdmin>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await loginUseCase.login(
          username: event.username,
          password: event.password,
          role: 'admin',
        );
        if (response != null &&
            response.statusCode == 200 &&
            response.data['err'] == 'N') {
          emit(
            AuthSuccess(
              error: response.data['err'],
              message: response.data['msg'],
            ),
          );
        } else {
          emit(AuthError(message: response.data['msg']));
        }
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });
    on<LoginAsEmployee>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await loginUseCase.login(
          username: event.mobileNo,
          password: event.password,
          role: 'employee',
        );
        if (response != null &&
            response.statusCode == 200 &&
            response.data['err'] == 'N') {
          emit(
            AuthSuccess(
              error: response.data['err'],
              message: response.data['msg'],
            ),
          );
        } else {
          emit(AuthError(message: response.data['msg']));
        }
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });
  }
}
