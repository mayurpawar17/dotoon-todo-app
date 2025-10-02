import 'package:flutter/material.dart';

import 'core/theme/app_theming.dart';
import 'features/todo/presentation/todo_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheming.lightTheme,
      // darkTheme: AppTheming.darkTheme,
      debugShowCheckedModeBanner: false,
      home: TodoScreen(),
    );
  }
}
