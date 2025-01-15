import 'dart:ui';

import '../../feature/bookmark/models/feedback.dart';
import '../../feature/bookmark/models/form_category.dart';
import '../../feature/profile/models/profile_entity.dart';
import '../models/user_entity.dart';

class VerifyOtpScreenArgs {
  UserSession? authDataModel;
  bool? isForgotPassword;
  VerifyOtpScreenArgs({this.authDataModel, this.isForgotPassword});
}

class ResetPasswordScreenArgs {
  UserSession? authDataModel;
  ResetPasswordScreenArgs({this.authDataModel});
}

class CategoryWiseVideoListScreenArgs {
  String categoryId, categoryName;
  CategoryWiseVideoListScreenArgs(
      {required this.categoryId, required this.categoryName});
}

class VideoDetailsScreenArgs {
  String videoId;
  VideoDetailsScreenArgs({required this.videoId});
}

class AccountDetailsScreenArgs {
  ProfileEntity profileData;
  final void Function() onAddLiveClass;

  AccountDetailsScreenArgs(
      {required this.profileData, required this.onAddLiveClass});
}

class GiveScoreScreenArgs {
  String videoId;
  FeedbackEntity feedback;
  VoidCallback onSuccess;
  GiveScoreScreenArgs(
      {required this.videoId, required this.feedback, required this.onSuccess});
}

class FeedbackScoreArgs {
  String videoId;
  String? scoreId;
  FeedbackScoreArgs({required this.videoId, this.scoreId});
}
