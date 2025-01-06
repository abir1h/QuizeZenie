import 'package:co_learning_mobile_app/src/feature/profile/models/profile_entity.dart';

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

class AccountDetailsScreenArgs {
  ProfileEntity profileData;
  final void Function() onAddLiveClass;

  AccountDetailsScreenArgs({required this.profileData ,required this.onAddLiveClass});
}
