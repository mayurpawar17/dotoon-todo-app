import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/helper_method.dart';

class DotoonLogo extends StatelessWidget {
  const DotoonLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        isDark
            ? SvgPicture.asset('assets/dotoonLogoWhite.svg', height: 50)
            : SvgPicture.asset('assets/dotoonLogoBlack.svg', height: 50),
        Text(
          'Dotoon',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 26,
            color: HelperMethods.firstWhiteColor(context),
          ),
        ),
      ],
    );
  }
}
