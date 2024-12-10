import '../../../../common/constants/common_imports.dart';
import '../../../../common/models/action_result.dart';
import '../../../../common/models/user_entity.dart';
import '../../../../common/network/api_service.dart';
import '../models/auth_entity.dart';

mixin UserAuthenticationGateway {
  static Future<ActionResult<AuthDataModel>> loginWithPhoneOrEmailAction(
      String phoneOrEmail) async {
    return Server.instance.postRequest(
      url: ApiCredential.loginWithMobile,
      postData: {"organization_id": 1, "phone_or_email": phoneOrEmail},
    ).then((value) {
      return ActionResult<AuthDataModel>.fromServerResponse(
        response: value,
        generateData: (x) => AuthDataModel.fromJson(x),
      );
    }).catchError((e) {
      return ActionResult<AuthDataModel>.error();
    });
  }

  static Future<ActionResult<AuthDataModel>> verifyOTPAction(
      String otpId, String otp) async {
    return Server.instance.postRequest(
      url: ApiCredential.verifyOTP,
      postData: {"otp_id": otpId, "otp": otp},
    ).then((value) {
      return ActionResult<AuthDataModel>.fromServerResponse(
        response: value,
        generateData: (x) => AuthDataModel.fromJson(x),
      );
    }).catchError((e) {
      return ActionResult<AuthDataModel>.error();
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

  static Future<ActionResult<UserSession>> registerUserAction(
      String otpId,
      String name,
      String userType,
      String password,
      String device,
      String phoneName) async {
    return Server.instance.postRequest(
      url: ApiCredential.registerUser,
      postData: {
        "otp_id": otpId,
        "name": name,
        "user_type": userType,
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

  static Future<ActionResult<AuthDataModel>> forgotPasswordAction(
      String phoneOrEmail) async {
    return Server.instance.postRequest(
      url: ApiCredential.forgotPassword,
      postData: {"organization_id": 1, "phone_or_email": phoneOrEmail},
    ).then((value) {
      return ActionResult<AuthDataModel>.fromServerResponse(
        response: value,
        generateData: (x) => AuthDataModel.fromJson(x),
      );
    }).catchError((e) {
      return ActionResult<AuthDataModel>.error();
    });
  }

  static Future<ActionResult<UserSession>> resetPasswordAction(
      int otpId, String password) async {
    return Server.instance.postRequest(
      url: ApiCredential.resetPassword,
      postData: {"otp_id": otpId, "password": password},
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
