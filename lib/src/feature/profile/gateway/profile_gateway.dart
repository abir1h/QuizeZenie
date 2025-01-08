import 'dart:io';

import '../models/profile_entity.dart';
import '../../../common/constants/common_imports.dart';
import '../../../common/models/action_result.dart';
import '../../../common/network/api_service.dart';

mixin ProfileGateway {
  static Future<ActionResult<ProfileEntity>> getProfileData() async {
    return Server.instance
        .getRequest(
      url: ApiCredential.userProfile,
    )
        .then((value) {
      return ActionResult<ProfileEntity>.fromServerResponse(
        response: value,
        generateData: (x) => ProfileEntity.fromJson(x),
      );
    }).catchError((e) {
      return ActionResult<ProfileEntity>.error();
    });
  }

  static Future<ActionResult<ProfileEntity>> updateProfile(
      Map<String, dynamic> data, int userId) async {
    return Server.instance
        .patchRequest(
      url: "${ApiCredential.updateProfile}$userId/",
      patchData: data,
    )
        .then((value) {
      return ActionResult<ProfileEntity>.fromServerResponse(
        response: value,
        generateData: (x) => ProfileEntity.fromJson(x),
      );
    }).catchError((e) {
      return ActionResult<ProfileEntity>.error();
    });
  }

  static void uploadProfilePic(
      File file, void Function(ActionResult<ProfileEntity>) onComplete) async {
    Server.instance.uploadFile(
        url: ApiCredential.updateProfile,
        file: file,field: "profile_url",
        onComplete: (response) {
          onComplete.call(ActionResult<ProfileEntity>.fromServerResponse(
            response: response,
            generateData: (x) => ProfileEntity.fromJson(x),
          ));
        });
  }
}
