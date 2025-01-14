import 'dart:io';

import 'package:co_learning_mobile_app/src/common/config/app.dart';
import 'package:co_learning_mobile_app/src/common/models/user_entity.dart';
import 'package:co_learning_mobile_app/src/common/routes/app_route_args.dart';
import 'package:co_learning_mobile_app/src/common/utility/app_label.dart';
import 'package:co_learning_mobile_app/src/feature/profile/gateway/profile_gateway.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/config/local_storage_services.dart';
import '../../../common/constants/app_constant.dart';
import '../../../common/constants/common_imports.dart';
import '../../../common/models/action_result.dart';
import '../../../common/routes/app_route.dart';
import '../../../common/service/notifier/app_events_notifier.dart';
import '../../../common/widgets/app_stream.dart';
import '../../../common/widgets/custom_dialog_widget.dart';
import '../../video/services/video_upload_info_screen_service.dart';
import '../models/profile_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
  void showBottomSheetForImagePicker();
  void showImageCropper(String path);
  void lockUI();
  void releaseUI();
}

mixin ProfileScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController permanentAddressController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
  final AppStreamController<String> profilePicStreamController =
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
        profilePicStreamController
            .add(DataLoadedState<String>(value.data!.profileUrl));
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
    fullNameController =
        TextEditingController(text: args.profileData.userFullName);
    emailController = TextEditingController(text: args.profileData.email);
    phoneController = TextEditingController(text: args.profileData.phoneNumber);
    postalCodeController =
        TextEditingController(text: args.profileData.postalCode);
    designationController =
        TextEditingController(text: args.profileData.designation);
    permanentAddressController =
        TextEditingController(text: args.profileData.presentAddress);
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

    addIfNotEmpty(data, "full_name", fullNameController.text);
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

    return ProfileGateway.updateProfile(data).then((value) {
      if (value.status == Status.success && value.data != null) {
        _view.showSuccess(value.message);

        return value;
      } else {
        _view.showWarning(value.message);
        return value;
      }
    }).catchError((e) {});
  }

/*  onUploadProfilePic(XFile? image) {
    ProfileGateway.uploadProfilePic(File(image!.path), (result) {
      if (!mounted) return;

      if (result.status == Status.success) {
        loadInitialData();
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        loadInitialData();

        // _view.showWarning(result.message);
      }
    });
  }*/
  void onShowBottomSheetForImagePicker() {
    if (mounted) {
      showBottomSheetForImagePicker();
    }
  }

  void onPickerOptionSelected(ImageSource imageSource) async {
    ImagePicker().pickImage(source: imageSource).then((image) {
      if (image != null) {
        _view.showImageCropper(image.path);
      }
    }).catchError((e) {
      _view.showWarning("Failed to pick image!");
    });
  }

  void onImageCropped(
    CroppedFile? image,
  ) {
    if (image == null) return;

    profilePicStreamController.add(LoadingState<String>());
    ProfileGateway.uploadProfilePic(File(image.path), (result) {
      if (!mounted) return;
      _view.releaseUI();

      if (result.status == Status.success) {
        _view.showSuccess(result.message);
        loadInitialData();

        App.setCurrentSession(
                App.currentSession..user.profileUrl = result.data!.profileUrl)
            .then((value) {
          profilePicStreamController
              .add(DataLoadedState<String>(value.user.profileUrl));

          Navigator.pop(context);
        });
      } else {
        _view.showWarning(result.message);
        _view.releaseUI();
      }
    });
  }

  void showLogoutPromptDialog() {
    CustomDialogWidget.show(
      context: context,
      title: label(e: "Do you want to Log out?", b: "តើអ្នកចង់ចេញពីគណនីទេ?"),
      infoText: label(
          e: "Your progress and data will be saved.",
          b: "វឌ្ឍនភាព និងទិន្នន័យរបស់អ្នកនឹងត្រូវបានរក្សាទុក។"),
      leftButtonText: label(e: "Cancel", b: "បោះបង់"),
      rightButtonText: label(e: "Logout", b: "ចេញ"),
    ).then((value) {
      if (value) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoute.signInScreen,
          (Route<dynamic> route) => false,
        );
      }
    });
  }
}
