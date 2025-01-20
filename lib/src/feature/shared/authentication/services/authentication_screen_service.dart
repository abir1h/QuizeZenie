import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../common/config/app.dart';
import '../../../../common/models/action_result.dart';
import '../../../../common/models/user_entity.dart';
import '../../../../common/routes/app_route.dart';
import '../../../../common/routes/app_route_args.dart';
import '../../../../common/utility/validator.dart';
import '../gateways/authentication_gateway.dart';

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

  VerifyOtpScreenArgs? verifyOtpScreenArgs;
  ResetPasswordScreenArgs? resetPasswordScreenArgs;

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

  bool validateRegisterData(
      String username, String email, String password, bool checkTermCondition) {
    if (Validator.isEmpty(username)) {
      _view.showWarning("Name is required!");
      return false;
    } else if (Validator.isEmpty(email)) {
      _view.showWarning("Email is required!");
      return false;
    } else if (Validator.isEmpty(password)) {
      _view.showWarning("Password is required!");
      return false;
    } else if (password.length < 8) {
      _view.showWarning("Password must be at least 8 characters long!");
      return false;
    } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
      _view.showWarning("Password must contain at least one uppercase letter!");
      return false;
    } else if (!RegExp(r'[0-9]').hasMatch(password)) {
      _view.showWarning("Password must contain at least one number!");
      return false;
    } else if (!checkTermCondition) {
      _view.showWarning("Select terms & conditions, privacy policy!");
      return false;
    } else {
      return true;
    }
  }

  bool validateLoginData(String email, String password) {
    if (Validator.isEmpty(email)) {
      _view.showWarning("Email is required!");
      return false;
    } else if (Validator.isEmpty(password)) {
      _view.showWarning("Password is required!");
      return false;
    } else {
      return true;
    }
  }

  void startTimer() {
    final DateTime targetTime = DateTime.now().add(const Duration(minutes: 1));

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

  Future<ActionResult<UserSession>> registerUser(
      String username, String email, String password) async {
    return UserAuthenticationGateway.registerUserAction(
            username, email, password)
        .then((value) {
      if (value.status != Status.success) {
        _view.showWarning(value.message);
      }
      return value;
    });
  }

  Future<ActionResult<UserSession>> loginWithPhoneOrEmail(
      String email, String password) async {
    return UserAuthenticationGateway.loginWithPhoneOrEmailAction(
            email, password)
        .then((value) {
      if (value.status != Status.success) {
        _view.showWarning(value.message);
      } else {
        _view.showSuccess(value.message);
      }
      return value;
    });
  }

  void onLoginSuccess(UserSession data) {
    if (data.user.isVerified) {
      App.setCurrentSession(data).then((value) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRoute.landingScreen, (x) => false);
      });
    } else {
      Navigator.of(context).pushNamed(AppRoute.verifyOtpScreen,
          arguments: VerifyOtpScreenArgs(authDataModel: data));
    }
  }

  bool validateOTPData(String otp) {
    if (Validator.isEmpty(otp)) {
      _view.showWarning("Please Enter OTP First");
      return false;
    } else {
      return true;
    }
  }

  Future<ActionResult<UserSession>> verifyOTP(
      String userId, String otpId, String otp) async {
    return UserAuthenticationGateway.verifyOTPAction(userId, otpId, otp)
        .then((value) {
      if (value.status != Status.success) {
        _view.showWarning(value.message);
      }
      return value;
    });
  }

  Future<ActionResult<UserSession>> resendOTP(
      String email, String otpType) async {
    return UserAuthenticationGateway.resendOTPAction(email, otpType)
        .then((value) {
      if (value.status != Status.success) {
        _view.showWarning(value.message);
      } else {
        _view.showSuccess(value.message);
        setState(() {
          isResendButtonDisabled = !isResendButtonDisabled;
          startTimer();
        });
      }
      return value;
    });
  }

  Future<ActionResult<UserSession>> forgotPasswordRequest() async {
    return UserAuthenticationGateway.forgotPasswordAction(
            phoneOrEmailController.text)
        .then((value) {
      if (value.status != Status.success) {
        _view.showWarning(value.message);
      }
      return value;
    });
  }

  Future<ActionResult<UserSession>> resetPassword(String userId) async {
    return UserAuthenticationGateway.resetPasswordAction(
            userId,
            resetPasswordScreenArgs!.authDataModel!.user.otpId,
            passwordController.text.trim(),
            confirmPasswordController.text.trim())
        .then((value) {
      if (value.status != Status.success) {
        _view.showWarning(value.message);
      }
      return value;
    });
  }

  bool validateResetPasswordData(String newPassword, String confirmPassword) {
    if (Validator.isEmpty(newPassword)) {
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
}
