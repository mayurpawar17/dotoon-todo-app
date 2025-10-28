import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/helper_method.dart';
import '../../provider/bottom_navigation_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Consumer<BottomNavigationProvider>(
        builder: (context, bottomNavigationProvider, child) {
          return bottomNavigationProvider.screens[bottomNavigationProvider
              .selectedIndex];
        },
      ),

      bottomNavigationBar: Consumer<BottomNavigationProvider>(
        builder: (context, bottomNavigationProvider, child) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: bottomNavigationProvider.selectedIndex,
            onTap: bottomNavigationProvider.onItemTapped,
            elevation: 0,
            // selectedItemColor: HelperMethods.themeColor(context),
            // unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            selectedLabelStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),

            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  EvaIcons.homeOutline,
                  color: HelperMethods.firstWhiteColor(context),
                ),
                activeIcon: Icon(
                  EvaIcons.home,
                  color: HelperMethods.firstWhiteColor(context),
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  EvaIcons.calendarOutline,
                  color: HelperMethods.firstWhiteColor(context),
                ),
                activeIcon: Icon(
                  EvaIcons.calendar,
                  color: HelperMethods.firstWhiteColor(context),
                ),
                label: "Calendar",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  EvaIcons.personOutline,
                  color: HelperMethods.firstWhiteColor(context),
                ),
                activeIcon: Icon(
                  EvaIcons.person,
                  color: HelperMethods.firstWhiteColor(context),
                ),
                label: "Profile",
              ),
            ],
          );
        },
      ),
    );
  }
}
