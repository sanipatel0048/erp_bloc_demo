import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/sizes.dart';

class CustomDateTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final Widget? suffixIcon;

  const CustomDateTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: AppColors.primaryDark),
        keyboardType: TextInputType.text,
        cursorColor: AppColors.primaryDark,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (value) {
          FocusScope.of(context).nextFocus();
        },
        readOnly: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label can\'t be empty';
          }
          return null;
        },
        onTap: () async {
          DateTime today = DateTime.now();
          DateTime initialDate;

          // Try parsing the existing text safely
          try {
            if (controller.text.isNotEmpty) {
              initialDate = DateFormat('d/M/yyyy').parseStrict(controller.text);
            } else {
              initialDate = today;
            }
          } catch (e) {
            debugPrint('Invalid date in controller: $e');
            initialDate = today;
          }

          // Ensure initial date is not in the future
          if (initialDate.isAfter(today)) {
            initialDate = today;
          }
          // Open the date picker with the selected date as initial
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: DateTime(2021),
            lastDate: DateTime.now(),
          );

          if (pickedDate != null) {
            controller.text = DateFormat('d/M/yyyy').format(pickedDate);
          } else {
            debugPrint('No date selected.');
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          labelText: label,

          labelStyle: const TextStyle(color: AppColors.primaryDark),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(Sizes.sm),
            child: Icon(icon, size: Sizes.iconMd, color: AppColors.primaryDark),
          ),
          suffixIcon: suffixIcon,
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
        ),
      ),
    );
  }
}
