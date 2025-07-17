import 'package:dotoon_todo_app/screens/signUpScreen.dart';
import 'package:flutter/material.dart';

import 'loginScreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Logo
              Image.asset('assets/pngs/dotoonLogo.png', width: 50, height: 50),
              const SizedBox(height: 24),

              // Title
              const Text(
                'Dotoon',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              // Subtitle
              const Text(
                'The wallet designed to make digital\nID and global finance simple for all.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),

              const Spacer(),

              // Terms & Checkbox
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     // Checkbox(
              //     //   value: isChecked,
              //     //   activeColor: Colors.black,
              //     //   onChanged: (value) {
              //     //
              //     //   },
              //     // ),
              //     Expanded(
              //       child: RichText(
              //         text: TextSpan(
              //           style: const TextStyle(
              //             fontSize: 13,
              //             color: Colors.black,
              //           ),
              //           children: [
              //             const TextSpan(text: 'I agree with '),
              //             TextSpan(
              //               text: 'User Terms And Conditions',
              //               style: const TextStyle(color: Colors.blue),
              //             ),
              //             const TextSpan(text: ' and\nacknowledge the '),
              //             TextSpan(
              //               text: 'Privacy Notice',
              //               style: const TextStyle(color: Colors.blue),
              //             ),
              //             const TextSpan(
              //               text:
              //                   ' of World App provided by Tools for Humanity',
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              const SizedBox(height: 20),

              // New Account Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'New account',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          Text(
                            'Create new World coin account',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_right, size: 30, color: Colors.white54),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Existing Account Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: const BorderSide(color: Colors.black12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Existing account',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          Text(
                            'Restore your account from a backup',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_right, size: 30, color: Colors.black54),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
