import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/appColors.dart';
import 'onboarding_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isOnboardingDone = false;
  final TextEditingController _usernameController = TextEditingController();

  // Save username to SharedPreferences asynchronously
  Future<void> saveUsername(String name, bool isOnboardingDone) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('USERNAME', name);
    //save user onboarding
    await pref.setBool('ONBOARDING', isOnboardingDone);
  }

  // Dispose controller to avoid memory leaks
  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  // Helper function for navigation with fade transition
  void _navigateToTodoScreen() {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 150),
        transitionsBuilder: (context, animation, _, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        pageBuilder: (context, _, __) => const OnboardingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery only once for spacing constants
    final mediaHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: SingleChildScrollView(
              // Wrap Column with SingleChildScrollView for smaller screens
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/dotoonLogoWhite.svg',
                    width: 90,
                    height: 90,
                  ),
                  SizedBox(height: mediaHeight * 0.05),

                  Text(
                    'Welcome to Dotoon',
                    style: const TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Your Day, Organized the Dotoon Way',
                    style: const TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: mediaHeight * 0.03),

                  // Username input field container
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      color: todoItemCardColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      controller: _usernameController,
                      style: const TextStyle(color: whiteColor),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your name',
                        hintStyle: TextStyle(color: Colors.white70),
                      ),
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _onContinuePressed(),
                    ),
                  ),
                  SizedBox(height: mediaHeight * 0.05),

                  // Continue button
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _onContinuePressed,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Continue',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.arrow_right, color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Method handling continue button tap
  void _onContinuePressed() async {
    final username = _usernameController.text.trim();

    if (username.isEmpty) {
      // Optionally inform user about invalid input
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter your name')));
      return;
    }
    isOnboardingDone = true;

    await saveUsername(username, isOnboardingDone);

    _usernameController.clear();

    _navigateToTodoScreen();
  }
}
