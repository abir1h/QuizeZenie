class ProfileEntity {
  int id;
  String email;
  String firstName;
  String lastName;
  String userFullName;
  String designation;
  String schoolName;
  String state;
  String city;
  String country;
  String countryId;
  String stateId;
  String cityId;
  String phoneNumber;
  String profileUrl;
  String postalCode;
  String presentAddress;
  int totalBookmarks;
  int totalComments;
  int totalVideos;

  ProfileEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.userFullName,
    required this.designation,
    required this.schoolName,
    required this.state,
    required this.city,
    required this.country,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.phoneNumber,
    required this.profileUrl,
    required this.postalCode,
    required this.presentAddress,
    required this.totalBookmarks,
    required this.totalComments,
    required this.totalVideos,
  });
  factory ProfileEntity.empty() {
    return ProfileEntity(
        id: -1,
        email: "",
        firstName: "",
        lastName: "",
        userFullName: "",
        designation: "",
        schoolName: "",
        state: "",
        city: "",
        country: "",
        countryId: "",
        stateId: "",
        cityId: "",
        profileUrl: "",
        postalCode: "",
        presentAddress: "",
        phoneNumber: "",
        totalBookmarks: -1,
        totalComments: -1,
        totalVideos: -1);
  }
  factory ProfileEntity.fromJson(Map<String, dynamic> json) => ProfileEntity(
        id: json["id"] ?? -1,
        email: json["email"] ?? "",
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        userFullName: json["full_name"] ?? "",
        designation: json["designation"] ?? "",
        schoolName: json["school_name"] ?? "",
        state: json["state"] ?? "",
        city: json["city"] ?? "",
        country: json["country"] ?? "",
        countryId: json["country_id"] ?? "",
        stateId: json["state_id"] ?? "",
        cityId: json["city_id"] ?? "",
        phoneNumber: json["phone_number"] ?? "",
        profileUrl: json["profile_url"] ?? "",
        postalCode: json["postal_code"] ?? "",
        presentAddress: json["present_address"] ?? "",
        totalComments: json["total_comments"] ?? -1,
        totalVideos: json["total_videos"] ?? -1,
        totalBookmarks: json["total_bookmarks"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "user_full_name": userFullName,
        "designation": designation,
        "school_name": schoolName,
        "state": state,
        "city": city,
        "country": country,
        "country_id": countryId,
        "state_id": stateId,
        "city_id": cityId,
        "phone_number": phoneNumber,
        "profile_url": profileUrl,
        "postal_code": postalCode,
        "present_address": presentAddress,
      };
}
