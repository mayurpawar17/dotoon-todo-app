import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DotoonLogo extends StatelessWidget {
  const DotoonLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset('assets/dotoonLogoBlack.svg', height: 50),
        const Text(
          'Dotoon',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
        ),
      ],
    );
  }
}
