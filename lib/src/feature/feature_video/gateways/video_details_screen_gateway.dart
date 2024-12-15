import 'package:co_learning_mobile_app/src/feature/home/models/home_entity.dart';

import '../../../common/models/action_result.dart';
import '../../../common/network/api_service.dart';

mixin VideoDetailsGateway{

  static Future<ActionResult<Video>> getVideoDetails(String videoId) async{
    return Server.instance.getRequest(
      url: "analytics/video_details/$videoId",
    ).then((value){
      return ActionResult<Video>.fromServerResponse(
        response: value,
        generateData: (x)=> Video.fromJson(x),
      );
    }).catchError((e){
      return ActionResult<Video>.error();
    });
  }}