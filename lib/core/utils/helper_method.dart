import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class HelperMethods {
  static Color firstWhiteColor(context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Colors.white : AppColors.primaryColorDarkMode;
  }

  static Color firstDarkColor(context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? AppColors.primaryColorDarkMode : Colors.white;
  }

  static Color firstDarkSecondaryColor(context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? AppColors.secondaryColorDarkMode : Colors.white;
  }

  static Color firstDarkTextColor(context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Colors.black : Colors.white;
  }

  static Color firstDarkIconColor(context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? AppColors.primaryColorDarkMode : Colors.white;
  }
}
