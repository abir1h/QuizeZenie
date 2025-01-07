import '../../video/models/video_entity.dart';
import '../../../common/models/action_result.dart';
import '../../../common/models/pagination_entity.dart';
import '../../../common/network/api_service.dart';

mixin SearchVideoGateway{
  static Future<ActionResult<PaginationEntity<VideoEntity>>> getVideoListWithPagination(String paginatedUrlSegment) async {
    return Server.instance.getRequest(
      url: "file/search/$paginatedUrlSegment",
    ).then((value) {
      return ActionResult<PaginationEntity<VideoEntity>>.fromServerResponse(
        response: value,
        generateData:(source)=> PaginationEntity<VideoEntity>.fromJson(
          source: source,
          generateItem: (x)=> VideoEntity.fromJson(x),
        ),
      );
    }).catchError((e) {
      return ActionResult<PaginationEntity<VideoEntity>>.error();
    });
  }

/*  static Future<ActionResult<List<VideoEntity>>> getAllCategoryList() async {
    return Server.instance.getRequest(
      url: "category-list?organization_id=1",
    ).then((value) {
      return ActionResult<List<VideoEntity>>.fromServerResponse(
        response: value,
        generateData: (x) => CategoryEntity.listFromJson(x),
      );
    }).catchError((e) {
      return ActionResult<List<CategoryEntity>>.error();
    });
  }*/
}