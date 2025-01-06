import '../../bookmark/models/uploaded_by.dart';

class CommentEntity {
  String id;
  String startTime;
  String endTime;
  FeedbackType feedbackCategory;
  FeedbackType feedbackType;
  UploadedBy createdBy;

  CommentEntity({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.feedbackCategory,
    required this.feedbackType,
    required this.createdBy,
  });

  factory CommentEntity.empty() => CommentEntity(
      id: "",
      startTime: "",
      endTime: "",
      feedbackCategory: FeedbackType.empty(),
      feedbackType: FeedbackType.empty(),
      createdBy: UploadedBy.empty());

  factory CommentEntity.fromJson(Map<String, dynamic> json) => CommentEntity(
        id: json["id"] ?? "",
        startTime: json["start_time"] ?? "",
        endTime: json["end_time"] ?? "",
        feedbackCategory: json["feedback_category"] != null
            ? FeedbackType.fromJson(json["feedback_category"])
            : FeedbackType.empty(),
        feedbackType: json["feedback_type"] != null
            ? FeedbackType.fromJson(json["feedback_type"])
            : FeedbackType.empty(),
        createdBy: json["created_by"] != null
            ? UploadedBy.fromJson(json["created_by"])
            : UploadedBy.empty(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_time": startTime,
        "end_time": endTime,
        "feedback_category": feedbackCategory.toJson(),
        "feedback_type": feedbackType.toJson(),
        "created_by": createdBy.toJson(),
      };
  static List<CommentEntity> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, CommentEntity>(
            json.map((x) => CommentEntity.fromJson(x)).toList())
        : [];
  }
}

class FeedbackType {
  int id;
  String name;
  String createdAt;
  String choice;

  FeedbackType({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.choice,
  });

  factory FeedbackType.empty() =>
      FeedbackType(id: -1, name: "", createdAt: "", choice: "");

  factory FeedbackType.fromJson(Map<String, dynamic> json) => FeedbackType(
        id: json["id"] ?? -1,
        name: json["name"] ?? "",
        createdAt: json["created_at"] ?? "",
        choice: json["choice"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "choice": choice,
      };
}
