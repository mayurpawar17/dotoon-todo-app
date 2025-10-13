import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.06;
    final width = MediaQuery.of(context).size.width * 0.42;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      // backgroundColor: AppColors.primaryColor2,
      appBar: AppBar(
        // backgroundColor: AppColors.primaryColor2,
        title: Text('Settings', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Appearance',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              SizedBox(height: 10),

              ListTile(
                leading: Icon(isDark ? EvaIcons.moon : EvaIcons.sun),
                title: Text('${isDark ? 'Dark' : 'Light'} Theme'),
                trailing: SizedBox(
                  child: CupertinoSwitch(
                    value: isDark,
                    onChanged: (b) => themeProvider.toggleTheme(isDark),
                  ),
                ),
              ),

              SizedBox(height: 50),

              Text(
                'Support',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),

              SizedBox(height: 10),

              // CustomExpansionTile(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
