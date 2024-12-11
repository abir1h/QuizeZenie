import 'package:flutter/material.dart';

import '../../feature/video/screens/video_record_screen.dart';
import '../../feature/video/screens/video_upload_info_screen.dart';
import '../../feature/onboarding/screens/onboarding_screen.dart';
import '../../feature/shared/authentication/screens/sign_up_screen.dart';
import '../../feature/shared/authentication/screens/signin_screen.dart';
import '../../feature/shared/splash/presentation/screens/splash_screen.dart';

class AppRoute {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static const String splashScreen = "splashScreen";
  static const String onboardingScreen = "onboardingScreen";
  static const String signInScreen = "signInScreen";
  static const String signUpScreen = "signUpScreen";
  static const String videoUploadInfoScreen = "videoUploadInfoScreen";
  static const String videoRecordScreen = "videoRecordScreen";
}

mixin RouteGenerator {
  static Route<dynamic> generate(RouteSettings setting) {
    return FadeInOutRouteBuilder(
      builder: (context) {
        switch (setting.name) {
          ///StartUp
          case AppRoute.splashScreen:
            return const SplashScreen();
          case AppRoute.onboardingScreen:
            return const OnboardingScreen();
          case AppRoute.signInScreen:
            return const SignInScreen();
          case AppRoute.signUpScreen:
            return const SignUpScreen();
          case AppRoute.videoUploadInfoScreen:
            return const VideoUploadInfoScreen();
          case AppRoute.videoRecordScreen:
            return VideoRecordScreen();

          default:
            return const SplashScreen();
        }
      },
    );
  }
}

///This defines the animation of routing one page to another
class FadeInOutRouteBuilder extends PageRouteBuilder {
  final WidgetBuilder builder;

  FadeInOutRouteBuilder({required this.builder})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return builder(context);
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return FadeTransition(
            opacity: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: const Interval(
                  0.50,
                  1.00,
                  curve: Curves.linear,
                ),
              ),
            ),
            child: child,
          );
        });
}
