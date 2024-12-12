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
  List<Chapter> chapters;

  Video({
    required this.id,
    required this.title,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.chapters,
  });

  factory Video.empty() =>
      Video(id: "", title: "", videoUrl: "", thumbnailUrl: "", chapters: []);

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        videoUrl: json["video_url"] ?? "",
        thumbnailUrl: json["thumbnail_url"] ?? "",
        chapters: json["chapters"] != null
            ? List<Chapter>.from(
                json["chapters"].map((x) => Chapter.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "video_url": videoUrl,
        "thumbnail_url": thumbnailUrl,
        "chapters": List<dynamic>.from(chapters.map((x) => x.toJson())),
      };
}

class Chapter {
  String id;
  String title;
  String description;
  String startTime;
  String endTime;

  Chapter({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
  });

  factory Chapter.empty() =>
      Chapter(id: "", title: "", description: "", startTime: "", endTime: "");

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        startTime: json["start_time"] ?? "",
        endTime: json["end_time"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "start_time": startTime,
        "end_time": endTime,
      };
}
