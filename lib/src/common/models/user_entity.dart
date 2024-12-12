// class UserSession {
//   final int id;
//   final String name;
//   final String email;
//   final String username;
//   final String contactNo;
//   final int organizationId;
//   final String address;
//   final String image;
//   final String token;
//   bool isOnboarded;
//
//   UserSession(
//       {required this.id,
//       required this.name,
//       required this.email,
//       required this.username,
//       required this.contactNo,
//       required this.organizationId,
//       required this.address,
//       required this.token,
//       required this.image,
//       this.isOnboarded = false});
//
//   factory UserSession.empty() => UserSession(
//       id: -1,
//       name: "",
//       email: "",
//       username: "",
//       contactNo: "",
//       organizationId: -1,
//       address: "",
//       token: "",
//       image: "",
//       isOnboarded: true);
//
//   factory UserSession.fromJson(Map<String, dynamic> json) => UserSession(
//         id: json["id"] ?? -1,
//         name: json["name"] ?? "",
//         email: json["email"] ?? "",
//         username: json["username"] ?? "",
//         contactNo: json["contact_no"] ?? "",
//         organizationId: json["organization_id"] ?? -1,
//         address: json["address"] ?? "",
//         token: json["token"] ?? "",
//         image: json["image"] ?? "",
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "username": username,
//         "contact_no": contactNo,
//         "organization_id": organizationId,
//         "address": address,
//         "token": token,
//         "image": image
//       };
//
//   bool get isEmpty => token.isEmpty;
// }

class UserSession {
  Tokens tokens;
  User user;

  UserSession({
    required this.tokens,
    required this.user,
  });

  factory UserSession.empty() =>
      UserSession(tokens: Tokens.empty(), user: User.empty());

  factory UserSession.fromJson(Map<String, dynamic> json) => UserSession(
        tokens: json["tokens"] != null
            ? Tokens.fromJson(json["tokens"])
            : Tokens.empty(),
        user: json["user"] != null ? User.fromJson(json["user"]) : User.empty(),
      );

  Map<String, dynamic> toJson() => {
        "tokens": tokens.toJson(),
        "user": user.toJson(),
      };
}

class Tokens {
  String accessToken;
  String refreshToken;
  String tokenType;
  int expiresIn;

  Tokens({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory Tokens.empty() =>
      Tokens(accessToken: "", refreshToken: "", tokenType: "", expiresIn: -1);

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        accessToken: json["access_token"] ?? "",
        refreshToken: json["refresh_token"] ?? "",
        tokenType: json["token_type"] ?? "",
        expiresIn: json["expires_in"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
      };
  bool get isEmpty => accessToken.isEmpty;
}

class User {
  String id;
  String email;
  String username;
  String phoneNumber;
  String firstName;
  String lastName;
  bool isVerified;
  String otpId;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.isVerified,
    required this.otpId,
  });

  factory User.empty() => User(
      id: "",
      email: "",
      username: "",
      phoneNumber: "",
      firstName: "",
      lastName: "",
      isVerified: false,
      otpId: "");

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? "",
        email: json["email"] ?? "",
        username: json["username"] ?? "",
        phoneNumber: json["phone_number"] ?? "",
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        isVerified: json["is_verified"] ?? false,
        otpId: json["otp_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "username": username,
        "phone_number": phoneNumber,
        "first_name": firstName,
        "last_name": lastName,
        "is_verified": isVerified,
        "otp_id": otpId,
      };
}
