import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssvl_erp_system_bloc/core/utils/strings.dart';
import 'package:ssvl_erp_system_bloc/features/admin/presentation/pages/add_employee_page.dart';
import 'package:ssvl_erp_system_bloc/features/admin/presentation/pages/admin_home_page.dart';
import 'package:ssvl_erp_system_bloc/features/admin/presentation/pages/dashboard_page.dart';
import 'package:ssvl_erp_system_bloc/features/admin/presentation/pages/get_timeline_page.dart';
import 'package:ssvl_erp_system_bloc/features/admin/presentation/pages/view_activity_page.dart';
import 'package:ssvl_erp_system_bloc/features/auth/presentation/pages/admin_login_page.dart';
import 'package:ssvl_erp_system_bloc/features/auth/presentation/pages/employee_login_page.dart';
import 'package:ssvl_erp_system_bloc/features/common/presentation/pages/home_page.dart';
import 'package:ssvl_erp_system_bloc/features/employee/presentation/pages/activity_page.dart';
import 'package:ssvl_erp_system_bloc/features/employee/presentation/pages/company_page.dart';
import 'package:ssvl_erp_system_bloc/features/employee/presentation/pages/eDashboard_page.dart';
import 'package:ssvl_erp_system_bloc/features/employee/presentation/pages/employee_home_page.dart';
import 'package:ssvl_erp_system_bloc/features/employee/presentation/pages/leave_page.dart';
import 'package:ssvl_erp_system_bloc/features/employee/presentation/pages/profile_page.dart';
import 'package:ssvl_erp_system_bloc/routes/routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: '/',
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: Routes.home,
      pageBuilder: (context, state) => NoTransitionPage(child: HomePage()),
    ),
    GoRoute(
      path: Routes.loginAdmin,
      pageBuilder: (context, state) =>
          NoTransitionPage(child: AdminLoginPage()),
    ),

    GoRoute(
      path: Routes.loginEmployee,
      pageBuilder: (context, state) =>
          NoTransitionPage(child: EmployeeLoginPage()),
    ),

    ///Shell Route for Admin Section
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) {
        return AdminHomePage(
          title: state.matchedLocation.split('/').last,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: Routes.adminDashboard,
          pageBuilder: (context, state) =>
              NoTransitionPage(child: DashboardPage()),
        ),
        GoRoute(
          path: Routes.addEmployee,
          pageBuilder: (context, state) =>
              NoTransitionPage(child: AddEmployeePage()),
        ),
        GoRoute(
          path: Routes.getTimeline,
          pageBuilder: (context, state) =>
              NoTransitionPage(child: GetTimelinePage()),
        ),
        GoRoute(
          path: Routes.viewActivity,
          pageBuilder: (context, state) =>
              NoTransitionPage(child: ViewActivityPage()),
        ),
      ],
    ),
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) {
        return EmployeeHomePage(
          title: state.matchedLocation.split('/').last,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: Routes.employeeDashboard,
          pageBuilder: (context, state) =>
              NoTransitionPage(child: EDashboardPage()),
        ),
        GoRoute(
          path: Routes.employeeActivity,
          pageBuilder: (context, state) =>
              NoTransitionPage(child: ActivityPage()),
        ),
        GoRoute(
          path: Routes.employeeLeave,
          pageBuilder: (context, state) => NoTransitionPage(child: LeavePage()),
        ),
        GoRoute(
          path: Routes.employeeProfile,
          pageBuilder: (context, state) =>
              NoTransitionPage(child: ProfilePage()),
        ),
        GoRoute(
          path: Routes.employeeCompany,
          pageBuilder: (context, state) =>
              NoTransitionPage(child: CompanyPage()),
        ),
      ],
    ),
  ],
  redirect: (context, state) async {
    final prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool('isLogin') ?? false;
    var myVersion = prefs.getString('webVersion');
    var userType = prefs.getString('userType');

    // Handle base admin route redirection
    if (state.matchedLocation == Routes.admin &&
        isLogin &&
        userType == 'admin') {
      return Routes.adminDashboard;
    }
    if (state.matchedLocation == Routes.employee &&
        isLogin &&
        userType == 'employee') {
      return Routes.employeeDashboard;
    }
    // List of protected admin routes
    final isAdminRoute = state.matchedLocation.startsWith('/admin');
    final isEmployeeRoute = state.matchedLocation.startsWith('/employee');

    // If trying to access protected routes
    if (isAdminRoute || isEmployeeRoute) {
      if (!isLogin || myVersion != AppStrings.webVersion) {
        // Not logged in or invalid version, redirect to login
        return Routes.loginAdmin;
      }

      // Check correct user type for route
      if (isAdminRoute && userType != 'admin') {
        return Routes.loginAdmin;
      }
      if (isEmployeeRoute && userType != 'employee') {
        return Routes.loginEmployee;
      }
    }

    // Already logged in, redirect from login pages to respective dashboards
    if (isLogin && myVersion == AppStrings.webVersion) {
      if (state.matchedLocation == Routes.loginAdmin ||
          state.matchedLocation == Routes.loginEmployee) {
        return userType == 'admin'
            ? Routes.adminDashboard
            : Routes.employeeDashboard;
      }
    }

    return null;
  },
);
