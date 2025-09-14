import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ssvl_erp_system_bloc/core/utils/strings.dart';

import '../../../../core/shared/widgets/responsive.dart';
import '../../../../core/theme/colors.dart';
import '../../../../routes/routes.dart';
import '../bloc/admin/admin_bloc.dart';
import '../bloc/admin/admin_event.dart';
import '../bloc/admin/admin_state.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final location = GoRouterState.of(context).matchedLocation;
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        return SizedBox(
          width: isDesktop ? 250 : null,
          child: NavigationDrawer(
            elevation: isDesktop ? 0 : null,
            //   selectedIndex: state is PageChanged ? state.currentIndex : 0,
            selectedIndex: _getCurrentIndex(location),

            onDestinationSelected: (index) {
              if (index == 4) {
                context.read<AdminBloc>().add(LogoutEvent(context: context));
              } else {
                context.read<AdminBloc>().add(ChangePageEvent(index));
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
                icon: Icon(Icons.person_add, color: AppColors.primaryDark),
                label: Text(
                  'Add Employee',
                  style: TextStyle(color: AppColors.primaryDark),
                ),
              ),
              NavigationDrawerDestination(
                icon: Icon(
                  Icons.watch_later_outlined,
                  color: AppColors.primaryDark,
                ),
                label: Text(
                  'Get Timeline',
                  style: TextStyle(color: AppColors.primaryDark),
                ),
              ),
              NavigationDrawerDestination(
                icon: Icon(Icons.timeline, color: AppColors.primaryDark),
                label: Text(
                  'View Activity',
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
    if (location.endsWith(Routes.adminDashboard)) return 0;
    if (location.endsWith(Routes.addEmployee)) return 1;
    if (location.endsWith(Routes.getTimeline)) return 2;
    if (location.endsWith(Routes.viewActivity)) return 3;
    return 0;
  }

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(Routes.adminDashboard);
        break;
      case 1:
        context.go(Routes.addEmployee);
        break;
      case 2:
        context.go(Routes.getTimeline);
        break;
      case 3:
        context.go(Routes.viewActivity);
        break;
      case 4:
        context.read<AdminBloc>().add(LogoutEvent(context: context));
        break;
    }
  }
}
