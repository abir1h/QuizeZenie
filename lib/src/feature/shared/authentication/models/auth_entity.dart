class AuthDataModel {
  final bool isUser;
  final int otpId;
  final int userId;
  final String expiredAt;

  AuthDataModel({
    required this.isUser,
    required this.otpId,
    required this.userId,
    required this.expiredAt,
  });

  factory AuthDataModel.fromJson(Map<String, dynamic> json) => AuthDataModel(
    isUser: json["is_user"] ?? false,
    otpId: json["otp_id"] ?? -1,
    userId: json["user_id"] ?? -1,
    expiredAt: json["expired_at"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "is_user": isUser,
    "otp_id": otpId,
    "user_id": userId,
    "expired_at": expiredAt,
  };
}
