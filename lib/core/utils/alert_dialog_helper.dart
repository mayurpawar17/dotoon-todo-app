import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/onboarding/provider/onboarding_provider.dart';
import '../widgets/custom_btn.dart';
import 'helper_method.dart';

void showCustomDialog(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final onBoardingProvider = Provider.of<OnBoardingProvider>(
    context,
    listen: false,
  );
  onBoardingProvider.loadPreviousName(); // load old name before showing dialog

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Consumer<OnBoardingProvider>(
        builder: (context, onBoardingProvider, child) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: HelperMethods.themeColor(context),

            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  cursorOpacityAnimates: true,
                  cursorColor: isDark ? Colors.black : Colors.white,
                  autofocus: true,
                  style: TextStyle(color: isDark ? Colors.black : Colors.white),
                  controller: onBoardingProvider.nameController,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ],
            ),
            actions: [
              CustomBtn(
                bgColor: Colors.red,
                textColor: Colors.white,
                text: 'Cancel',
                onTap: () {
                  onBoardingProvider.clearEditing();
                  Navigator.of(context).pop();
                },
                btnHeight: screenHeight * 0.06,
                btnWidth: screenWidth * 0.2,
              ),

              CustomBtn(
                bgColor: isDark ? Colors.black : Colors.white,
                textColor: isDark ? Colors.white : Colors.black,
                text: 'Save',
                onTap: () {
                  final rename = onBoardingProvider.nameController.text.trim();
                  if (rename.isNotEmpty) {
                    onBoardingProvider.setName(rename);
                  }
                  onBoardingProvider.clearEditing();
                  Navigator.of(context).pop();
                },
                btnHeight: screenHeight * 0.06,
                btnWidth: screenWidth * 0.2,
              ),
            ],
          );
        },
      );
    },
  );
}
