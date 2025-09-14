import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ssvl_erp_system_bloc/core/utils/strings.dart';

import '../../../../core/utils/api_constants.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<Response?> login({
    required String username,
    required String password,
    required String role,
  }) async {
    try {
      late Map<String, dynamic> params;
      late String endPoint;
      if (role == AppStrings.admin) {
        endPoint = ApiConstants.adminLogin;
        params = {'username': username, 'password': password};
      } else if (role == AppStrings.employee) {
        endPoint = ApiConstants.employeeLogin;
        params = {'mobileNo': username, 'password': password};
      } else {
        throw Exception('Invalid role: $role');
      }

      final response = await dio.post(
        '${ApiConstants.baseUrl}$endPoint',
        data: params,
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
