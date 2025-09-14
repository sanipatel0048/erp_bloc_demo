import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/api_constants.dart';

class TimelineRemoteDataSource {
  final Dio dio;

  TimelineRemoteDataSource(this.dio);

  Future<Response?> getTimeline({required String employeeId,required String date}) async {
    try {
      final params = {"employeeId": employeeId, "date": date};
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.getTotalWorkingHours}',
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
