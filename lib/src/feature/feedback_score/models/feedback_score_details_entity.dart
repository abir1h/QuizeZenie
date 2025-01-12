import '../../bookmark/models/feedback.dart';
import '../../bookmark/models/uploaded_by.dart';

class FeedbackScoreDetailsEntity {
  String videoId;
  int feedbackFormId;
  String feedbackFormName;
  List<Category> categories;
  UploadedBy scoredBy;
  int totalScore;

  FeedbackScoreDetailsEntity({
    required this.videoId,
    required this.feedbackFormId,
    required this.feedbackFormName,
    required this.categories,
    required this.scoredBy,
    required this.totalScore,
  });

  factory FeedbackScoreDetailsEntity.fromJson(Map<String, dynamic> json) =>
      FeedbackScoreDetailsEntity(
        videoId: json["video_id"],
        feedbackFormId: json["feedback_form_id"],
        feedbackFormName: json["feedback_form_name"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        scoredBy: UploadedBy.fromJson(json["scored_by"]),
        totalScore: json["total_score"],
      );

  Map<String, dynamic> toJson() => {
        "video_id": videoId,
        "feedback_form_id": feedbackFormId,
        "feedback_form_name": feedbackFormName,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "scored_by": scoredBy.toJson(),
        "total_score": totalScore,
      };
}

class Category {
  int categoryId;
  String categoryName;
  List<ScoreType> types;

  Category({
    required this.categoryId,
    required this.categoryName,
    required this.types,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        types: List<ScoreType>.from(json["types"].map((x) => ScoreType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "types": List<dynamic>.from(types.map((x) => x.toJson())),
      };
}

class ScoreType {
  int typeId;
  String typeName;
  int score;

  ScoreType({
    required this.typeId,
    required this.typeName,
    required this.score,
  });

  factory ScoreType.fromJson(Map<String, dynamic> json) => ScoreType(
        typeId: json["type_id"],
        typeName: json["type_name"],
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "type_id": typeId,
        "type_name": typeName,
        "score": score,
      };
}
