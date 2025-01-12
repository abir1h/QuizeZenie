import '../../home/models/home_entity.dart';

class ChapterEntity {
  String id;
  String title;
  Video video;
  String thumbnailUrl;
  String startTime;
  int startTimeSeconds;
  String createdBy;
  String createdAt;
  String updatedAt;

  ChapterEntity({
    required this.id,
    required this.title,
    required this.video,
    required this.thumbnailUrl,
    required this.startTime,
    required this.startTimeSeconds,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });
  factory ChapterEntity.empty() => ChapterEntity(
      id: "",
      title: "",
      video: Video.empty(),
      thumbnailUrl: "",
      startTime: "",
      startTimeSeconds: -1,
      createdBy: "",
      createdAt: "",
      updatedAt: "");

  factory ChapterEntity.fromJson(Map<String, dynamic> json) => ChapterEntity(
    id: json["id"] ?? "",
    title: json["title"] ?? "",
    video: json["video"] != null
        ? Video.fromJson(json["video"])
        : Video.empty(),
    thumbnailUrl: json["thumbnail_url"] ?? "",
    startTime: json["start_time"] ?? "",
    startTimeSeconds: json["start_time_seconds"] ?? -1,
    createdBy: json["created_by"] ?? "",
    createdAt: json["created_at"] ?? "",
    updatedAt: json["updated_at"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "video": video.toJson(),
    "thumbnail_url": thumbnailUrl,
    "start_time": startTime,
    "start_time_seconds": startTimeSeconds,
    "created_by": createdBy,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
  static List<ChapterEntity> listFromJson(List<dynamic> json){
    return json.isNotEmpty ? List.castFrom<dynamic,ChapterEntity>(json.map((x)=> ChapterEntity.fromJson(x)).toList()):[];
  }

}