import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ssvl_erp_system_bloc/core/theme/colors.dart';
import 'package:ssvl_erp_system_bloc/core/theme/sizes.dart';
import 'package:ssvl_erp_system_bloc/core/utils/strings.dart';

import '../../../../routes/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.white,
        child: MediaQuery.of(context).size.width <= 500
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppStrings.logoImage),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 24),
                        SizedBox(
                          width: 450,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryDark,
                            ),
                            onPressed: () {
                              context.go(Routes.loginAdmin);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Admin',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizes.fontSizeXLg,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: 450,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryDark,
                            ),
                            onPressed: () {
                              context.go(Routes.loginEmployee);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Employee',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizes.fontSizeXLg,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset(AppStrings.logoImage),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            color: Colors.grey[30],
                            child: SizedBox(
                              width: 400,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 450,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryDark,
                                        ),
                                        onPressed: () {
                                          context.go(Routes.loginAdmin);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Admin',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: Sizes.fontSizeXLg,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    SizedBox(
                                      width: 450,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryDark,
                                        ),
                                        onPressed: () {
                                          context.go(Routes.loginEmployee);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Employee',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: Sizes.fontSizeXLg,
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
                ],
              ),
      ),
    );
  }
}
