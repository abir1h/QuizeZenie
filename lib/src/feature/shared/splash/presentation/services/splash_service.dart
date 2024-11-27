import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../common/config/app.dart';
import '../../../../../common/network/api_service.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void navigateToOnBoardingScreen();
  void navigateToLandingScreen();
  void navigateToAuthenticationScreen();
}

mixin SplashService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;
  StreamSubscription? _subscription;

  ///Service configurations
  @override
  void initState() {
    super.initState();
    _subscription =
        Server.instance.onUnauthorizedRequest.listen(_onUnauthorizedRequest);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchUserSession();
    });
    _view = this;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  ///Fetch users from local database
  void _fetchUserSession() async {
    ///Delayed for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    ///Navigate to logical page
    App.getCurrentSession().then((session) async {
      _view.navigateToLandingScreen();
     /* if (session.userType != UserType.Mentor) {
        _view.navigateToLandingScreen();
      } else {
        _view.navigateToMentorLandingScreen();
      }*/
      // if(session.isEmpty){
      //   ///Navigate to login screens
      //   _view.navigateToAuthenticationScreen();
      // }else{
      //   ///Navigate to landing page
      //   _view.navigateToLandingScreen();
      // }
    });
  }

  void _onUnauthorizedRequest(String message) async {
    if (!App.currentSession.isEmpty && mounted) {
      _view.showWarning(message);
      App.logOut().whenComplete(() {
        _view.navigateToAuthenticationScreen();
      });
    }
  }
}
