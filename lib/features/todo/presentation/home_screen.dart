import 'package:dotoon_todo_app/features/todo/presentation/todo_screen2.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/helper_method.dart';
import '../../calenderWithFilter/presentation/calendar_screen.dart';
import '../../theme/presentation/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    // TodoScreen(),
    TodoScreen2(),
    CalendarScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // no shifting animation
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        // 👈 minimal
        showUnselectedLabels: false,
        // 👈 minimal
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              EvaIcons.homeOutline,
              color: HelperMethods.themeColor(context),
            ),
            activeIcon: Icon(
              EvaIcons.home,
              color: HelperMethods.themeColor(context),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              EvaIcons.calendarOutline,
              color: HelperMethods.themeColor(context),
            ),
            activeIcon: Icon(
              EvaIcons.calendar,
              color: HelperMethods.themeColor(context),
            ),
            label: "Tasks",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              EvaIcons.personOutline,
              color: HelperMethods.themeColor(context),
            ),
            activeIcon: Icon(
              EvaIcons.person,
              color: HelperMethods.themeColor(context),
            ),
            label: "Profile",
          ),
        ],
      ),
      // bottomNavigationBar: SafeArea(
      //   child: Container(
      //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      //     decoration: BoxDecoration(
      //       color: Colors.white,
      //       border: Border(
      //         top: BorderSide(color: Colors.grey.shade200, width: 1),
      //       ),
      //     ),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: [
      //         _buildNavItem(EvaIcons.home, 0),
      //         _buildNavItem(EvaIcons.calendar, 1),
      //         _buildNavItem(EvaIcons.settings2, 2),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isActive = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque, // 👈 disables ripple
      child: Icon(icon, size: 26, color: isActive ? Colors.black : Colors.grey),
    );
  }
}
