import '../../bookmark/models/chapter.dart';
import '../../bookmark/models/feedback.dart';
import '../../bookmark/models/folder_entity.dart';
import '../../bookmark/models/uploaded_by.dart';

class VideoEntity {
  late String id;
  late String title;
  late String description;
  late String videoUrl;
  late String thumbnailUrl;
  late String uploadId;
  late FeedbackEntity feedback;
  late FolderEntity folder;
  late List<ChapterEntity> chapters;
  late UploadedBy uploadedBy;
  late String createdAt;
  late String updatedAt;
  late bool isPublished;
  late bool isFeatured;

  // VideoEntity({
  //   required this.id,
  //   required this.title,
  //   required this.description,
  //   required this.videoUrl,
  //   required this.thumbnailUrl,
  //   required this.uploadId,
  //   required this.feedback,
  //   required this.folder,
  //   required this.chapters,
  //   required this.uploadedBy,
  //   required this.createdAt,
  //   required this.updatedAt,
  //   required this.isPublished,
  //   required this.isFeatured,
  // });

   VideoEntity.empty() {
        id ="";
        title= "";
        description= "";
        videoUrl= "";
        thumbnailUrl= "";
        uploadId= "";
        feedback= FeedbackEntity.empty();
        folder= FolderEntity.empty();
        chapters= [];
        uploadedBy= UploadedBy.empty();
        createdAt= "";
        updatedAt= "";
        isPublished= false;
        isFeatured= false;
  }

  VideoEntity.fromJson(Map<String, dynamic> json) {
    id=
    json["id"] ?? "";
    title=
    json["title"] ?? "";
    description=
    json["description"] ?? "";
    videoUrl=
    json["video_url"] ?? "";
    thumbnailUrl=
    json["thumbnail_url"] ?? "";
    uploadId=
    json["upload_id"] ?? "";
    feedback=
    json["feedback"] != null
        ? FeedbackEntity.fromJson(json["feedback"])
        : FeedbackEntity.empty();
    folder=
    json["folder"] != null
        ? FolderEntity.fromJson(json["folder"])
        : FolderEntity.empty();
    chapters=
    json["chapters"] == null
        ? []
        : List<ChapterEntity>.from(
        json["chapters"]!.map((x) => ChapterEntity.fromJson(x)));
    uploadedBy=
    json["uploaded_by"] != null
        ? UploadedBy.fromJson(json["uploaded_by"])
        : UploadedBy.empty();
    createdAt=
    json["created_at"] ?? "";
    updatedAt=
    json["updated_at"] ?? "";
    isPublished=
    json["is_published"] ?? "";
    isFeatured=
    json["is_featured"] ?? "";
  }

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
