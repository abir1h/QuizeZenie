import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../../../../common/constants/app_theme.dart';
import '../../../../common/constants/common_imports.dart';
import '../../../../common/routes/app_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with AppTheme, Language {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /*   Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                ImageAssets.icLogo,

                fit: BoxFit.cover,
                height: size.s64+size.s64,
              ),
            ),*/

            /*  Text(
              label(e: en.splashScreenText, b: bn.splashScreenText),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: clr.appPrimaryColorBlue,
                  fontSize: size.textXXSmall + size.textXXSmall,
                  fontWeight: FontWeight.w600,
                  fontFamily: StringData.fontFamilyPoppins),
            ),*/ /*Text(
              label(e: en.splashScreenText, b: bn.splashScreenText),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: clr.appPrimaryColorBlue,
                  fontSize: size.textXXSmall + size.textXXSmall,
                  fontWeight: FontWeight.w600,
                  fontFamily: StringData.fontFamilyPoppins),
            ),*/
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  WavyAnimatedText(
                    "Quiz Zenie",
                    textStyle: TextStyle(
                      color: clr.appPrimaryColor,
                      fontSize: size.text32Large,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        BoxShadow(
                          color: clr.blackColor,
                          blurRadius: size.s4,
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  @override
  void navigateToOnBoardingScreen() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoute.splashScreen, (x) => false);
  }
}
