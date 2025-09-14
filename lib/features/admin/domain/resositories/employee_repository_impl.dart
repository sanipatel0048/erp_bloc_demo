import 'package:flutter/material.dart';

import '../../data/datasources/employee_remote_datasource.dart';
import 'employee_repository.dart';

class EmployeeRepositoryImpl extends EmployeeRepository {
  final EmployeeRemoteDataSource employeeRemoteDataSource;

  EmployeeRepositoryImpl(this.employeeRemoteDataSource);

  @override
  Future addEmployee({
    required String name,
    required String mobileNo,
    required String email,
    required String password,
  }) async {
    try {
      final response = await employeeRemoteDataSource.addEmployee(
        name: name,
        mobileNo: mobileNo,
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      debugPrint('Login error: ${e.toString()}');
    }
  }
}
