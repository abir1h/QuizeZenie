class Video {
  String id;
  String title;
  String videoUrl;
  String thumbnailUrl;

  Video({
    required this.id,
    required this.title,
    required this.videoUrl,
    required this.thumbnailUrl,
  });
  factory Video.empty() =>
      Video(id: "", title: "", videoUrl: "", thumbnailUrl: "");

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    id: json["id"] ?? "",
    title: json["title"] ?? "",
    videoUrl: json["video_url"] ?? "",
    thumbnailUrl: json["thumbnail_url"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "video_url": videoUrl,
    "thumbnail_url": thumbnailUrl,
  };
}