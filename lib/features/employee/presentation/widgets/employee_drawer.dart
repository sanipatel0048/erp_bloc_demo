import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ssvl_erp_system_bloc/core/utils/strings.dart';
import 'package:ssvl_erp_system_bloc/features/employee/presentation/bloc/employee_event.dart';
import 'package:ssvl_erp_system_bloc/features/employee/presentation/bloc/employee_state.dart';

import '../../../../core/shared/widgets/responsive.dart';
import '../../../../core/theme/colors.dart';
import '../../../../routes/routes.dart';
import '../bloc/employee_bloc.dart';

class EmployeeDrawer extends StatelessWidget {
  const EmployeeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final location = GoRouterState.of(context).matchedLocation;
    return BlocBuilder<EmployeeBloc, EmployeeState>(
      builder: (context, state) {
        return SizedBox(
          width: isDesktop ? 250 : null,
          child: NavigationDrawer(
            elevation: isDesktop ? 0 : null,
            //   selectedIndex: state is PageChanged ? state.currentIndex : 0,
            selectedIndex: _getCurrentIndex(location),

            onDestinationSelected: (index) {
              if (index == 5) {
                context.read<EmployeeBloc>().add(LogoutEvent(context: context));
              } else {
                context.read<EmployeeBloc>().add(PageChangeEvent(index));
                _handleNavigation(context, index);
                if (!isDesktop) {
                  Navigator.of(context).pop();
                }
              }
            },

            children: const [
              Image(image: AssetImage(AppStrings.logoImage)),
              Padding(
                padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              NavigationDrawerDestination(
                icon: Icon(Icons.home, color: AppColors.primaryDark),
                label: Text(
                  'Dashboard',
                  style: TextStyle(color: AppColors.primaryDark),
                ),
              ),
              NavigationDrawerDestination(
                icon: Icon(Icons.event_note, color: AppColors.primaryDark),
                label: Text(
                  'Activity',
                  style: TextStyle(color: AppColors.primaryDark),
                ),
              ),
              NavigationDrawerDestination(
                icon: Icon(Icons.wallet_travel, color: AppColors.primaryDark),
                label: Text(
                  'Leave',
                  style: TextStyle(color: AppColors.primaryDark),
                ),
              ),
              NavigationDrawerDestination(
                icon: Icon(Icons.person, color: AppColors.primaryDark),
                label: Text(
                  'Profile',
                  style: TextStyle(color: AppColors.primaryDark),
                ),
              ),
              NavigationDrawerDestination(
                icon: Icon(Icons.location_city, color: AppColors.primaryDark),
                label: Text(
                  'Company',
                  style: TextStyle(color: AppColors.primaryDark),
                ),
              ),
              Divider(),
              NavigationDrawerDestination(
                icon: Icon(Icons.logout, color: AppColors.primaryDark),
                label: Text(
                  'Logout',
                  style: TextStyle(color: AppColors.primaryDark),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  int _getCurrentIndex(String location) {
    if (location.endsWith(Routes.employeeDashboard)) return 0;
    if (location.endsWith(Routes.employeeActivity)) return 1;
    if (location.endsWith(Routes.employeeLeave)) return 2;
    if (location.endsWith(Routes.employeeProfile)) return 3;
    if (location.endsWith(Routes.employeeCompany)) return 4;
    return 0;
  }

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(Routes.employeeDashboard);
        break;
      case 1:
        context.go(Routes.employeeActivity);
        break;
      case 2:
        context.go(Routes.employeeLeave);
        break;
      case 3:
        context.go(Routes.employeeProfile);
        break;
      case 4:
        context.go(Routes.employeeCompany);
        break;
      case 5:
        context.read<EmployeeBloc>().add(LogoutEvent(context: context));
        break;
    }
  }
}
