import 'package:ssvl_erp_system_bloc/features/admin/data/models/employee_model.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<EmployeeModel> employees;

  DashboardLoaded(this.employees);
}

class DashboardError extends DashboardState {
  final String message;

  DashboardError({this.message = 'Something went wrong'});
}
