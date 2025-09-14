abstract class EmployeeEvent {}

class AddEmployee extends EmployeeEvent {
  final String name;
  final String mobileNo;
  final String email;
  final String password;

  AddEmployee({
    required this.name,
    required this.mobileNo,
    required this.email,
    required this.password,
  });
}
