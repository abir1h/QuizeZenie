import '../../../common/constants/common_imports.dart';
import '../../../common/models/action_result.dart';
import '../../../common/network/api_service.dart';
import '../models/home_entity.dart';

mixin HomeGateway {
  static Future<ActionResult<HomeEntity>> getDashboardData() async {
    return Server.instance
        .getRequest(url: ApiCredential.homeContent)
        .then((value) {
      return ActionResult<HomeEntity>.fromServerResponse(
        response: value,
        generateData: (x) => HomeEntity.fromJson(x),
      );
    }).catchError((e) {
      return ActionResult<HomeEntity>.error();
    });
  }
}
