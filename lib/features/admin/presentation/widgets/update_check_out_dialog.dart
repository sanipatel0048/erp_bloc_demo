import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ssvl_erp_system_bloc/features/admin/presentation/bloc/activity/activity_event.dart';

import '../../data/models/inout_model.dart';
import '../bloc/activity/activity_bloc.dart';

class UpdateCheckOutDialog extends StatelessWidget {
  final dynamic timing;
  final String employeeId;

  UpdateCheckOutDialog({
    super.key,
    required this.timing,
    required this.employeeId,
  });

  final editCheckOutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime checkOutUTC = DateTime.parse(
      InOut.fromJson(timing).checkOut?.toString() ?? "",
    ).toUtc();
    DateTime checkOutIST = checkOutUTC.add(
      const Duration(hours: 5, minutes: 30),
    );
    editCheckOutController.text = DateFormat('HH:mm:ss').format(checkOutIST);
    DateTime? utcCheckInDateTime;

    return AlertDialog(
      title: const Text('Edit Check Out'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              onTap: () async {
                TimeOfDay? selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(
                    checkOutIST,
                  ), // Set the initial time from the current check-out time
                );

                if (selectedTime != null) {
                  DateTime now = checkOutIST;
                  DateTime selectedDateTime = DateTime(
                    now.year,
                    now.month,
                    now.day,
                    selectedTime.hour,
                    selectedTime.minute,
                  );

                  // Update the TextField with the selected time in IST format
                  editCheckOutController.text = DateFormat(
                    'HH:mm:ss',
                  ).format(selectedDateTime);

                  // Optional: You can also store the UTC value if needed
                  utcCheckInDateTime = selectedDateTime.toUtc();
                }
              },
              readOnly: true,
              controller: editCheckOutController,
              decoration: const InputDecoration(labelText: 'Check Out Time'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            context.read<ActivityBloc>().add(
              UpdateCheckOut(
                employeeId: employeeId,
                date: DateFormat('d/M/yyyy').format(checkOutIST),
                checkOut: checkOutUTC.toIso8601String(),
                newCheckOut: utcCheckInDateTime!.toIso8601String(),
              ),
            );
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
