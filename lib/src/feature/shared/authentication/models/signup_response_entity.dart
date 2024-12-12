class SignupResponseEntity {
  String id;
  String otpId;

  SignupResponseEntity({
    required this.id,
    required this.otpId,
  });

  factory SignupResponseEntity.empty() =>
      SignupResponseEntity(id: "", otpId: "");

  factory SignupResponseEntity.fromJson(Map<String, dynamic> json) =>
      SignupResponseEntity(
        id: json["id"] ?? "",
        otpId: json["otp_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "otp_id": otpId,
      };
}
