import 'package:ssvl_erp_system_bloc/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<dynamic> login({
    required String username,
    required String password,
    required String role,
  }) async {
    return await authRepository.login(
      username: username,
      password: password,
      role: role,
    );
  }
}
