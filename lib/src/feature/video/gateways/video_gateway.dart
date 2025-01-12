import '../../../common/constants/common_imports.dart';
import '../../../common/models/action_result.dart';
import '../../../common/models/pagination_entity.dart';
import '../../../common/network/api_service.dart';
import '../models/video_upload_entity.dart';
import '../models/comment_entity.dart';
import '../models/video_entity.dart';

mixin VideoGateway {
  static Future<ActionResult<VideoUploadEntity>> uploadVideoFile(
      String title,
      int feedbackId,
      String folderId,
      String filePath,
      Function(double progress) onProgress) async {
    Map<String, String> data = {
      "title": title,
      "feedback_id": feedbackId.toString(),
      "folder_id": folderId,
    };
    return Server.instance
        .postRequestWithFileProgress(
            url: ApiCredential.fileUpload,
            filePath: filePath,
            postData: data,
            onProgress: onProgress)
        .then((value) {
      return ActionResult<VideoUploadEntity>.fromServerResponse(
        response: value,
        generateData: (x) => VideoUploadEntity.fromJson(x),
      );
    }).catchError((e) {
      return ActionResult<VideoUploadEntity>.error();
    });
  }

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
        generateData: (x) => CommentEntity.listFromJson(x['results']),
      );
    }).catchError((e) {
      return ActionResult<List<CommentEntity>>.error();
    });
  }

  static Future<ActionResult<CommentEntity>> doComment(
      String formId,
      int categoryId,
      int typeId,
      String videoId,
      String startTime,
      String endTime) async {
    return Server.instance.postRequest(
      url: ApiCredential.doComment,
      postData: {
        "feedback_form_id": formId,
        "feedback_category_id": categoryId,
        "feedback_type_id": typeId,
        "video_id": videoId,
        "start_time": startTime,
        "end_time": endTime,
      },
    ).then((value) {
      return ActionResult<CommentEntity>.fromServerResponse(
        response: value,
        generateData: (x) => CommentEntity.fromJson(x),
      );
    }).catchError((e) {
      return ActionResult<CommentEntity>.error();
    });
  }
  static Future<ActionResult<List<ChapterEntity>>> chapterCreateAction(
      String title, String videoId, int time) async {
    return Server.instance.postRequest(
      url: ApiCredential.createChapter,
      postData: {
        "title": title,
        "video_id": videoId,
        "start_time": time,
      },
    ).then((value) {
      return ActionResult<List<ChapterEntity>>.fromServerResponse(
        response: value,
        generateData: (x) => ChapterEntity.listFromJson(x),
      );
    }).catchError((e) {
      return ActionResult<List<ChapterEntity>>.error();
    });
  }



  static Future<ActionResult<PaginationEntity<VideoEntity>>> getVideoListWithPagination(String paginatedUrlSegment) async{
    return Server.instance.getRequest(
      url: "${ApiCredential.myVideoList}?$paginatedUrlSegment",
    ).then((value){
      return ActionResult<PaginationEntity<VideoEntity>>.fromServerResponse(
        response: value,
        generateData:(source)=> PaginationEntity<VideoEntity>.fromJson(
          source: source,
          generateItem: (x)=> VideoEntity.fromJson(x),
        ),
      );
    }).catchError((e){
      return ActionResult<PaginationEntity<VideoEntity>>.error();
    });
  }

}
