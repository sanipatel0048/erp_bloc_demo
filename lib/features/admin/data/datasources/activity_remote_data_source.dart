import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/api_constants.dart';

class ActivityRemoteDataSource {
  final Dio dio;

  ActivityRemoteDataSource(this.dio);

  Future<Response?> getActivity({
    required String employeeId,
    required String date,
  }) async {
    try {
      final params = {"employeeId": employeeId, "date": date};
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.findInOut}',
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

  Future<Response?> updateCheckout({
    required String employeeId,
    required String date,
    required String checkOut,
    required String newCheckOut,
  }) async {
    try {
      final params = {
        "employeeId": employeeId,
        "date": date,
        "checkOut": checkOut,
        "newCheckOut": newCheckOut,
      };
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.updateCheckInOut}',
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

  Future<Response?> updateCheckIn({
    required String employeeId,
    required String date,
    required String checkIn,
    required String newCheckIn,
  }) async {
    try {
      final params = {
        "employeeId": employeeId,
        "date": date,
        "checkIn": checkIn,
        "newCheckIn": newCheckIn,
      };
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.updateCheckInOut}',
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
