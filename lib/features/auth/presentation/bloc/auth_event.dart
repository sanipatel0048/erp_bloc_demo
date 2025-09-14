abstract class AuthEvent {}

class LoginAsAdmin extends AuthEvent {
  final String username;
  final String password;

  LoginAsAdmin({required this.username, required this.password});
}

class LoginAsEmployee extends AuthEvent {
  final String mobileNo;
  final String password;

  LoginAsEmployee({required this.mobileNo, required this.password});
}
