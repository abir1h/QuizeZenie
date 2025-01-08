import 'package:flutter/cupertino.dart';



abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin ChangePasswordScreenService<T extends StatefulWidget> on State<T>
implements _ViewModel {
  late _ViewModel _view;

  TextEditingController currentPasswordController=TextEditingController();
  TextEditingController newPasswordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }


//====================Stream Controller=====================


  //======================Public Methods======================


}
