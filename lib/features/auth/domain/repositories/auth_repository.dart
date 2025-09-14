abstract class AuthRepository {
  Future<dynamic> login({
    required String username,
    required String password,
    required String role,
  });
}
