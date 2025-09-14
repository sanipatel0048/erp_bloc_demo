import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ssvl_erp_system_bloc/core/utils/helper_functions.dart';
import 'package:ssvl_erp_system_bloc/core/utils/snackbar_utils.dart';
import 'package:ssvl_erp_system_bloc/core/widgets/custom_text_field.dart';
import 'package:ssvl_erp_system_bloc/features/admin/presentation/bloc/activity/activity_event.dart';
import 'package:ssvl_erp_system_bloc/features/admin/presentation/widgets/update_check_in_dialog.dart';
import 'package:ssvl_erp_system_bloc/features/admin/presentation/widgets/update_check_out_dialog.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/sizes.dart';
import '../../data/models/inout_model.dart';
import '../bloc/activity/activity_bloc.dart';
import '../bloc/activity/activity_state.dart';
import '../widgets/custom_date_text_field.dart';

class ViewActivityPage extends StatelessWidget {
  ViewActivityPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _userIdController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<dynamic> checkListData = [];

    _dateController.text = DateFormat(
      'd/M/yyyy',
    ).format(DateTime.now()).toString();
    final ScrollController horizontalScrollController = ScrollController();

    /// Fetching list of activity data
    return BlocListener<ActivityBloc, ActivityState>(
      listener: (context, state) {
        if (state is ActivityError) {
          debugPrint('Error: ${state.error}');
          checkListData = [];
        } else if (state is ActivitySuccess) {
          var inOutList = state.activityDataList;
          if (inOutList.isNotEmpty) {
            checkListData = inOutList[0]['timings'];
          }
        } else if (state is ActivityCheckInUpdateSuccess) {
          showSuccessSnackBar(context, 'Check In Updated Successfully');
          checkListData.clear();
          context.read<ActivityBloc>().add(
            GetActivity(employeeId: state.employeeId, date: state.date),
          );
        } else if (state is ActivityCheckOutUpdateSuccess) {
          showSuccessSnackBar(context, 'Check Out Updated Successfully');
          checkListData.clear();
          context.read<ActivityBloc>().add(
            GetActivity(employeeId: state.employeeId, date: state.date),
          );
        } else if (state is ActivityLoading) {
          CircularProgressIndicator();
        }
      },
      child: BlocBuilder<ActivityBloc, ActivityState>(
        builder: (context, state) {
          Duration totalDuration = Duration.zero;
          String employeeId = '';
          if (state is ActivitySuccess) {
            totalDuration = state.totalWorkingHours ?? Duration.zero;
            employeeId = state.employeeId;
          } else {
            totalDuration = Duration.zero;
            employeeId = '';
          }
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
                          'View Employee Activity',
                          style: TextStyle(
                            fontSize: Sizes.fontSizeLg,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                    Form(
                      key: _formKey,
                      child:
                          MediaQuery.of(context).size.width <=
                              Sizes.tabletScreenSize
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                spacing: Sizes.md,
                                children: [
                                  CustomTextField(
                                    controller: _userIdController,
                                    label: 'Enter UserId',
                                    prefixIcon: Icons.person_outline,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'UserId can\'t be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomDateTextField(
                                    controller: _dateController,
                                    label: 'Select date',
                                    icon: Icons.date_range,
                                  ),
                                  submitButton(context, state),
                                  Text(
                                    'Total Hours: ${HelperFunctions.formatDuration(totalDuration)}',
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      color: AppColors.primaryDark,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: CustomTextField(
                                    controller: _userIdController,
                                    label: 'Enter UserId',
                                    prefixIcon: Icons.person_outline,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'UserId can\'t be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: CustomDateTextField(
                                    controller: _dateController,
                                    label: 'Select date',
                                    icon: Icons.date_range,
                                  ),
                                ),
                                Flexible(child: submitButton(context, state)),
                                Flexible(
                                  child: Text(
                                    'Total Hours: ${HelperFunctions.formatDuration(totalDuration)}',
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      color: AppColors.primaryDark,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    const Divider(),
                    Visibility(
                      visible:
                          state is ActivitySuccess || state is ActivityError,
                      child: Column(
                        children: [
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(Sizes.sm),
                              child: Text(
                                'Activity List',
                                style: TextStyle(
                                  color: AppColors.primaryDark,
                                  fontSize: Sizes.fontSizeLg,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          checkListData.isEmpty
                              ? const Padding(
                                  padding: EdgeInsets.all(Sizes.md),
                                  child: SizedBox(
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      'No Records Found',
                                      style: TextStyle(
                                        color: AppColors.primaryDark,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              : LayoutBuilder(
                                  builder: (context, constraints) {
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: ScrollbarTheme(
                                        data: ScrollbarThemeData(
                                          thumbColor: WidgetStateProperty.all(
                                            Colors.grey.withAlpha(2),
                                          ),
                                        ),
                                        child: Scrollbar(
                                          interactive: true,
                                          thumbVisibility: true,
                                          controller:
                                              horizontalScrollController,
                                          child: SingleChildScrollView(
                                            controller:
                                                horizontalScrollController,
                                            scrollDirection: Axis.horizontal,
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                minWidth: constraints.maxWidth,
                                              ),
                                              child: IntrinsicWidth(
                                                child: DataTable(
                                                  columnSpacing: 8,
                                                  columns: [
                                                    HelperFunctions.buildDataColumn(
                                                      'Check In',
                                                    ),
                                                    HelperFunctions.buildDataColumn(
                                                      'Check In Task Details',
                                                    ),
                                                    HelperFunctions.buildDataColumn(
                                                      'Checkout',
                                                    ),
                                                    HelperFunctions.buildDataColumn(
                                                      'Check Out Task Details',
                                                    ),
                                                    HelperFunctions.buildDataColumn(
                                                      'Working Hours',
                                                    ),
                                                    HelperFunctions.buildDataColumn(
                                                      'Actions',
                                                    ),
                                                  ],
                                                  rows: List.generate(checkListData.length, (
                                                    index,
                                                  ) {
                                                    final timing =
                                                        checkListData[index];
                                                    return DataRow(
                                                      cells: [
                                                        HelperFunctions.buildDataCell(
                                                          HelperFunctions.getDateFormat(
                                                            InOut.fromJson(
                                                                  timing,
                                                                ).checkIn
                                                                .toString(),
                                                          ),
                                                        ),
                                                        HelperFunctions.buildDataCell(
                                                          InOut.fromJson(
                                                                    timing,
                                                                  ).checkInWork ==
                                                                  null
                                                              ? ''
                                                              : InOut.fromJson(
                                                                      timing,
                                                                    )
                                                                    .checkInWork
                                                                    .toString(),
                                                        ),
                                                        HelperFunctions.buildDataCell(
                                                          InOut.fromJson(
                                                                    timing,
                                                                  ).checkOut ==
                                                                  null
                                                              ? ''
                                                              : HelperFunctions.getDateFormat(
                                                                  InOut.fromJson(
                                                                        timing,
                                                                      ).checkOut
                                                                      .toString(),
                                                                ),
                                                        ),
                                                        HelperFunctions.buildDataCell(
                                                          InOut.fromJson(
                                                                    timing,
                                                                  ).checkOutWork ==
                                                                  null
                                                              ? ''
                                                              : InOut.fromJson(
                                                                      timing,
                                                                    )
                                                                    .checkOutWork
                                                                    .toString(),
                                                        ),
                                                        HelperFunctions.buildDataCell(
                                                          InOut.fromJson(
                                                                    timing,
                                                                  ).checkOut !=
                                                                  null
                                                              ? HelperFunctions.formatDuration(
                                                                  DateTime.parse(
                                                                    InOut.fromJson(
                                                                          timing,
                                                                        )
                                                                        .checkOut
                                                                        .toString(),
                                                                  ).difference(
                                                                    DateTime.parse(
                                                                      InOut.fromJson(
                                                                        timing,
                                                                      ).checkIn.toString(),
                                                                    ),
                                                                  ),
                                                                )
                                                              : '',
                                                        ),
                                                        DataCell(
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .primaryDark,
                                                                ),
                                                                onPressed: () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder: (context) {
                                                                      return UpdateCheckInDialog(
                                                                        timing:
                                                                            timing,
                                                                        employeeId:
                                                                            employeeId,
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child: const Text(
                                                                  'Edit Check In',
                                                                  style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              // Space between buttons
                                                              ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .primaryDark,
                                                                ),
                                                                onPressed: () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder: (context) {
                                                                      return UpdateCheckOutDialog(
                                                                        timing:
                                                                            timing,
                                                                        employeeId:
                                                                            employeeId,
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child: const Text(
                                                                  'Edit Check Out',
                                                                  style: TextStyle(
                                                                    color: AppColors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget submitButton(BuildContext context, ActivityState state) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            context.read<ActivityBloc>().add(
              GetActivity(
                employeeId: _userIdController.text,
                date: _dateController.text,
              ),
            );
          }
        },
        child: state is ActivityLoading
            ? CircularProgressIndicator(color: AppColors.white)
            : Text(
                'Search',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.fontSizeMd,
                ),
              ),
      ),
    );
  }
}
