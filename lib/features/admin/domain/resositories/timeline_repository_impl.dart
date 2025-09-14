import 'package:flutter/material.dart';
import 'package:ssvl_erp_system_bloc/features/admin/domain/resositories/timeline_repository.dart';

import '../../data/datasources/timeline_remote_datasource.dart';

class TimelineRepositoryImpl implements TimelineRepository {
  final TimelineRemoteDataSource timelineRemoteDataSource;

  TimelineRepositoryImpl(this.timelineRemoteDataSource);

  @override
  Future getTimeline({required String employeeId, required String date}) async {
    try {
      final response = await timelineRemoteDataSource.getTimeline(
        employeeId: employeeId,
        date: date,
      );
      return response;
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }
}
