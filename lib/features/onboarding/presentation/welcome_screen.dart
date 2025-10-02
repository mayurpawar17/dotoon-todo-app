import 'package:flutter/material.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/dotoon_logo.dart';
import '../../todo/presentation/todo_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: TweenAnimationBuilder(
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, value),
                      child: Opacity(
                        opacity: 1 - (value.abs() / 20),
                        child: child,
                      ),
                    );
                  },
                  tween: Tween<double>(begin: 20, end: 0),
                  duration: Duration(milliseconds: 600),
                  curve: Curves.ease,
                  child: DotoonLogo(),
                ),
              ),

              Text('Focus on what matters', style: TextStyle(fontSize: 30)),

              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    text: 'Continue',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => TodoScreen()),
                      );
                    },
                    widget: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
