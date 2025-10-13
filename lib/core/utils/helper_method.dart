import 'package:flutter/material.dart';

class HelperMethods {
  static Color themeColor(context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Colors.white : Colors.black;
  }
}
