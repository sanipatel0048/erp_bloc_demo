import 'package:ssvl_erp_system_bloc/features/admin/domain/resositories/employee_repository.dart';

class EmployeeUseCase {
  final EmployeeRepository employeeRepository;

  EmployeeUseCase(this.employeeRepository);

  Future<dynamic> addEmployee({
    required String name,
    required String mobileNo,
    required String email,
    required String password,
  }) async {
    return await employeeRepository.addEmployee(
      name: name,
      mobileNo: mobileNo,
      email: email,
      password: password,
    );
  }
}
