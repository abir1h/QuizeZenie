class VideoUploadEntity {
  String id;
  String videoUrl;

  VideoUploadEntity({
    required this.id,
    required this.videoUrl,
  });

  factory VideoUploadEntity.fromJson(Map<String, dynamic> json) =>
      VideoUploadEntity(
        id: json["id"] ?? "",
        videoUrl: json["video_url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video_url": videoUrl,
      };
}
