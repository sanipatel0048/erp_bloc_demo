import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/widgets/responsive.dart';
import '../../../../core/theme/colors.dart';
import '../bloc/admin/admin_bloc.dart';
import '../widgets/admin_drawer.dart';

class AdminHomePage extends StatelessWidget {
  final Widget child;
  final String title;

  const AdminHomePage({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminBloc(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = Responsive.isDesktop(context);
          String appBarTitle = 'Dashboard';
          switch (title) {
            case 'dashboard':
              appBarTitle = 'Dashboard';
              break;
            case 'add-employee':
              appBarTitle = 'Add Employee';
              break;
            case 'get-timeline':
              appBarTitle = 'Get Timeline';
              break;
            case 'view-activity':
              appBarTitle = 'View Activity';
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
            drawer: !isDesktop ? const AdminDrawer() : null,
            body: Row(
              children: [
                if (isDesktop) const AdminDrawer(),
                Expanded(child: child),
              ],
            ),
          );
        },
      ),
    );
  }
}
