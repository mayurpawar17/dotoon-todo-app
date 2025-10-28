import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/onboarding/data/onboarding_services.dart';
import 'features/onboarding/presentation/welcome_screen.dart';
import 'features/onboarding/provider/onboarding_provider.dart';
import 'features/theme/presentation/app_themes.dart';
import 'features/theme/provider/theme_provider.dart';
import 'features/todo/presentation/screens/home_screen.dart';
import 'features/todo/provider/bottom_navigation_provider.dart';
import 'features/todo/provider/chip_filter_provider.dart';
import 'features/todo/provider/priority_provider.dart';
import 'features/todo/provider/task_provider.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Keep splash until initialization completes
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  bool onboarded = await OnBoardingServices.isOnboarded();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (_) {
            final provider = OnBoardingProvider();
            provider.loadName(); // load stored name at startup
            return provider;
          },
        ),
        ChangeNotifierProvider(create: (_) => ChipFilterProvider()),
        ChangeNotifierProvider(create: (_) => PriorityProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
      ],

      child: MyApp(onboarded: onboarded),
    ),

    // Once done, remove it
  );
  // FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  final bool onboarded;

  const MyApp({super.key, required this.onboarded});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AnimatedTheme(
          data: isDark ? ThemeData.dark() : ThemeData.light(),
          duration: const Duration(milliseconds: 400), // smooth transition
          curve: Curves.easeInOut,
          child: MaterialApp(
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: themeProvider.themeMode,
            debugShowCheckedModeBanner: false,
            home: onboarded ? HomeScreen() : WelcomeScreen(),
          ),
        );
      },
    );
  }
}
