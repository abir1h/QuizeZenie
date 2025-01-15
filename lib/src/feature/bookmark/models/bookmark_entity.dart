import 'feedback.dart';
import 'chapter.dart';
import 'folder_entity.dart';

import '../../home/models/home_entity.dart';

class BookmarkEntity {
  int id;
  BookmarkedContent bookmarkedContent;
  UploadedBy bookmarkedBy;
  String createdAt;
  String updatedAt;

  BookmarkEntity({
    required this.id,
    required this.bookmarkedContent,
    required this.bookmarkedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookmarkEntity.fromJson(Map<String, dynamic> json) => BookmarkEntity(
        id: json["id"] ?? -1,
        bookmarkedContent: json["bookmarked_content"] != null
            ? BookmarkedContent.fromJson(json["bookmarked_content"])
            : BookmarkedContent.empty(),
        bookmarkedBy: json["bookmarked_by"] != null
            ? UploadedBy.fromJson(json["bookmarked_by"])
            : UploadedBy.empty(),
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bookmarked_content": bookmarkedContent.toJson(),
        "bookmarked_by": bookmarkedBy.toJson(),
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class BookmarkedContent {
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

  BookmarkedContent({
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
  factory BookmarkedContent.empty() => BookmarkedContent(
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

  factory BookmarkedContent.fromJson(Map<String, dynamic> json) =>
      BookmarkedContent(
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
        "chapters": List<dynamic>.from(chapters.map((x) => x.toJson())),
        "uploaded_by": uploadedBy.toJson(),
        "created_at": createdAt,
        "updated_at": updatedAt,
        "is_published": isPublished,
        "is_featured": isFeatured,
      };
}
