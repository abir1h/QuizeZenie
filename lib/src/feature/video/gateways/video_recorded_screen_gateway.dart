import 'package:co_learning_mobile_app/src/feature/bookmark/models/feedback.dart';
import 'package:co_learning_mobile_app/src/feature/bookmark/models/folder_entity.dart';
import '../../../common/constants/common_imports.dart';
import '../../../common/models/action_result.dart';
import '../../../common/network/api_service.dart';

mixin VideoRecordedScreenGateway {

  static Future<ActionResult<List<FeedbackEntity>>> getFeedbackList() async {
    return Server.instance.getRequest(
      url: ApiCredential.getFeedBackList,
    ).then((value) {
      return ActionResult<List<FeedbackEntity>>.fromServerResponse(
        response: value,
        generateData: (x) => FeedbackEntity.listFromJson(x),
      );
    }).catchError((e) {
      return ActionResult<List<FeedbackEntity>>.error();
    });
  }
  static Future<ActionResult<List<FolderEntity>>> getFolderList() async {
    return Server.instance.getRequest(
      url: ApiCredential.getFolderList,
    ).then((value) {
      return ActionResult<List<FolderEntity>>.fromServerResponse(
        response: value,
        generateData: (x) => FolderEntity.listFromJson(x),
      );
    }).catchError((e) {
      return ActionResult<List<FolderEntity>>.error();
    });
  }

}
