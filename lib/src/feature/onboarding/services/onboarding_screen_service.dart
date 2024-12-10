import 'package:flutter/cupertino.dart';

import '../../../common/config/app.dart';
import '../../../common/constants/app_theme.dart';

abstract class _ViewModel {
  void onPageChanged(int index);
  void navigateToAuthentication();
}

mixin OnBoardingScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;
  final PageController controller = PageController();
  final List<Color> backgroundColors = [
    ThemeColor.instance.onBoardBgColor1,
    ThemeColor.instance.onBoardBgColor2,
    ThemeColor.instance.onBoardBgColor3
  ];

  int currentPage = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  onBoardUser() {
    App.setOnboardUser();
    _view.navigateToAuthentication();
  }

  //====================Stream Controller=====================
}
