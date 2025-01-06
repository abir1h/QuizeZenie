import '../../../common/constants/common_imports.dart';
import '../../../common/models/action_result.dart';
import '../../../common/network/api_service.dart';
import '../models/video_upload_entity.dart';

mixin VideoGateway {
  static Future<ActionResult<VideoUploadEntity>> uploadVideoFile(
      String title,
      String feedbackId,
      String folderId,
      String filePath,
      Function(double progress) onProgress) async {
    Map<String, String> data = {
      "title": title,
      "feedback_id": feedbackId,
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
}
