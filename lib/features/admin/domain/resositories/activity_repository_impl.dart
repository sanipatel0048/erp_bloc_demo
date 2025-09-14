import 'package:flutter/cupertino.dart';

import '../../data/datasources/activity_remote_data_source.dart';
import 'activity_repository.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityRemoteDataSource activityRemoteDataSource;

  ActivityRepositoryImpl(this.activityRemoteDataSource);

  @override
  Future getActivity({required String employeeId, required String date}) async {
    try {
      final response = await activityRemoteDataSource.getActivity(
        employeeId: employeeId,
        date: date,
      );
      return response;
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }

  @override
  Future updateCheckIn({
    required String employeeId,
    required String date,
    required String checkIn,
    required String newCheckIn,
  }) async {
    try {
      final response = await activityRemoteDataSource.updateCheckIn(
        employeeId: employeeId,
        date: date,
        checkIn: checkIn,
        newCheckIn: newCheckIn,
      );
      return response;
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }

  @override
  Future updateCheckout({
    required String employeeId,
    required String date,
    required String checkOut,
    required String newCheckOut,
  }) async {
    try {
      final response = await activityRemoteDataSource.updateCheckout(
        employeeId: employeeId,
        date: date,
        checkOut: checkOut,
        newCheckOut: newCheckOut,
      );
      return response;
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }
}
