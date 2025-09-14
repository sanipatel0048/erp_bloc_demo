import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../routes/routes.dart';
import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitial()) {
    on<PageChangeEvent>((event, emit) {
      emit(PageChanged(event.index));
    });

    on<LogoutEvent>((event, emit) async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
        event.context.go(Routes.loginEmployee);

        emit(LogoutSuccess());
      } catch (e) {
        debugPrint('Error during logout: $e');
      }
    });
  }
}
