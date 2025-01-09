import 'package:flutter/material.dart';

import '../../../common/routes/app_route_args.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin GiveFeedbackScoreService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  late GiveScoreScreenArgs screenArgs;

  @override
  void initState() {
    _view = this;
    super.initState();
  }
}
