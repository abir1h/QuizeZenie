import '../../../common/constants/common_imports.dart';
import '../models/bookmark_entity.dart';
import '../../../common/models/action_result.dart';
import '../../../common/models/pagination_entity.dart';
import '../../../common/network/api_service.dart';

mixin BookmarkGateway {
  static Future<ActionResult<PaginationEntity<BookmarkEntity>>>
      getBookmarkListWithPagination(String paginatedUrlSegment) async {
    return Server.instance
        .getRequest(
      url: "${ApiCredential.bookmarkList}?$paginatedUrlSegment",
    )
        .then((value) {
      return ActionResult<PaginationEntity<BookmarkEntity>>.fromServerResponse(
        response: value,
        generateData: (source) => PaginationEntity<BookmarkEntity>.fromJson(
          source: source,
          generateItem: (x) => BookmarkEntity.fromJson(x),
        ),
      );
    }).catchError((e) {
      return ActionResult<PaginationEntity<BookmarkEntity>>.error();
    });
  }

  static Future<ActionResult<BookmarkEntity>> doBookmark(String videoId) async {
    return Server.instance.postRequest(
      url: ApiCredential.doBookmark,
      postData: {
        "bookmarked_content": videoId,
      },
    ).then((value) {
      return ActionResult<BookmarkEntity>.fromServerResponse(
        response: value,
        generateData: (x) => BookmarkEntity.fromJson(x),
      );
    }).catchError((e) {
      return ActionResult<BookmarkEntity>.error();
    });
  }
}
