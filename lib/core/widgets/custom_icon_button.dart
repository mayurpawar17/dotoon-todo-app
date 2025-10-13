import 'package:flutter/material.dart';

import '../utils/helper_method.dart';

class CustomIconButton extends StatelessWidget {
  final height;
  final weight;
  final onTap;
  final text;
  final icon;

  const CustomIconButton({
    super.key,
    this.height,
    this.weight,
    this.onTap,
    this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4),
        height: height,
        width: weight,
        decoration: BoxDecoration(
          // color: AppColors.accentBlueDarkColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: HelperMethods.themeColor(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
