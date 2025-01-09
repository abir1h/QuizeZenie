import '../../../../common/constants/common_imports.dart';
import '../../../../common/models/action_result.dart';
import '../../../../common/models/user_entity.dart';
import '../../../../common/network/api_service.dart';

mixin UserAuthenticationGateway {
  ///Login
  static Future<ActionResult<UserSession>> loginWithPhoneOrEmailAction(
      String phoneOrEmail, String password) async {
    return Server.instance.postRequest(
      url: ApiCredential.loginWithMobile,
      postData: {"email": phoneOrEmail, "password": password},
    ).then((value) {
      return ActionResult<UserSession>.fromServerResponse(
        response: value,
        generateData: (x) => UserSession.fromJson(x),
      );
    }).catchError((e) {
      return ActionResult<UserSession>.error();
    });
  }

  ///Registration
  static Future<ActionResult<UserSession>> registerUserAction(
      String username, String email, String password) async {
    return Server.instance.postRequest(
      url: ApiCredential.registerUser,
      postData: {
        "user_name": username,
        "email": email,

        ///Todo
        "phone_number": "null",
        "password": password,
      },
    ).then((value) {
      return ActionResult<UserSession>.fromServerResponse(
        response: value,
        generateData: (x) => UserSession.fromJson(x),
      );
    }).catchError((e) {
      return ActionResult<UserSession>.error();
    });
  }

  ///OTP Verification
  static Future<ActionResult<UserSession>> verifyOTPAction(
      String userId, String otpId, String otp) async {
    return Server.instance.postRequest(
      url: ApiCredential.verifyOTP,
      postData: {"user_id": userId, "otp_id": otpId, "otp_code": otp},
    ).then((value) {
      return ActionResult<UserSession>.fromServerResponse(
        response: value,
        generateData: (x) => UserSession.fromJson(x),
      );
    }).catchError((e) {
      return ActionResult<UserSession>.error();
    });
  }

  static Future<ActionResult<UserSession>> verifyPasswordAction(
      String id, String password, String device, String phoneName) async {
    return Server.instance.postRequest(
      url: ApiCredential.verifyPassword,
      postData: {
        "id": id,
        "password": password,
        "device": device,
        "phone_name": phoneName
      },
    ).then((value) {
      return ActionResult<UserSession>.fromServerResponse(
        response: value,
        generateData: (x) => UserSession.fromJson(x),
      );
    }).catchError((e) {
      return ActionResult<UserSession>.error();
    });
  }

  static Future<ActionResult<UserSession>> forgotPasswordAction(
      String phoneOrEmail) async {
    return Server.instance.postRequest(
      url: ApiCredential.forgotPassword,
      postData:{
        "email": phoneOrEmail
      },
    ).then((value) {
      return ActionResult<UserSession>.fromServerResponse(
        response: value,
        generateData: (x) => UserSession.fromJson(x),
      );
    }).catchError((e) {
      return ActionResult<UserSession>.error();
    });
  }

  static Future<ActionResult<UserSession>> resetPasswordAction(String userId,
      String otpId, String newPassword,String confirmPassword,) async {
    return Server.instance.postRequest(
      url: ApiCredential.resetPassword,
      postData: {
        "user_id": userId,
        "otp_id": otpId,
        "new_password": newPassword,
        "confirm_password": confirmPassword
      },
    ).then((value) {
      return ActionResult<UserSession>.fromServerResponse(
        response: value,
        generateData: (x) => UserSession.fromJson(x),
      );
    }).catchError((e) {
      return ActionResult<UserSession>.error();
    });
  }
}
