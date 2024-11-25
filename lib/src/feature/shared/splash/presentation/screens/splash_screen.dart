import 'package:flutter/material.dart';
import '../../../../../common/constants/common_imports.dart';
import '../../../../../common/routes/app_route.dart';
import '../../../../../common/widgets/custom_toasty.dart';
import '../services/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with AppTheme, Language, SplashService {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

          /*  Text(
              label(e: en.splashScreenText, b: bn.splashScreenText),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: clr.appPrimaryColorBlue,
                  fontSize: size.textXXSmall + size.textXXSmall,
                  fontWeight: FontWeight.w600,
                  fontFamily: StringData.fontFamilyPoppins),
            ),*//*Text(
              label(e: en.splashScreenText, b: bn.splashScreenText),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: clr.appPrimaryColorBlue,
                  fontSize: size.textXXSmall + size.textXXSmall,
                  fontWeight: FontWeight.w600,
                  fontFamily: StringData.fontFamilyPoppins),
            ),*/
          ],
        ),
      ),
    );
  }

  @override
  void navigateToLandingScreen() {
    /*Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoute.landingScreen, (x) => false);*/
  }

  @override
  void navigateToMentorLandingScreen() {
    /*Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoute.mentorLandingScreen, (x) => false);*/
  }

  @override
  void navigateToAuthenticationScreen() {
   /* Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoute.userAuthenticationScreen, (x) => false);*/
  }

  @override
  void showWarning(String message) {
    Toasty.of(context).showWarning(message);
  }

}
