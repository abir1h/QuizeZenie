import '../../../common/constants/common_imports.dart';
import '../../../common/models/action_result.dart';
import '../../../common/models/pagination_entity.dart';
import '../../../common/network/api_service.dart';
import '../../bookmark/models/feedback.dart';
import '../../bookmark/models/form_category.dart';
import '../models/feedback_score_details_entity.dart';
import '../models/feedback_score_entity.dart';

mixin FeedbackScoreGateway {
  static Future<ActionResult<PaginationEntity<FeedbackScoreEntity>>>
      getFeedbackScoreListWithPagination(String paginatedUrlSegment) async {
    return Server.instance
        .getRequest(
            url:
                "${ApiCredential.feedbackScore}video-scoring/$paginatedUrlSegment")
        .then((value) {
      return ActionResult<
          PaginationEntity<FeedbackScoreEntity>>.fromServerResponse(
        response: value,
        generateData: (source) =>
            PaginationEntity<FeedbackScoreEntity>.fromJson(
          source: source,
          generateItem: (x) => FeedbackScoreEntity.fromJson(x),
        ),
      );
    }).catchError((e) {
      return ActionResult<PaginationEntity<FeedbackScoreEntity>>.error();
    });
  }

  static Future<ActionResult<List<FeedbackScoreEntity>>> getFeedbackScoreList(
      String videoId) async {
    return Server.instance
        .getRequest(url: "${ApiCredential.feedbackScore}video-scoring/$videoId")
        .then((value) {
      return ActionResult<List<FeedbackScoreEntity>>.fromServerResponse(
        response: value,
        generateData: (x) => FeedbackScoreEntity.listFromJson(x['results']),
      );
    }).catchError((e) {
      return ActionResult<List<FeedbackScoreEntity>>.error();
    });
  }

  static Future<ActionResult<FeedbackScoreDetailsEntity>>
      getFeedbackScoreDetails(String videoId, String scoreId) async {
    return Server.instance
        .getRequest(
            url: "${ApiCredential.feedbackScore}user-scoring/$videoId/$scoreId")
        .then((value) {
      return ActionResult<FeedbackScoreDetailsEntity>.fromServerResponse(
        response: value,
        generateData: (x) => FeedbackScoreDetailsEntity.fromJson(x),
      );
    }).catchError((e) {
      return ActionResult<FeedbackScoreDetailsEntity>.error();
    });
  }

  static Future<ActionResult<List<FeedbackScoreEntity>>> giveScore(
      String videoId, FeedbackEntity feedbackEntity) async {
    return Server.instance.postRequest(
      url: ApiCredential.feedbackScore,
      postData: {
        "video_id": videoId,
        "feedback_form_id": feedbackEntity.id,
        "categories": feedbackEntity.formCategories
            .map((e) => {
                  "category_id": e.category.id,
                  "types": e.formCategoryTypes
                      .where((v) => v.type.score != -1)
                      .map((v) => {
                            "type_id": v.type.id,
                            "score": v.type.score,
                          })
                      .toList(),
                })
            .toList(),
      },
    ).then((value) {
      return ActionResult<List<FeedbackScoreEntity>>.fromServerResponse(
        response: value,
        generateData: (x) => FeedbackScoreEntity.listFromJson(x),
      );
    }).catchError((e) {
      return ActionResult<List<FeedbackScoreEntity>>.error();
    });
  }
}
