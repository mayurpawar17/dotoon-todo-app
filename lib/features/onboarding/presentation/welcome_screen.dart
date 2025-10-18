import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/helper_method.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/dotoon_logo.dart';
import '../../todo/presentation/home_screen.dart';
import '../data/onboarding_services.dart';
import '../provider/onboarding_provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.1),
                Center(
                  child: TweenAnimationBuilder(
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, value),
                        child: Opacity(
                          opacity: 1 - (value.abs() / 20),
                          child: child,
                        ),
                      );
                    },
                    tween: Tween<double>(begin: 20, end: 0),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.ease,
                    child: DotoonLogo(),
                  ),
                ),

                SizedBox(height: screenHeight * 0.1),

                AutoSizeText(
                  'Focus on what matters',
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 30,
                    color: HelperMethods.themeColor(context),
                  ),
                ),
                SizedBox(height: screenHeight * 0.1),

                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Consumer<OnBoardingProvider>(
                        builder: (context, onBoardingProvider, child) {
                          return TextField(
                            cursorColor: HelperMethods.themeColor(context),
                            controller: onBoardingProvider.nameController,
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: 'Enter your name',
                              contentPadding: EdgeInsets.all(10),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.1),
                    Consumer<OnBoardingProvider>(
                      builder: (context, onBoardingProvider, child) {
                        return CustomButton(
                          text: 'Continue',
                          onTap: () async {
                            final name =
                                onBoardingProvider.nameController.text.trim();
                            if (name.isNotEmpty) {
                              onBoardingProvider.setName(name);
                              await OnBoardingServices.setOnboarded();

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                              onBoardingProvider.clearEditing();
                            }
                          },
                          widget: Icon(
                            Icons.arrow_forward,
                            color: isDark ? Colors.black : Colors.white,
                            size: 20,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
