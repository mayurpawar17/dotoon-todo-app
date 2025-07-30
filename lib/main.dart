import 'package:dotoon_todo_app/screens/todoScreen.dart';
import 'package:dotoon_todo_app/screens/welcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/appColors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
