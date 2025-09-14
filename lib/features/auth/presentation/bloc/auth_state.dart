abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String error;
  final String message;

  AuthSuccess({this.error = '', this.message = 'Login Success'});
}

class AuthError extends AuthState {
  final String message;

  AuthError({this.message = 'Invalid Credentials'});
}
