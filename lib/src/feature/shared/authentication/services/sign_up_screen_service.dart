import 'package:flutter/material.dart';


abstract class _ViewModel {

  void showSuccess(String message);
  void showWarning(String message);
}

mixin UserAuthenticationService<T extends StatefulWidget> on State<T>
implements _ViewModel {
  late _ViewModel _view;
  bool isChecked = false;

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();

  }

  @override
  void dispose() {

    super.dispose();
  }



  //======================Public Methods======================

}
