import 'package:flutter/material.dart';

import '../../feature/profile/screens/profile_screen.dart';
import '../../feature/home/screens/home_screen.dart';
import '../../feature/landing/screens/landing_screen.dart';
import '../../feature/onboarding/screens/onboarding_screen.dart';
import '../../feature/video/screens/my_video_screen.dart';
import '../../feature/video/screens/video_details_screen.dart';
import '../../feature/video/screens/video_record_screen.dart';
import '../../feature/video/screens/video_upload_info_screen.dart';
import '../../feature/shared/authentication/screens/sign_up_screen.dart';
import '../../feature/shared/authentication/screens/signin_screen.dart';
import '../../feature/shared/splash/presentation/screens/splash_screen.dart';
import '../../feature/shared/authentication/screens/verify_otp_screen.dart';
import '../../feature/shared/authentication/screens/forgot_password_screen.dart';
import '../../feature/shared/authentication/screens/reset_password_screen.dart';
import '../../feature/profile/screens/account_details.dart';
import '../../feature/profile/screens/change_password_screen.dart';
import '../../feature/category_list/screens/category_wise_video_list.dart';

class AppRoute {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static const String splashScreen = "splashScreen";
  static const String onboardingScreen = "onboardingScreen";
  static const String landingScreen = "landingScreen";
  static const String homeScreen = "homeScreen";
  static const String signInScreen = "signInScreen";
  static const String signUpScreen = "signUpScreen";
  static const String videoUploadInfoScreen = "videoUploadInfoScreen";
  static const String videoRecordScreen = "videoRecordScreen";
  static const String forgotPasswordScreen = "forgotPasswordScreen";
  static const String verifyOtpScreen = "verifyOtpScreen";
  static const String resetPasswordScreen = "resetPasswordScreen";
  static const String profileScreen = "profileScreen";
  static const String accountDetailsScreen = "accountDetailsScreen";
  static const String changePasswordScreen = "changePasswordScreen";
  static const String myVideoScreen = "myVideoScreen";
  static const String videoDetailsScreen = "videoDetailsScreen";
  static const String categoryWiseVideoListScreen =
      "categoryWiseVideoListScreen";
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
          case AppRoute.landingScreen:
            return LandingScreen();
          case AppRoute.homeScreen:
            return const HomeScreen();
          case AppRoute.signInScreen:
            return const SignInScreen();
          case AppRoute.signUpScreen:
            return const SignUpScreen();
          case AppRoute.videoUploadInfoScreen:
            return const VideoUploadInfoScreen();
          case AppRoute.videoRecordScreen:
            return const VideoRecordScreen();
          case AppRoute.forgotPasswordScreen:
            return const ForgotPasswordScreen();
          case AppRoute.verifyOtpScreen:
            return VerifyOtpScreen(arguments: setting.arguments);
          case AppRoute.resetPasswordScreen:
            return const ResetPasswordScreen();
          case AppRoute.profileScreen:
            return const ProfileScreen();
          case AppRoute.accountDetailsScreen:
            return AccountDetailsScreen(arguments: setting.arguments);
          case AppRoute.changePasswordScreen:
            return const ChangePasswordScreen();
          case AppRoute.categoryWiseVideoListScreen:
            return CategoryWiseVideoListScreen(arguments: setting.arguments);
          case AppRoute.myVideoScreen:
            return const MyVideoScreen();
          case AppRoute.videoDetailsScreen:
            return  VideoDetailsScreen(arguments: setting.arguments);

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
