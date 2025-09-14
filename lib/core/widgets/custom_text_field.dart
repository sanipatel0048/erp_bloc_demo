import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/colors.dart';
import '../theme/sizes.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.validator,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.md),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: AppColors.primaryDark),
        keyboardType: keyboardType ?? TextInputType.text,
        inputFormatters: inputFormatters ?? [],
        maxLength: maxLength,
        cursorColor: AppColors.primaryDark,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: textInputAction ?? TextInputAction.next,
        onFieldSubmitted: (value) {
          FocusScope.of(context).nextFocus();
        },
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.primaryDark),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(Sizes.sm),
            child: Icon(
              prefixIcon,
              size: Sizes.iconMd,
              color: AppColors.primaryDark,
            ),
          ),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: AppColors.primary),
            borderRadius: BorderRadius.circular(Sizes.sm),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: AppColors.primary),
            borderRadius: BorderRadius.circular(Sizes.sm),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: AppColors.primary),
            borderRadius: BorderRadius.circular(Sizes.sm),
          ),
        ),
      ),
    );
  }
}
