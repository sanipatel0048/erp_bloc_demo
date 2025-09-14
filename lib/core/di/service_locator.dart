import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ssvl_erp_system_bloc/features/admin/data/datasources/dashboard_remote_datasource.dart';
import 'package:ssvl_erp_system_bloc/features/admin/data/datasources/timeline_remote_datasource.dart';
import 'package:ssvl_erp_system_bloc/features/admin/domain/resositories/dashboard_repository.dart';
import 'package:ssvl_erp_system_bloc/features/admin/domain/resositories/employee_repository.dart';
import 'package:ssvl_erp_system_bloc/features/admin/domain/resositories/timeline_repository.dart';
import 'package:ssvl_erp_system_bloc/features/admin/domain/usecases/dashboard_usecase.dart';
import 'package:ssvl_erp_system_bloc/features/admin/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:ssvl_erp_system_bloc/features/auth/domain/repositories/auth_repository.dart';
import 'package:ssvl_erp_system_bloc/features/auth/presentation/bloc/auth_bloc.dart';

import '../../features/admin/data/datasources/activity_remote_data_source.dart';
import '../../features/admin/data/datasources/employee_remote_datasource.dart';
import '../../features/admin/domain/resositories/activity_repository.dart';
import '../../features/admin/domain/resositories/activity_repository_impl.dart';
import '../../features/admin/domain/resositories/dashboard_repository_impl.dart';
import '../../features/admin/domain/resositories/employee_repository_impl.dart';
import '../../features/admin/domain/resositories/timeline_repository_impl.dart';
import '../../features/admin/domain/usecases/activity_usecase.dart';
import '../../features/admin/domain/usecases/employee_usecase.dart';
import '../../features/admin/domain/usecases/timeline_usecase.dart';
import '../../features/admin/presentation/bloc/activity/activity_bloc.dart';
import '../../features/admin/presentation/bloc/employee/employee_bloc.dart';
import '../../features/admin/presentation/bloc/timeline/timeline_bloc.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/domain/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///External Dependencies
  sl.registerLazySingleton(() => Dio());

  ///Auth Features
  sl.registerLazySingleton(() => AuthRemoteDataSource(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerFactory(() => AuthBloc(loginUseCase: sl()));

  ///Admin Dashboard Features
  sl.registerLazySingleton(() => DashboardRemoteDataSource(sl()));
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => DashboardUseCase(sl()));
  sl.registerFactory(() => DashboardBloc(dashboardUseCase: sl()));

  ///Add Employee Features
  sl.registerLazySingleton(() => EmployeeRemoteDataSource(sl()));
  sl.registerLazySingleton<EmployeeRepository>(
    () => EmployeeRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => EmployeeUseCase(sl()));
  sl.registerFactory(() => EmployeeBloc(employeeUseCase: sl()));

  ///Get Timeline Features
  sl.registerLazySingleton(() => TimelineRemoteDataSource(sl()));
  sl.registerLazySingleton<TimelineRepository>(
    () => TimelineRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => TimelineUseCase(sl()));
  sl.registerFactory(() => TimelineBloc(timelineUseCase: sl()));

  ///Get Activity Features
  sl.registerLazySingleton(() => ActivityRemoteDataSource(sl()));
  sl.registerLazySingleton<ActivityRepository>(
    () => ActivityRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => ActivityUseCase(sl()));
  sl.registerFactory(() => ActivityBloc(activityUseCase: sl()));
}
