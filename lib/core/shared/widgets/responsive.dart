import 'package:flutter/material.dart';

import '../../theme/sizes.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < Sizes.mobileScreenSize;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < Sizes.customScreenSize &&
          MediaQuery.of(context).size.width >= Sizes.mobileScreenSize;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= Sizes.customScreenSize;
}