import '../../bookmark/models/chapter.dart';
import '../../bookmark/models/feedback.dart';
import '../../bookmark/models/folder_entity.dart';
import '../../bookmark/models/uploaded_by.dart';

class CategoryEntity {
  String id;
  String title;
  String description;
  String videoUrl;
  String thumbnailUrl;
  String uploadId;
  FeedbackEntity feedback;
  FolderEntity folder;
  List<Chapter> chapters;
  UploadedBy uploadedBy;
  String createdAt;
  String updatedAt;
  bool isPublished;
  bool isFeatured;

  CategoryEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.uploadId,
    required this.feedback,
    required this.folder,
    required this.chapters,
    required this.uploadedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.isPublished,
    required this.isFeatured,
  });

  factory CategoryEntity.fromJson(Map<String, dynamic> json) => CategoryEntity(
    id: json["id"]??"",
    title: json["title"]??"",
    description: json["description"]??"",
    videoUrl: json["video_url"]??"",
    thumbnailUrl: json["thumbnail_url"]??"",
    uploadId: json["upload_id"]??"",
    feedback:json["feedback"] != null
        ? FeedbackEntity.fromJson(json["feedback"])
        : FeedbackEntity.empty(),
    folder: json["folder"] != null
        ? FolderEntity.fromJson(json["folder"])
        : FolderEntity.empty(),
    chapters: json["chapters"] == null
        ? []
        : List<Chapter>.from(
        json["chapters"]!.map((x) => Chapter.fromJson(x))),
    uploadedBy: json["uploaded_by"] != null
        ? UploadedBy.fromJson(json["uploaded_by"])
        : UploadedBy.empty(),
    createdAt: json["created_at"]??"",
    updatedAt: json["updated_at"]??"",
    isPublished: json["is_published"]??false,
    isFeatured: json["is_featured"]??false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "video_url": videoUrl,
    "thumbnail_url": thumbnailUrl,
    "upload_id": uploadId,
    "feedback": feedback.toJson(),
    "folder": folder.toJson(),
    "chapters": List<dynamic>.from(chapters.map((x) => x)),
    "uploaded_by": uploadedBy.toJson(),
    "created_at": createdAt,
    "updated_at": updatedAt,
    "is_published": isPublished,
    "is_featured": isFeatured,
  };
}
