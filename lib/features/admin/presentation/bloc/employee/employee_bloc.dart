import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ssvl_erp_system_bloc/features/admin/domain/usecases/employee_usecase.dart';
import 'package:ssvl_erp_system_bloc/features/admin/presentation/bloc/employee/employee_event.dart';
import 'package:ssvl_erp_system_bloc/features/admin/presentation/bloc/employee/employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeUseCase employeeUseCase;

  EmployeeBloc({required this.employeeUseCase}) : super(EmployeeInitial()) {
    on<AddEmployee>((event, emit) async {
      emit(EmployeeLoading());
      try {
        final response = await employeeUseCase.addEmployee(
          name: event.name,
          mobileNo: event.mobileNo,
          email: event.email,
          password: event.password,
        );
        if (response != null &&
            response.statusCode == 200 &&
            response.data['err'] == 'N') {
          emit(
            EmployeeInsertSuccess(
              error: response.data['err'],
              message: response.data['msg'],
            ),
          );
        } else {
          emit(EmployeeError(message: response.data['msg']));
        }
      } catch (e) {
        emit(EmployeeError(message: e.toString()));
      }
    });
  }
}
