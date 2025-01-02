class UploadedBy {
  String id;
  String email;
  String firstName;
  String lastName;
  bool isVerified;
  String userRole;

  UploadedBy({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.isVerified,
    required this.userRole,
  });
  factory UploadedBy.empty() => UploadedBy(
      id: "",
      email: "",
      firstName: "",
      lastName: "",
      isVerified: false,
      userRole: "");

  factory UploadedBy.fromJson(Map<String, dynamic> json) => UploadedBy(
    id: json["id"] ?? "",
    email: json["email"] ?? "",
    firstName: json["first_name"] ?? "",
    lastName: json["last_name"] ?? "",
    isVerified: json["is_verified"] ?? false,
    userRole: json["user_role"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "is_verified": isVerified,
    "user_role": userRole,
  };
}


