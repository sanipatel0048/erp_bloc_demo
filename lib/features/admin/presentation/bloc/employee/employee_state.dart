abstract class EmployeeState {}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeInsertSuccess extends EmployeeState {
  final String error;
  final String message;

  EmployeeInsertSuccess({required this.error, required this.message});
}

class EmployeeError extends EmployeeState {
  final String message;

  EmployeeError({this.message = 'Something went wrong'});
}
