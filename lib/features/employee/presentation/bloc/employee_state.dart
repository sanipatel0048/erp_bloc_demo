abstract class EmployeeState {}

class EmployeeInitial extends EmployeeState {}

class PageChanged extends EmployeeState {
  final int currentIndex;

  PageChanged(this.currentIndex);
}

class LogoutSuccess extends EmployeeState {}
