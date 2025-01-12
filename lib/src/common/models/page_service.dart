import 'dart:async';

class ServiceState {
  String searchTerm = "";
  bool mostViewed = false;
  bool mostRecent = false;
  bool mostFeedbacks = false;
  int pageSize = 10;
  int pageNumber = 1;
  int totalPage = 0;

  ///Search and category filter stream controller
  final StreamController<bool> _searchActivityStreamController =
      StreamController.broadcast();

  ///Streams
  Stream<bool> get searchActivityStream =>
      _searchActivityStreamController.stream;

  void addToSearchActivityStream(bool value) {
    if (!_searchActivityStreamController.isClosed)
      _searchActivityStreamController.sink.add(value);
  }

  void dispose() {
    _searchActivityStreamController.close();
  }

  // String get getPaginatedUrlSegment => "name=$searchTerm&categoryId=${selectedCategory.id > 0?selectedCategory.id:""}&size=$pageSize&pageNumber=$pageNumber";
  // String getPaginatedAndFilteredUrlSegment(int pageSize, int pageNumber) => "name=$searchTerm&categoryId=${selectedCategory.id > 0?selectedCategory.id:""}&size=$pageSize&pageNumber=$pageNumber";
  String getPaginatedUrlSegment(
    int pageSize,
    int pageNumber,
  ) =>
      "page=$pageNumber&page_size=$pageSize";
  String getPaginatedAndFilterUrlSegment(int pageSize, int pageNumber,
          String userId, String courseId, String courseTopicId) =>
      "?userId=$userId&courseId=$courseId&courseTopicId=$courseTopicId&size=$pageSize&pageNumber=$pageNumber";

  String getSearchPaginatedUrlSegment(int pageSize, int pageNumber) =>
      "?size=$pageSize&pageNumber=$pageNumber&${searchTerm.isNotEmpty ? "title=$searchTerm&" : ""}most_viewed=$mostViewed&most_recent=$mostRecent&most_feedbacks=$mostFeedbacks";

  String getPaginatedUrlSegmentForFeedback(
    String videoId,
    int pageSize,
    int pageNumber,
  ) =>
      "$videoId/?page=$pageNumber&page_size=$pageSize";
}
