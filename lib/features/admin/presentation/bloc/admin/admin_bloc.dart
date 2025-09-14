import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssvl_erp_system_bloc/routes/routes.dart';

import 'admin_event.dart';
import 'admin_state.dart';



class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial()) {
    on<ChangePageEvent>((event, emit) {
      emit(PageChanged(event.index));
    });

    on<LogoutEvent>((event, emit) async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
        event.context.go(Routes.loginAdmin);

        emit(LogoutSuccess());
      } catch (e) {
        debugPrint('Error during logout: $e');
      }
    });
  }
}
