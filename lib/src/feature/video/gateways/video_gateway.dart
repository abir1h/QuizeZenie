import '../../../common/constants/common_imports.dart';
import '../../../common/models/action_result.dart';
import '../../../common/network/api_service.dart';
import '../models/comment_entity.dart';
import '../models/video_entity.dart';

mixin VideoGateway {
  static Future<ActionResult<VideoEntity>> getVideoDetails(
      String videoId) async {
    return Server.instance
        .getRequest(url: "${ApiCredential.videoDetails}$videoId")
        .then((value) {
      return ActionResult<VideoEntity>.fromServerResponse(
        response: value,
        generateData: (x) => VideoEntity.fromJson(x),
      );
    }).catchError((e) {
      return ActionResult<VideoEntity>.error();
    });
  }

  static Future<ActionResult<List<CommentEntity>>> getVideoComments(
      String videoId) async {
    return Server.instance
        .getRequest(url: "${ApiCredential.videoComments}$videoId")
        .then((value) {
      return ActionResult<List<CommentEntity>>.fromServerResponse(
        response: value,
        generateData: (x) => CommentEntity.listFromJson(x),
      );
    }).catchError((e) {
      return ActionResult<List<CommentEntity>>.error();
    });
  }
}
