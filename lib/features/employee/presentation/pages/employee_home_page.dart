import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/widgets/responsive.dart';
import '../../../../core/theme/colors.dart';
import '../bloc/employee_bloc.dart';
import '../widgets/employee_drawer.dart';

class EmployeeHomePage extends StatelessWidget {
  final Widget child;
  final String title;

  const EmployeeHomePage({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeBloc(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = Responsive.isDesktop(context);
          String appBarTitle = 'Dashboard';
          switch (title) {
            case 'dashboard':
              appBarTitle = 'Dashboard';
              break;
            case 'activity':
              appBarTitle = 'Activity';
              break;
            case 'leave':
              appBarTitle = 'Leave';
              break;
            case 'profile':
              appBarTitle = 'Profile';
              break;
            case 'company':
              appBarTitle = 'Company';
              break;
            default:
              appBarTitle = 'Dashboard';
              break;
          }

          return Scaffold(
            appBar: !isDesktop
                ? AppBar(
                    title: Text(appBarTitle),
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                  )
                : null,
            drawer: !isDesktop ? const EmployeeDrawer() : null,
            body: Row(
              children: [
                if (isDesktop) const EmployeeDrawer(),
                Expanded(child: child),
              ],
            ),
          );
        },
      ),
    );
  }
}
