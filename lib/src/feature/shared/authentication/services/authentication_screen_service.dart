import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../common/utility/validator.dart';


abstract class _ViewModel {

  void showSuccess(String message);
  void showWarning(String message);
}

mixin UserAuthenticationService<T extends StatefulWidget> on State<T>
implements _ViewModel {
  late _ViewModel _view;
  bool isChecked = false;
  Timer? _timer;
  Duration remainingTime = const Duration();

  bool isResendButtonDisabled = true;
  bool isVerifyButtonEnabled = false;
  final formKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType>? errorController;
  TextEditingController phoneOrEmailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();

  }

  @override
  void dispose() {
    phoneOrEmailController.dispose();
    otpController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _timer?.cancel();

    super.dispose();
  }



  //======================Public Methods======================
  bool validateLoginWithPhoneOrEmailData(String phoneOrEmail) {
    if (Validator.isEmpty(phoneOrEmail)) {
      _view.showWarning("Enter your phone or email");
      return false;
    } else {
      if (phoneOrEmail.contains("@") && !Validator.isValidEmail(phoneOrEmail)) {
        _view.showWarning("Enter valid email");
        return false;
      } else if (!phoneOrEmail.contains("@") &&
          !Validator.validateBDMobileNumber(phoneOrEmail)) {
        _view.showWarning("Enter valid phone number");
        return false;
      } else {
        return true;
      }
    }
  }

  void startTimer() {
    final DateTime targetTime = DateTime.now().add(const Duration(minutes: 5));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          remainingTime = targetTime.difference(DateTime.now());

          if (remainingTime.isNegative) {
            _timer?.cancel();
            remainingTime = const Duration(seconds: 0);
            isResendButtonDisabled = !isResendButtonDisabled;
          }
        });
      }
    });
  }

}
