import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/dotoon_logo.dart';
import '../../todo/presentation/home_screen.dart';
import '../data/onboarding_services.dart';
import '../provider/onboarding_prodvider.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
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
                      controller: _nameController,
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
                  Consumer<OnBoardingProvider>(
                    builder: (context, onBoardingProvider, child) {
                      return CustomButton(
                        text: 'Continue',
                        onTap: () async {
                          if (_nameController.text.isNotEmpty) {
                            final name = _nameController.text.trim();
                            onBoardingProvider.setName(name);
                            await OnBoardingServices.setOnboarded();

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                            _nameController.clear();
                          }
                        },
                        widget: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                      );
                    },
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
