import '../models/user_entity.dart';

class VerifyOtpScreenArgs {
  UserSession? authDataModel;
  VerifyOtpScreenArgs({this.authDataModel});
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
