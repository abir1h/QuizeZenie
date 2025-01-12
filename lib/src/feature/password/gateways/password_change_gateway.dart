import '../../../common/constants/common_imports.dart';
import '../../../common/models/action_result.dart';
import '../../../common/models/user_entity.dart';
import '../../../common/network/api_service.dart';

mixin PasswordGateway {

  static Future<ActionResult<UserSession>> changePassword(
      String currentPassword, String newPassword, String confirmPassword, ) async {
    return Server.instance.postRequest(
      url: ApiCredential.changePassword,
      postData:{
        "current_password": currentPassword,
        "new_password":newPassword,
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
