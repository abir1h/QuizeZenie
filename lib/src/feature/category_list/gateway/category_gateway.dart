import '../../../common/constants/common_imports.dart';
import '../models/category_entity.dart';
import '../../../common/models/action_result.dart';
import '../../../common/models/pagination_entity.dart';
import '../../../common/network/api_service.dart';

mixin CategoryGateway{



  static Future<ActionResult<PaginationEntity<CategoryEntity>>> getCategoryWiseVideoListWithPagination(String paginatedUrlSegment,String categoryId) async{
    return Server.instance.getRequest(
      url: "${ApiCredential.categoryWiseVideo}$categoryId/?$paginatedUrlSegment",
    ).then((value){
      return ActionResult<PaginationEntity<CategoryEntity>>.fromServerResponse(
        response: value,
        generateData:(source)=> PaginationEntity<CategoryEntity>.fromJson(
          source: source,
          generateItem: (x)=> CategoryEntity.fromJson(x),
        ),
      );
    }).catchError((e){
      return ActionResult<PaginationEntity<CategoryEntity>>.error();
    });
  }


}