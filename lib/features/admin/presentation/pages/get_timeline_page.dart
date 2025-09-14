import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ssvl_erp_system_bloc/features/admin/presentation/widgets/custom_date_text_field.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/sizes.dart';
import '../../data/models/timeline_model.dart';
import '../bloc/timeline/timeline_bloc.dart';
import '../bloc/timeline/timeline_event.dart';
import '../bloc/timeline/timeline_state.dart';

class GetTimelinePage extends StatelessWidget {
  GetTimelinePage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _userIdController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<dynamic> timelineData = [];

    _dateController.text = DateFormat(
      'd/M/yyyy',
    ).format(DateTime.now()).toString();
    final ScrollController horizontalScrollController = ScrollController();
    context.read<TimelineBloc>().add(
      GetTimeline(
        employeeId: _userIdController.text,
        date: _dateController.text,
      ),
    );

    /// Fetching list of timeline data
    return BlocListener<TimelineBloc, TimelineState>(
      listener: (context, state) {
        if (state is TimelineError) {
          debugPrint('Error: ${state.message}');
          timelineData = [];
        } else if (state is TimelineSuccess) {
          timelineData = state.timelineData;
        } else if (state is TimelineLoading) {
          CircularProgressIndicator();
        }
      },
      child: BlocBuilder<TimelineBloc, TimelineState>(
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
                          'Employee Timeline',
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
                                  userIdTextField(_userIdController),
                                  CustomDateTextField(
                                    controller: _dateController,
                                    label: 'Select date',
                                    icon: Icons.date_range,
                                  ),
                                  submitButton(context, state),
                                ],
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: userIdTextField(_userIdController),
                                ),
                                Flexible(
                                  child: CustomDateTextField(
                                    controller: _dateController,
                                    label: 'Select date',
                                    icon: Icons.date_range,
                                  ),
                                ),
                                Flexible(child: submitButton(context, state)),
                              ],
                            ),
                    ),
                    const Divider(),
                    Visibility(
                      visible:
                          state is TimelineSuccess || state is TimelineError,
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
                          timelineData.isEmpty
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
                                          thumbVisibility: true,
                                          interactive: true,
                                          controller:
                                              horizontalScrollController,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            controller:
                                                horizontalScrollController,
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                minWidth: constraints.maxWidth,
                                              ),
                                              child: IntrinsicWidth(
                                                child: DataTable(
                                                  columnSpacing: 8,
                                                  columns: [
                                                    buildDataColumn(
                                                      'Employee Id',
                                                    ),
                                                    buildDataColumn(
                                                      'Employee Name',
                                                    ),
                                                    buildDataColumn('Date'),
                                                    buildDataColumn(
                                                      'Total Working Hours',
                                                    ),
                                                  ],
                                                  rows: List.generate(
                                                    timelineData.length,
                                                    (index) {
                                                      final timing =
                                                          timelineData[index];
                                                      return DataRow(
                                                        cells: [
                                                          buildDataCell(
                                                            Timeline.fromJson(
                                                                  timing,
                                                                ).employeeId
                                                                .toString(),
                                                          ),
                                                          buildDataCell(
                                                            Timeline.fromJson(
                                                                  timing,
                                                                ).employeeName
                                                                .toString(),
                                                          ),
                                                          buildDataCell(
                                                            Timeline.fromJson(
                                                              timing,
                                                            ).date.toString(),
                                                          ),
                                                          buildDataCell(
                                                            Timeline.fromJson(
                                                                  timing,
                                                                )
                                                                .totalWorkingHours
                                                                .toString(),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
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

  Widget userIdTextField(TextEditingController controller) {
    return TextFormField(
      style: const TextStyle(color: AppColors.primaryDark),
      controller: controller,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AppColors.primary),
          borderRadius: BorderRadius.all(Radius.circular(Sizes.md)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AppColors.primary),
          borderRadius: BorderRadius.all(Radius.circular(Sizes.md)),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AppColors.primary),
          borderRadius: BorderRadius.all(Radius.circular(Sizes.md)),
        ),
        label: const Text(
          'Enter UserId',
          style: TextStyle(color: AppColors.primaryDark),
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.all(Sizes.sm),
          child: const Icon(Icons.person_outline, color: AppColors.primaryDark),
        ),
      ),
    );
  }

  Widget submitButton(BuildContext context, TimelineState state) {
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
            context.read<TimelineBloc>().add(
              GetTimeline(
                employeeId: _userIdController.text,
                date: _dateController.text,
              ),
            );
          }
        },
        child: state is TimelineLoading
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

  DataColumn buildDataColumn(String text) {
    return DataColumn(
      label: Expanded(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryDark,
          ),
        ),
      ),
    );
  }

  DataCell buildDataCell(String text) {
    return DataCell(
      Center(
        child: Text(text, style: const TextStyle(color: AppColors.black)),
      ),
    );
  }
}
