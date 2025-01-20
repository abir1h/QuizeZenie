import 'dart:io';

import '../models/location_entity.dart';
import '../models/profile_entity.dart';
import '../../../common/constants/common_imports.dart';
import '../../../common/models/action_result.dart';
import '../../../common/network/api_service.dart';
import '../models/school_entity.dart';

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
      Map<String, dynamic> data) async {
    return Server.instance
        .postRequest(url: ApiCredential.updateProfile, postData: data)
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
        file: file,
        field: "profile_url",
        onComplete: (response) {
          onComplete.call(ActionResult<ProfileEntity>.fromServerResponse(
            response: response,
            generateData: (x) => ProfileEntity.fromJson(x),
          ));
        });
  }

  static Future<ActionResult<List<SchoolEntity>>> getSchoolList() async {
    return Server.instance
        .getRequest(
      url: ApiCredential.schoolList,
    )
        .then((value) {
      return ActionResult<List<SchoolEntity>>.fromServerResponse(
        response: value,
        generateData: (x) => SchoolEntity.listFromJson(x),
      );
    }).catchError((e) {
      return ActionResult<List<SchoolEntity>>.error();
    });
  }

  static Future<ActionResult<List<LocationEntity>>> getCountryList() async {
    return Server.instance
        .getRequest(
      url: ApiCredential.countryList,
    )
        .then((value) {
      return ActionResult<List<LocationEntity>>.fromServerResponse(
        response: value,
        generateData: (x) => LocationEntity.listFromJson(x),
      );
    }).catchError((e) {
      return ActionResult<List<LocationEntity>>.error();
    });
  }

  static Future<ActionResult<List<LocationEntity>>> getStateList(
      String countryId) async {
    return Server.instance
        .getRequest(
      url: "${ApiCredential.stateList}/$countryId/",
    )
        .then((value) {
      return ActionResult<List<LocationEntity>>.fromServerResponse(
        response: value,
        generateData: (x) => LocationEntity.listFromJson(x),
      );
    }).catchError((e) {
      return ActionResult<List<LocationEntity>>.error();
    });
  }

  static Future<ActionResult<List<LocationEntity>>> getCityList(
      String stateId) async {
    return Server.instance
        .getRequest(
      url: "${ApiCredential.cityList}/$stateId/",
    )
        .then((value) {
      return ActionResult<List<LocationEntity>>.fromServerResponse(
        response: value,
        generateData: (x) => LocationEntity.listFromJson(x),
      );
    }).catchError((e) {
      return ActionResult<List<LocationEntity>>.error();
    });
  }
}
