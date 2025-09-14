import 'package:flutter/material.dart';

import '../../data/datasources/dashboard_remote_datasource.dart';
import 'dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource dashboardRemoteDataSource;

  DashboardRepositoryImpl(this.dashboardRemoteDataSource);

  @override
  Future getEmployees() async {
    try {
      final response = await dashboardRemoteDataSource.getEmployees();
      return response;
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }
}
