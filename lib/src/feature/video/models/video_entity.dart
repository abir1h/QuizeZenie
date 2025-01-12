import '../../bookmark/models/chapter.dart';
import '../../bookmark/models/feedback.dart';
import '../../bookmark/models/folder_entity.dart';
import '../../bookmark/models/uploaded_by.dart';

class VideoEntity {
  String id;
  String title;
  String description;
  String videoUrl;
  String thumbnailUrl;
  String uploadId;
  FeedbackEntity feedback;
  FolderEntity folder;
  List<ChapterEntity> chapters;
  UploadedBy uploadedBy;
  String createdAt;
  String updatedAt;
  bool isPublished;
  bool isFeatured;

  VideoEntity({
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

  factory VideoEntity.empty() => VideoEntity(
      id: "",
      title: "",
      description: "",
      videoUrl: "",
      thumbnailUrl: "",
      uploadId: "",
      feedback: FeedbackEntity.empty(),
      folder: FolderEntity.empty(),
      chapters: [],
      uploadedBy: UploadedBy.empty(),
      createdAt: "",
      updatedAt: "",
      isPublished: false,
      isFeatured: false);

  factory VideoEntity.fromJson(Map<String, dynamic> json) => VideoEntity(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        videoUrl: json["video_url"] ?? "",
        thumbnailUrl: json["thumbnail_url"] ?? "",
        uploadId: json["upload_id"] ?? "",
        feedback: json["feedback"] != null
            ? FeedbackEntity.fromJson(json["feedback"])
            : FeedbackEntity.empty(),
        folder: json["folder"] != null
            ? FolderEntity.fromJson(json["folder"])
            : FolderEntity.empty(),
        chapters: json["chapters"] == null
            ? []
            : List<ChapterEntity>.from(
                json["chapters"]!.map((x) => ChapterEntity.fromJson(x))),
        uploadedBy: json["uploaded_by"] != null
            ? UploadedBy.fromJson(json["uploaded_by"])
            : UploadedBy.empty(),
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        isPublished: json["is_published"] ?? "",
        isFeatured: json["is_featured"] ?? "",
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
        "uploaded_by": uploadedBy.toJson(),
        "created_at": createdAt,
        "updated_at": updatedAt,
        "is_published": isPublished,
        "is_featured": isFeatured,
      };
}
