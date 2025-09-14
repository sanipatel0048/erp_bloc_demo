import 'package:flutter/material.dart';
import 'package:ssvl_erp_system_bloc/core/theme/colors.dart';

void showCustomSnackBar(
  BuildContext context,
  String message, {
  Color backgroundColor = Colors.black,
  Color textColor = Colors.white,
  SnackBarAction? action,
}) {
  final snackBar = SnackBar(
    content: Text(message, style: TextStyle(color: textColor)),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    action: action,
  );

  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// Optional shortcut helpers
void showSuccessSnackBar(BuildContext context, String message) {
  showCustomSnackBar(context, message, backgroundColor: AppColors.green);
}

void showErrorSnackBar(BuildContext context, String message) {
  showCustomSnackBar(context, message, backgroundColor: AppColors.red);
}
