import 'package:dotoon_todo_app/screens/todoScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/appColors.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Future<void> saveUsername(String name) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('USERNAME', name);
  }

  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/dotoonLogoWhite.svg',
                  width: 90,
                  height: 90,
                ),

                // LogoWidget(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Text(
                  'Welcome to Dotoon',
                  style: TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
                Text(
                  'Your Day, Organized the Dotoon Way',
                  style: TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    color: todoItemCardColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: _usernameController,
                    style: TextStyle(color: whiteColor),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your name',
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                InkWell(
                  onTap: () async {
                    final username = _usernameController.text.trim();

                    if (username.isEmpty) return;

                    await saveUsername(username); // await the storage
                    _usernameController.clear();

                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 150),
                        transitionsBuilder: (context, ani, secondAni, child) {
                          return FadeTransition(opacity: ani, child: child);
                        },
                        pageBuilder: (context, ani, secondAni) => TodoScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Continue', style: TextStyle(fontSize: 18)),
                          Icon(Icons.arrow_right),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
