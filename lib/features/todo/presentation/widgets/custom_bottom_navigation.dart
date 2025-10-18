import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/helper_method.dart';
import '../../provider/bottom_navigation_provider.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavigationProvider = Provider.of<BottomNavigationProvider>(
      context,
    );

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: SafeArea(
        child: GNav(
          gap: 8,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          backgroundColor: Colors.transparent,
          color: Colors.grey,
          activeColor: HelperMethods.themeColor(context),
          tabBackgroundColor: HelperMethods.themeColor(
            context,
          ).withOpacity(0.1),
          iconSize: 30,
          curve: Curves.easeOutExpo,
          duration: const Duration(milliseconds: 400),

          selectedIndex: bottomNavigationProvider.selectedIndex,
          onTabChange: (index) {
            bottomNavigationProvider.onItemTapped(index);
          },

          tabs: const [
            GButton(icon: EvaIcons.homeOutline, text: 'Home'),
            GButton(icon: EvaIcons.calendarOutline, text: 'Calendar'),
            GButton(icon: EvaIcons.personOutline, text: 'Profile'),
          ],
        ),
      ),
    );
  }
}
