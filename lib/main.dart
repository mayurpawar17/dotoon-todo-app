import 'package:dotoon_todo_app/screens/todoScreen.dart';
import 'package:dotoon_todo_app/screens/welcomeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/todoScreen': (context) => TodoScreen()},
    );
  }
}
