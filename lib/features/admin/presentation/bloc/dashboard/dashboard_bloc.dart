import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ssvl_erp_system_bloc/features/admin/domain/usecases/dashboard_usecase.dart';
import 'package:ssvl_erp_system_bloc/features/admin/presentation/bloc/dashboard/dashboard_event.dart';
import 'package:ssvl_erp_system_bloc/features/admin/presentation/bloc/dashboard/dashboard_state.dart';

import '../../../data/models/employee_model.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardUseCase dashboardUseCase;

  DashboardBloc({required this.dashboardUseCase}) : super(DashboardInitial()) {
    on<LoadEmployees>((event, emit) async {
      emit(DashboardLoading());
      try {
        final response = await dashboardUseCase.getEmployees();
        if (response != null &&
            response.statusCode == 200) {
          final List<dynamic> employeeList = response.data['employee'];
          final employees = employeeList
              .map((e) => EmployeeModel.fromJson(e))
              .toList();
          emit(DashboardLoaded(employees));
        } else {
          emit(
            DashboardError(
              message: response?.data['message'] ?? 'Something went wrong',
            ),
          );
        }
      } catch (e) {
        emit(DashboardError(message: e.toString()));
      }
    });
  }
}
