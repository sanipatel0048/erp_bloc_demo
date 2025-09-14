import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ssvl_erp_system_bloc/core/utils/api_constants.dart';

class DashboardRemoteDataSource {
  final Dio dio;

  DashboardRemoteDataSource(this.dio);

  Future<Response?> getEmployees() async {
    try {
      final params = {"search": '', "by": 'Name'};
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.findEmployee}',
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
