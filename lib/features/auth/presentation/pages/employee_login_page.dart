import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssvl_erp_system_bloc/features/auth/presentation/bloc/auth_event.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/sizes.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/utils/strings.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../routes/routes.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';

class EmployeeLoginPage extends StatelessWidget {
  EmployeeLoginPage({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> passwordVisible = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 500;
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthSuccess) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLogin', true);
            await prefs.setString('userType', AppStrings.employee);
            await prefs.setString('webVersion', AppStrings.webVersion);

            showSuccessSnackBar(context, state.message);
            formKey.currentState?.reset();
            mobileNoController.clear();
            passwordController.clear();
            // Navigate to the employee dashboard page
            context.go(Routes.employeeDashboard);
          } else if (state is AuthError) {
            showErrorSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppStrings.logoImage),

                      SizedBox(
                        width: isMobile ? double.infinity : 450,
                        child: Column(
                          children: [
                            const Text(
                              AppStrings.employeeLogin,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryDark,
                              ),
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              controller: mobileNoController,
                              label: AppStrings.enterMobileNo,
                              prefixIcon: Icons.phone_android,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              maxLength: 10,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Mobile No can\'t be empty';
                                } else if (value.length != 10) {
                                  return 'Mobile No must be 10 digits';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            ValueListenableBuilder(
                              valueListenable: passwordVisible,
                              builder: (context, visible, _) {
                                return CustomTextField(
                                  controller: passwordController,
                                  label: AppStrings.enterPassword,
                                  prefixIcon: Icons.lock_outline,
                                  obscureText: !visible,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password can\'t be empty';
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.done,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      visible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppColors.primaryDark,
                                    ),
                                    onPressed: () {
                                      passwordVisible.value = !visible;
                                    },
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryDark,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: state is AuthLoading
                                    ? null
                                    : () {
                                        if (formKey.currentState!.validate()) {
                                          BlocProvider.of<AuthBloc>(
                                            context,
                                          ).add(
                                            LoginAsEmployee(
                                              mobileNo: mobileNoController.text
                                                  .trim(),
                                              password: passwordController.text
                                                  .trim(),
                                            ),
                                          );
                                        }
                                      },
                                child: state is AuthLoading
                                    ? const CircularProgressIndicator(
                                        color: AppColors.white,
                                      )
                                    : const Text(
                                        AppStrings.submit,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Sizes.fontSizeLg,
                                        ),
                                      ),
                              ),
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
      ),
    );
  }
}
