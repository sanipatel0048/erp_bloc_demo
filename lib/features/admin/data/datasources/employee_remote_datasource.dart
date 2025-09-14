import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/api_constants.dart';

class EmployeeRemoteDataSource {
  final Dio dio;

  EmployeeRemoteDataSource(this.dio);

  Future<Response?> addEmployee({
    required String name,
    required String mobileNo,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.insertEmployee}',
        data: {
          "name": name,
          "mobileNo": mobileNo,
          "email": email,
          "password": password,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
