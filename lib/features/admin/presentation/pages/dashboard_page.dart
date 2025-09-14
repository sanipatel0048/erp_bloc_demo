import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ssvl_erp_system_bloc/features/admin/presentation/bloc/dashboard/dashboard_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/sizes.dart';
import '../bloc/dashboard/dashboard_event.dart';
import '../bloc/dashboard/dashboard_state.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DashboardBloc>().add(LoadEmployees());
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.whiteTransparent1,
          body: Padding(
            padding: const EdgeInsets.only(
              left: Sizes.sm,
              right: Sizes.sm,
              bottom: Sizes.sm,
            ),
            child: Card(
              elevation: 2,
              color: AppColors.white,
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(Sizes.sm),
                      child: Text(
                        'Employee List',
                        style: TextStyle(
                          fontSize: Sizes.fontSizeLg,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  Expanded(child: _buildContent(state)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(DashboardState state) {
    if (state is DashboardInitial) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryDark),
      );
    }
    if (state is DashboardLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryDark),
      );
    }

    if (state is DashboardLoaded) {
      final employees = state.employees;
      if (employees.isEmpty) {
        return const Center(
          child: Text(
            'No Records Found',
            style: TextStyle(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }

      return SelectionArea(
        child: DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 600,
          columns: const [
            DataColumn2(
              label: Text(
                'Employee ID',
                style: TextStyle(color: AppColors.primaryDark),
              ),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text(
                'Name',
                style: TextStyle(color: AppColors.primaryDark),
              ),
              size: ColumnSize.M,
            ),
            DataColumn2(
              label: Text(
                'Mobile',
                style: TextStyle(color: AppColors.primaryDark),
              ),
              size: ColumnSize.M,
            ),
            DataColumn2(
              label: Text(
                'Email',
                style: TextStyle(color: AppColors.primaryDark),
              ),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: Text(
                'Join Date',
                style: TextStyle(color: AppColors.primaryDark),
              ),
              size: ColumnSize.M,
            ),
            DataColumn2(
              label: Text(
                'Action',
                style: TextStyle(color: AppColors.primaryDark),
              ),
              size: ColumnSize.M,
            ),
          ],
          rows: employees.map((employee) {
            return DataRow(
              cells: [
                DataCell(
                  Text(
                    employee.employeeId,
                    style: TextStyle(
                      color: AppColors.primaryDark,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primaryDark,
                    ),
                  ),
                ),
                DataCell(Text(employee.name)),
                DataCell(Text(employee.mobileNo)),
                DataCell(Text(employee.email)),
                DataCell(Text(_formatDate(employee.date))),
                DataCell(
                  Row(
                    children: [
                      Tooltip(
                        message: 'View',
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.remove_red_eye_outlined,
                            color: AppColors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      );
    }

    if (state is DashboardError) {
      return Center(
        child: Text(
          state.message,
          style: const TextStyle(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return const SizedBox();
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final date = DateTime.parse(dateStr);
      final dateIst = date.toLocal();
      return DateFormat('dd-MM-yyyy HH:mm:ss a').format(dateIst);
    } catch (e) {
      return '';
    }
  }
}
