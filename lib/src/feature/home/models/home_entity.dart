class HomeEntity {
  int totalVideos;
  int totalChapters;
  int totalSchools;
  List<Category> categories;

  HomeEntity({
    required this.totalVideos,
    required this.totalChapters,
    required this.totalSchools,
    required this.categories,
  });

  factory HomeEntity.empty() => HomeEntity(
      totalVideos: 0, totalChapters: 0, totalSchools: 0, categories: []);

  factory HomeEntity.fromJson(Map<String, dynamic> json) => HomeEntity(
        totalVideos: json["total_videos"] ?? 0,
        totalChapters: json["total_chapters"] ?? 0,
        totalSchools: json["total_schools"] ?? 0,
        categories: json["categories"] != null
            ? List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "total_videos": totalVideos,
        "total_chapters": totalChapters,
        "total_schools": totalSchools,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  String id;
  String name;
  List<Video> videos;

  Category({
    required this.id,
    required this.name,
    required this.videos,
  });

  factory Category.empty() => Category(id: "", name: "", videos: []);

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        videos: json["videos"] != null
            ? List<Video>.from(json["videos"].map((x) => Video.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
      };
}

class Video {
  String id;
  String title;
  String videoUrl;
  String thumbnailUrl;
  UploadedBy uploadedBy;

  Video({
    required this.id,
    required this.title,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.uploadedBy,
  });

  factory Video.empty() => Video(
      id: "",
      title: "",
      videoUrl: "",
      thumbnailUrl: "",
      uploadedBy: UploadedBy.empty());

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        videoUrl: json["video_url"] ?? "",
        thumbnailUrl: json["thumbnail_url"] ?? "",
        uploadedBy: json["uploaded_by"] != null
            ? UploadedBy.fromJson(json["uploaded_by"])
            : UploadedBy.empty(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "video_url": videoUrl,
        "thumbnail_url": thumbnailUrl,
        "uploaded_by": uploadedBy.toJson(),
      };
}

class UploadedBy {
  String id;
  String email;
  String firstName;
  String lastName;
  String fullName;
  String profileUrl;
  bool isVerified;

  UploadedBy({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.profileUrl,
    required this.isVerified,
  });

  factory UploadedBy.empty() => UploadedBy(
      id: "",
      email: "",
      firstName: "",
      lastName: "",
      fullName: "",
      profileUrl: "",
      isVerified: false);

  factory UploadedBy.fromJson(Map<String, dynamic> json) => UploadedBy(
        id: json["id"] ?? "",
        email: json["email"] ?? "",
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        fullName: json["full_name"] ?? "",
        profileUrl: json["profile_url"] ?? "",
        isVerified: json["is_verified"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "is_verified": isVerified,
      };
}
