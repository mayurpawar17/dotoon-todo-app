import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.widget,
  });

  final String text;
  final VoidCallback onTap;
  final widget;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.07;
    return Material(
      borderRadius: BorderRadius.circular(15),
      color: Colors.black,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            // color: AppColors.accentBlueDarkColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 6),
              widget,
            ],
          ),
        ),
      ),
    );
  }
}
