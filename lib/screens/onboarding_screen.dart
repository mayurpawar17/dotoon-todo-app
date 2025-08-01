import 'package:dotoon_todo_app/screens/todoScreen.dart' show TodoScreen;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const TodoScreen()));
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: TextStyle(fontSize: 18, color: Colors.black),
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          key: introKey,
          globalBackgroundColor: Colors.white,
          allowImplicitScrolling: true,
          autoScrollDuration: 3000,
          infiniteAutoScroll: true,
          globalHeader: Align(
            alignment: Alignment.topRight,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, right: 16),
                child: Text('Flutter'),
              ),
            ),
          ),
          // globalFooter: SizedBox(
          //   width: double.infinity,
          //   height: 60,
          //   child: ElevatedButton(
          //     child: const Text(
          //       'Let\'s go right away!',
          //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          //     ),
          //     onPressed: () => _onIntroEnd(context),
          //   ),
          // ),
          pages: [
            PageViewModel(
              title: "Fractional shares",
              body:
                  "Instead of having to buy an entire share, invest any amount you want.",
              image: Container(
                margin: EdgeInsets.symmetric(vertical: 50),
                child: SvgPicture.asset('assets/slide_1.svg'),
              ),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Learn as you go",
              body:
                  "Download the Stockpile app and master the market with our mini-lesson.",
              image: Container(
                margin: EdgeInsets.symmetric(vertical: 50),
                child: SvgPicture.asset('assets/slide_1.svg'),
              ),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Kids and teens",
              body:
                  "Kids and teens can track their stocks 24/7 and place trades that you approve.",
              image: Container(
                margin: EdgeInsets.symmetric(vertical: 50),
                child: SvgPicture.asset('assets/slide_1.svg'),
              ),
              decoration: pageDecoration,
            ),
          ],
          onDone: () => _onIntroEnd(context),
          onSkip: () => _onIntroEnd(context),
          showSkipButton: true,
          back: const Icon(Icons.arrow_back),
          skip: const Text(
            'Skip',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          next: const Icon(Icons.arrow_forward),
          done: const Text(
            'Done',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin: const EdgeInsets.all(10),
          controlsPadding:
              kIsWeb
                  ? const EdgeInsets.all(12.0)
                  : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: Color(0xFFBDBDBD),
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
          dotsContainerDecorator: const ShapeDecoration(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
      ),
    );
  }
}
