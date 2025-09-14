import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ssvl_erp_system_bloc/features/admin/presentation/bloc/employee/employee_event.dart';
import 'package:ssvl_erp_system_bloc/routes/routes.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/sizes.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../admin/presentation/bloc/employee/employee_bloc.dart';
import '../../../admin/presentation/bloc/employee/employee_state.dart';

class AddEmployeePage extends StatelessWidget {
  AddEmployeePage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();

  final ValueNotifier<bool> passwordVisible = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmployeeBloc, EmployeeState>(
      listener: (context, state) {
        if (state is EmployeeInsertSuccess) {
          showSuccessSnackBar(context, state.message);
          _formKey.currentState?.reset();
          _nameController.clear();
          _emailController.clear();
          _mobileController.clear();
          _passwordController.clear();
          context.go(Routes.adminDashboard);
        } else if (state is EmployeeError) {
          showErrorSnackBar(context, state.message);
        }
      },
      child: BlocBuilder<EmployeeBloc, EmployeeState>(
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
                          'Add New Employee',
                          style: TextStyle(
                            fontSize: Sizes.fontSizeLg,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                    SizedBox(
                      width: 500,
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(Sizes.md),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: Sizes.md,
                            children: [
                              TextFormField(
                                style: const TextStyle(
                                  color: AppColors.primaryDark,
                                ),
                                controller: _nameController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: AppColors.primary,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(Sizes.md),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: AppColors.primary,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(Sizes.md),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: AppColors.primary,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(Sizes.md),
                                    ),
                                  ),
                                  label: const Text(
                                    'Enter Name',
                                    style: TextStyle(
                                      color: AppColors.primaryDark,
                                    ),
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(Sizes.md),
                                    child: const Icon(
                                      Icons.person_outline,
                                      size: 24,
                                      color: AppColors.primaryDark,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Name can\'t be empty';
                                  } else {
                                    return null;
                                  }
                                },
                              ),

                              TextFormField(
                                style: const TextStyle(
                                  color: AppColors.primaryDark,
                                ),
                                controller: _emailController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: AppColors.primary,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(Sizes.md),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: AppColors.primary,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(Sizes.md),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: AppColors.primary,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(Sizes.md),
                                    ),
                                  ),
                                  label: const Text(
                                    'Enter Email Id',
                                    style: TextStyle(
                                      color: AppColors.primaryDark,
                                    ),
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(Sizes.md),
                                    child: const Icon(
                                      Icons.email_outlined,
                                      size: 24,
                                      color: AppColors.primaryDark,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email Id can\'t be empty';
                                  } else if (!RegExp(
                                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                                  ).hasMatch(value)) {
                                    return 'Invalid Email Id';
                                  } else {
                                    return null;
                                  }
                                },
                              ),

                              TextFormField(
                                style: const TextStyle(
                                  color: AppColors.primaryDark,
                                ),
                                controller: _mobileController,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                maxLength: 10,
                                buildCounter:
                                    (
                                      context, {
                                      required currentLength,
                                      required isFocused,
                                      required maxLength,
                                    }) {
                                      return Text(
                                        '$currentLength/$maxLength',
                                        style: TextStyle(
                                          color: currentLength > maxLength!
                                              ? Colors.red
                                              : Colors.blue,
                                        ),
                                      );
                                    },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: AppColors.primary,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(Sizes.md),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: AppColors.primary,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(Sizes.md),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: AppColors.primary,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(Sizes.md),
                                    ),
                                  ),
                                  label: const Text(
                                    'Enter Mobile No',
                                    style: TextStyle(
                                      color: AppColors.primaryDark,
                                    ),
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(Sizes.md),
                                    child: const Icon(
                                      Icons.phone_android,
                                      size: 24,
                                      color: AppColors.primaryDark,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Mobile No can\'t be empty';
                                  }
                                  if (value.length != 10) {
                                    return 'Invalid Mobile Number';
                                  } else {
                                    return null;
                                  }
                                },
                              ),

                              ValueListenableBuilder(
                                valueListenable: passwordVisible,
                                builder: (context, visible, _) {
                                  return TextFormField(
                                    style: const TextStyle(
                                      color: AppColors.primaryDark,
                                    ),
                                    controller: _passwordController,
                                    keyboardType: TextInputType.text,
                                    obscureText: !visible,
                                    textInputAction: TextInputAction.done,

                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(Sizes.md),
                                        child: const Icon(
                                          Icons.lock_outline,
                                          size: 24,
                                          color: AppColors.primaryDark,
                                        ),
                                      ),

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
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColors.primary,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(Sizes.md),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColors.primary,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(Sizes.md),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColors.primary,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(Sizes.md),
                                        ),
                                      ),
                                      label: const Text(
                                        'Enter Password',
                                        style: TextStyle(
                                          color: AppColors.primaryDark,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Password can\'t be empty';
                                      } else if (value.length < 3) {
                                        return 'Minimum 3 characters required.';
                                      } else {
                                        return null;
                                      }
                                    },
                                  );
                                },
                              ),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryDark,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        Sizes.md,
                                      ),
                                    ),
                                  ),

                                  onPressed: state is EmployeeLoading
                                      ? null
                                      : () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            context.read<EmployeeBloc>().add(
                                              AddEmployee(
                                                name: _nameController.text,
                                                email: _emailController.text,
                                                mobileNo:
                                                    _mobileController.text,
                                                password:
                                                    _passwordController.text,
                                              ),
                                            );
                                          }
                                        },
                                  child: state is EmployeeLoading
                                      ? const CircularProgressIndicator()
                                      : Padding(
                                          padding: const EdgeInsets.all(
                                            Sizes.sm,
                                          ),
                                          child: const Text(
                                            'Add Employee',
                                            style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: Sizes.fontSizeLg,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
}
