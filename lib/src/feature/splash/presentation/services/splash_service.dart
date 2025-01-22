import 'dart:async';
import 'package:flutter/material.dart';



abstract class _ViewModel {
  void navigateToOnBoardingScreen();
}

mixin SplashService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;
  StreamSubscription? _subscription;

  ///Service configurations
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchUserSession();
    });
    _view = this;
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///Fetch users from local database
  void _fetchUserSession() async {
    ///Delayed for 2 seconds
    await Future.delayed(const Duration(seconds: 2));
           _view.navigateToOnBoardingScreen();

    ///Navigate to logical page
    // App.getCurrentSession().then((session) async {
    //   if (session.tokens.accessToken.isEmpty) {
    //     ///Navigate to login screens
    //     App.getOnboardUser().then((value) {
    //       if (!value) {
    //         _view.navigateToOnBoardingScreen();
    //       } else {
    //         _view. // App.getCurrentSession().then((session) async {
    //     //   if (session.tokens.accessToken.isEmpty) {
    //     //     ///Navigate to login screens
    //     //     App.getOnboardUser().then((value) {
    //     //       if (!value) {
    //     //         _view.navigateToOnBoardingScreen();
    //     //       } else {
    //     //         _view.navigateToAuthenticationScreen();
    //     //       }
    //     //     });
    //     //   } else {
    //     //     ///Navigate to landing page
    //     //     _view.navigateToLandingScreen();
    //     //   }
    //     // });navigateToAuthenticationScreen();
    //       }
    //     });
    //   } else {
    //     ///Navigate to landing page
    //     _view.navigateToLandingScreen();
    //   }
    // });
  }


}
