import 'package:dotoon_todo_app/screens/todoScreen.dart';
import 'package:dotoon_todo_app/screens/welcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/appColors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isOnboardingDone = prefs.getBool('ONBOARDING') ?? false;
  runApp(MyApp(isOnboardingDone: isOnboardingDone));
}

class MyApp extends StatelessWidget {
  final bool isOnboardingDone;

  const MyApp({super.key, required this.isOnboardingDone});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
        scaffoldBackgroundColor: bgColor,
        appBarTheme: AppBarTheme(color: bgColor),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/todoScreen': (context) => TodoScreen(),
      },
    );
  }
}
