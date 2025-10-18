import 'package:flutter/material.dart';

import '../../calenderWithFilter/presentation/calendar_screen.dart';
import '../../theme/presentation/settings_screen.dart';
import '../presentation/todo_screen.dart';

class BottomNavigationProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  final List<Widget> screens = [
    TodoScreen(),
    CalendarScreen(),
    SettingsScreen(),
  ];

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
