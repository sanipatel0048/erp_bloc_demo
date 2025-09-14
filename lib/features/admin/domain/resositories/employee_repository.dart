abstract class EmployeeRepository {
  Future<dynamic> addEmployee({
    required String name,
    required String mobileNo,
    required String email,
    required String password,
  });
}
