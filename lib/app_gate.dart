import 'package:flutter/material.dart';

import 'features/onboarding/data/onboarding_services.dart';
import 'features/onboarding/presentation/welcome_screen.dart';
import 'features/todo/presentation/screens/home_screen.dart';

class AppGate extends StatelessWidget {
  const AppGate({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: OnBoardingServices.isOnboarded(),
      builder: (context, snapshot) {
        // While loading onboarding status
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        // Fallback safety
        final onboarded = snapshot.data ?? false;

        return onboarded ? const HomeScreen() : const WelcomeScreen();
      },
    );
  }
}
