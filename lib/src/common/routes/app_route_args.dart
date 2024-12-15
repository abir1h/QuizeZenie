import '../models/user_entity.dart';

class VerifyOtpScreenArgs {
  UserSession? authDataModel;
  VerifyOtpScreenArgs({this.authDataModel});
}


class VideoDetailsScreenArgs {
  String videoId;
  VideoDetailsScreenArgs({required this.videoId});
}
