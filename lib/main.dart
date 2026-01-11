import 'package:dotoon_todo_app/app_gate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/onboarding/provider/onboarding_provider.dart';
import 'features/theme/presentation/app_themes.dart';
import 'features/theme/provider/theme_provider.dart';
import 'features/todo/provider/bottom_navigation_provider.dart';
import 'features/todo/provider/chip_filter_provider.dart';
import 'features/todo/provider/priority_provider.dart';
import 'features/todo/provider/task_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskProvider>(create: (_) => TaskProvider()),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
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

      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AnimatedTheme(
          data: isDark ? ThemeData.dark() : ThemeData.light(),
          duration: const Duration(milliseconds: 400), // smooth transition
          curve: Curves.easeInOut,
          child: MaterialApp(theme: AppThemes.lightTheme, darkTheme: AppThemes.darkTheme, themeMode: themeProvider.themeMode, debugShowCheckedModeBanner: false, home: const AppGate()),
        );
      },
    );
  }
}
