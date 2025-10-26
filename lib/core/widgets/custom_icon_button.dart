import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double btnHeight;
  final double btnWidth;
  final IconData iconData;
  final bgColor;
  final textColor;
  final iconColor;

  const CustomIconButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.btnHeight,
    required this.btnWidth,
    required this.iconData,
    this.bgColor,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      color: bgColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(4),
          height: btnHeight,
          width: btnWidth,
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
                style: TextStyle(fontWeight: FontWeight.w700, color: textColor),
              ),
              SizedBox(width: 10),
              Icon(iconData, size: 20, color: iconColor),
            ],
          ),
        ),
      ),
    );
  }
}
