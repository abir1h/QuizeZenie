import '../../bookmark/models/feedback.dart';
import '../../bookmark/models/uploaded_by.dart';
import '../../video/models/video_entity.dart';

class FeedbackScoreEntity {
  UploadedBy scoredBy;
  int userTotalScore;

  FeedbackScoreEntity({
    required this.scoredBy,
    required this.userTotalScore,
  });

  factory FeedbackScoreEntity.empty() =>
      FeedbackScoreEntity(scoredBy: UploadedBy.empty(), userTotalScore: 0);

  factory FeedbackScoreEntity.fromJson(Map<String, dynamic> json) =>
      FeedbackScoreEntity(
        scoredBy: json["scored_by"] != null
            ? UploadedBy.fromJson(json["scored_by"])
            : UploadedBy.empty(),
        userTotalScore: json["user_total_score"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "scored_by": scoredBy.toJson(),
        "user_total_score": userTotalScore,
      };

  static List<FeedbackScoreEntity> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, FeedbackScoreEntity>(
            json.map((x) => FeedbackScoreEntity.fromJson(x)).toList())
        : [];
  }
}
