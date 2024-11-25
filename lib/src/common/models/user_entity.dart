
class UserSession {
  final int id;
  final String name;
  final String email;
  final String username;
  final String contactNo;
  final int organizationId;
  final String address;
  final String image;
  final String token;

  UserSession(
      {required this.id,
      required this.name,
      required this.email,
      required this.username,
      required this.contactNo,
      required this.organizationId,
      required this.address,
      required this.token,
      required this.image});

  factory UserSession.empty() => UserSession(
      id: -1,
      name: "",
      email: "",
      username: "",
      contactNo: "",
      organizationId: -1,
      address: "",
      token: "",
      image: "");

  factory UserSession.fromJson(Map<String, dynamic> json) => UserSession(
      id: json["id"] ?? -1,
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      username: json["username"] ?? "",
      contactNo: json["contact_no"] ?? "",
      organizationId: json["organization_id"] ?? -1,
      address: json["address"] ?? "",
      token: json["token"] ?? "",
      image: json["image"] ?? "");

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "username": username,
        "contact_no": contactNo,
        "organization_id": organizationId,
        "address": address,
        "token": token,
        "image":image
      };

  bool get isEmpty => token.isEmpty;
}
