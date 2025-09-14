import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../features/admin/data/models/inout_model.dart';
import '../theme/colors.dart';

class HelperFunctions {
  ///Date Formatter Function
  static String getDateFormat(String dateUtc) {
    // Step 1: Parse the string into a DateTime object
    DateTime dateTimeUtc = DateTime.parse(dateUtc);

    // Step 2: Convert the DateTime object from UTC to IST
    DateTime dateTimeIst = dateTimeUtc.add(
      const Duration(hours: 5, minutes: 30),
    );

    // Step 3: Format the DateTime object into the desired format
    String formattedDate = DateFormat(
      'dd-MM-yyyy\nhh:mm:ss a',
    ).format(dateTimeIst);

    return formattedDate;
  }

  ///Working Hours Calculation Function
  static Duration getTotalDuration(List<dynamic> checkListData) {
    Duration totalDuration = Duration.zero;
    for (var timings in checkListData) {
      final checkIn = DateTime.parse(
        InOut.fromJson(timings).checkIn.toString(),
      );
      final checkOut = InOut.fromJson(timings).checkOut != null
          ? DateTime.parse(InOut.fromJson(timings).checkOut.toString())
          : null;

      if (checkOut != null) {
        totalDuration += checkOut.difference(checkIn);
      }
    }
    return totalDuration;
  }

  ///Data Cell Builder
  static DataCell buildDataCell(String text) {
    return DataCell(
      Center(
        child: Text(text, style: const TextStyle(color: AppColors.black)),
      ),
    );
  }

  ///Data Column Builder
  static DataColumn buildDataColumn(String text) {
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

  ///Hours Display Format hh:mm:ss
  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }
}
