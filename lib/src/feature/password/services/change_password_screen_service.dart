import '../gateways/password_change_gateway.dart';
import 'package:flutter/cupertino.dart';
import '../../../common/models/action_result.dart';
import '../../../common/utility/validator.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin ChangePasswordScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
  bool validateResetPasswordData(
      String currentPassword, String newPassword, String confirmPassword) {
    if (Validator.isEmpty(currentPassword)) {
      _view.showWarning("Enter your current password");
      return false;
    } else if (Validator.isEmpty(newPassword)) {
      _view.showWarning("Enter your new password");
      return false;
    } else if (Validator.isEmpty(confirmPassword)) {
      _view.showWarning("Enter confirm password");
      return false;
    } else if (newPassword != confirmPassword) {
      _view.showWarning("New password and confirm password do not match");
      return false;
    }
    return true;
  }

  Future<ActionResult<dynamic>> changePassword() async {

    return PasswordGateway.changePassword(currentPasswordController.text,
            newPasswordController.text, confirmPasswordController.text)
        .then((value) {
      if (value.status != Status.success) {
        _view.showWarning(value.message);
      } else {
        _view.showSuccess(value.message);
      }
      return value;
    });
  }
}
