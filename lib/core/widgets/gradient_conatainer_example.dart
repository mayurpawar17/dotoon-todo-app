import 'package:flutter/material.dart';

class GradientContainerExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFE0BBFF), // light purple highlight
                Color(0xFFB388FF), // mid tone purple
                Color(0xFF7C4DFF), // deeper purple
                Color(0xFF9C6CFF), // subtle highlight
              ],
              stops: [0.0, 0.4, 0.7, 1.0], // precise stops for smooth blending
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Center(child: Icon(Icons.laptop, size: 100)),
        ),
      ),
    );
  }
}
