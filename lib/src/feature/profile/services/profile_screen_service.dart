import 'package:co_learning_mobile_app/src/common/config/app.dart';
import 'package:co_learning_mobile_app/src/common/models/user_entity.dart';
import 'package:co_learning_mobile_app/src/common/routes/app_route_args.dart';
import 'package:co_learning_mobile_app/src/feature/profile/gateway/profile_gateway.dart';
import 'package:flutter/cupertino.dart';

import '../../../common/config/local_storage_services.dart';
import '../../../common/constants/app_constant.dart';
import '../../../common/constants/common_imports.dart';
import '../../../common/models/action_result.dart';
import '../../../common/service/notifier/app_events_notifier.dart';
import '../../../common/widgets/app_stream.dart';
import '../../video/services/video_upload_info_screen_service.dart';
import '../models/profile_entity.dart';


abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin ProfileScreenService<T extends StatefulWidget> on State<T>
implements _ViewModel {
  late _ViewModel _view;
  TextEditingController fullNameController=TextEditingController();
  TextEditingController designationController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController postalCodeController=TextEditingController();
  TextEditingController permanentAddressController=TextEditingController();
  TextEditingController currentPasswordController=TextEditingController();
  TextEditingController newPasswordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();

  AccountDetailsScreenArgs? screenArgs;

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
  Future<List<FeedBack?>> loadFeedBack() async {
    return [
      FeedBack(id: 1, title: 'Test 1'),
      FeedBack(id: 2, title: 'Test 2'),
      FeedBack(id: 5, title: 'Test 5'),
    ];
  }


//====================Stream Controller=====================
  final AppStreamController<ProfileEntity> profileStreamController =
  AppStreamController();

  //======================Public Methods======================

  Future<void> loadInitialData() async {
    ///Loading state
    if (!mounted) return;
    profileStreamController.add(LoadingState());
    ProfileGateway.getProfileData().then((value) {
      ///Data loaded state
      if (value.status == Status.success && value.data != null) {
        profileStreamController.add(DataLoadedState(value.data!));
      }

      ///Empty state
      else {
        //_view.showWarning(value.message);

        Future.delayed(Duration(seconds: AppConstant.reloadInSeconds))
            .then((value) {
          if (mounted) loadInitialData();
        });
      }
    });
  }

  void loadTextField(AccountDetailsScreenArgs args) {
    fullNameController = TextEditingController(text: args.profileData.userFullName);
    emailController = TextEditingController(text: args.profileData.email);
    phoneController = TextEditingController(text: args.profileData.phoneNumber);
    postalCodeController = TextEditingController(text: args.profileData.postalCode);
    designationController = TextEditingController(text: args.profileData.designation);
    permanentAddressController = TextEditingController(text: args.profileData.presentAddress);
    AppEventsNotifier.notify(EventAction.profileScreen);
    // permanentAddressController = TextEditingController(text: args.profileData.);


  }

  void addIfNotEmpty(Map<String, dynamic> map, String key, String value) {
    if (value.isNotEmpty) {
      map[key] = value;
    }
  }

  Future<ActionResult<dynamic>> updateProfile() async {

    Map<String, dynamic> data = {};

    addIfNotEmpty(data, "name", fullNameController.text);
    addIfNotEmpty(data, "email", emailController.text);
    addIfNotEmpty(data, "contact_no", phoneController.text);
    addIfNotEmpty(data, "present_address", permanentAddressController.text);
    addIfNotEmpty(data, "postal_code", postalCodeController.text);
    addIfNotEmpty(data, "designation", designationController.text);


    /*if (selectedGender.isNotEmpty && selectedGender.isNotEmpty) {
      data["gender"] = selectedGender;
    }*/

   /* addIfNotEmpty(data, "blood_group", bloodController.text);
    addIfNotEmpty(data, "bio", bioController.text);*/

    return ProfileGateway.updateProfile(data,screenArgs!.profileData.id).then((value) {
      if (value.status == Status.success && value.data != null) {
        _view.showSuccess(value.message);

        return value;

      } else {
        _view.showWarning(value.message);
        return value;
      }
    }).catchError((e) {});
  }


}
