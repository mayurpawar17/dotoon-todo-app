import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils/alert_dialog_helper.dart';
import '../../../core/utils/helper_method.dart';
import '../../onboarding/provider/onboarding_provider.dart';
import '../provider/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  final String appLink =
      "https://play.google.com/store/apps/developer?id=Mayur+Pawar&hl=en_IN";

  Future<void> _launchAppLink() async {
    final Uri url = Uri.parse(appLink);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      // Error if URL can't be opened
      throw 'Could not launch $appLink';
    }
    HapticFeedback.selectionClick();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: HelperMethods.themeColor(context),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  showCustomDialog(context);
                  HapticFeedback.selectionClick();
                },
                child: ListTile(
                  title: Consumer<OnBoardingProvider>(
                    builder: (context, onBoardingProvider, child) {
                      return Text(
                        onBoardingProvider.name ?? 'no name',
                        style: TextStyle(
                          color: HelperMethods.themeColor(context),
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                  trailing: SizedBox(
                    child: Icon(
                      EvaIcons.editOutline,
                      color: HelperMethods.themeColor(context),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Appearance',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: HelperMethods.themeColor(context),
                ),
              ),
              SizedBox(height: 10),

              ListTile(
                leading: Icon(
                  isDark ? EvaIcons.moon : EvaIcons.sun,
                  color: HelperMethods.themeColor(context),
                ),
                title: Text(
                  '${isDark ? 'Dark' : 'Light'} Theme',
                  style: TextStyle(
                    color: HelperMethods.themeColor(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    return SizedBox(
                      child: CupertinoSwitch(
                        value: isDark,
                        onChanged: (b) {
                          themeProvider.toggleTheme(isDark);
                          HapticFeedback.selectionClick();
                        },
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 50),

              Text(
                'Support',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: HelperMethods.themeColor(context),
                ),
              ),

              SizedBox(height: 10),
              ListTile(
                leading: Icon(
                  EvaIcons.share,
                  color: HelperMethods.themeColor(context),
                ),
                title: Text(
                  'Share with friends',
                  style: TextStyle(
                    color: HelperMethods.themeColor(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  const appLink =
                      "https://play.google.com/store/apps/developer?id=Mayur+Pawar&hl=en_IN";

                  SharePlus.instance.share(
                    ShareParams(
                      text:
                          "I'm been using Dotoon todo app and i really like it.\nYou should try it, too! \nGoogle Play: $appLink",
                    ),
                  );
                  HapticFeedback.selectionClick();
                },
              ),

              // CustomExpansionTile(),
              SizedBox(height: 10),

              ListTile(
                leading: Icon(
                  Icons.apps,
                  color: HelperMethods.themeColor(context),
                ),
                title: Text(
                  'Our Apps',
                  style: TextStyle(
                    color: HelperMethods.themeColor(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: _launchAppLink,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
