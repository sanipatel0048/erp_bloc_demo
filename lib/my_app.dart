import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ssvl_erp_system_bloc/core/theme/colors.dart';
import 'package:ssvl_erp_system_bloc/core/utils/snackbar_utils.dart';
import 'package:ssvl_erp_system_bloc/core/utils/strings.dart';
import 'package:ssvl_erp_system_bloc/features/admin/presentation/bloc/admin/admin_bloc.dart';
import 'package:ssvl_erp_system_bloc/routes/app_router.dart';

import 'core/di/service_locator.dart';
import 'core/network/domain/network_info.dart';
import 'core/network/presentation/bloc/connectivity_bloc.dart';
import 'core/network/presentation/bloc/connectivity_state.dart';
import 'features/admin/presentation/bloc/activity/activity_bloc.dart';
import 'features/admin/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'features/admin/presentation/bloc/employee/employee_bloc.dart'
    as admin_employee_bloc;
import 'features/admin/presentation/bloc/timeline/timeline_bloc.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/employee/presentation/bloc/employee_bloc.dart';

class MyApp extends StatelessWidget {
  final NetworkInfo networkInfo;

  const MyApp({super.key, required this.networkInfo});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityBloc>(
          create: (_) => ConnectivityBloc(networkInfo),
          child: MaterialApp(
            home: BlocListener<ConnectivityBloc, ConnectivityState>(
              listener: (context, state) {
                if (state is ConnectivityOffline) {
                  showErrorSnackBar(context, 'No Internet');
                } else if (state is ConnectivityOnline) {
                  showSuccessSnackBar(context, 'Back Online');
                }
              },
            ),
          ),
        ),
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
        BlocProvider<AdminBloc>(create: (_) => sl<AdminBloc>()),
        BlocProvider<DashboardBloc>(create: (_) => sl<DashboardBloc>()),
        BlocProvider<EmployeeBloc>(create: (_) => sl<EmployeeBloc>()),
        BlocProvider<admin_employee_bloc.EmployeeBloc>(
          create: (_) => sl<admin_employee_bloc.EmployeeBloc>(),
        ),
        BlocProvider<TimelineBloc>(create: (_) => sl<TimelineBloc>()),
        BlocProvider<ActivityBloc>(create: (_) => sl<ActivityBloc>()),
      ],
      child: MaterialApp.router(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData(
          cardTheme: CardThemeData(
            surfaceTintColor: Colors.transparent,
            margin: EdgeInsets.zero,
            elevation: 0,
            color: Colors.transparent,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
        ),
      ),
    );
  }
}
