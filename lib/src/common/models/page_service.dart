import 'dart:async';
import '../../feature/home/models/category_entity.dart';
import '../widgets/app_stream.dart';

class ServiceState {
  CategoryEntity selectedCategory = CategoryEntity.empty();
  String searchTerm = "";
  int pageSize = 1000;
  int pageNumber = 0;
  int totalPage = 0;

  ///Search and category filter stream controller
  final AppStreamController<List<CategoryEntity>>
      _categoryDataStreamController = AppStreamController();
  final StreamController<bool> _searchActivityStreamController =
      StreamController.broadcast();

  ///Streams
  Stream<bool> get searchActivityStream =>
      _searchActivityStreamController.stream;
  Stream<DataState<List<CategoryEntity>>> get categoryDataStream =>
      _categoryDataStreamController.stream;

  ///Sinks
  void addToCategoryStream(DataState<List<CategoryEntity>> value) {
    _categoryDataStreamController.add(value);
  }

  void addToSearchActivityStream(bool value) {
    if (!_searchActivityStreamController.isClosed)
      _searchActivityStreamController.sink.add(value);
  }

  void dispose() {
    selectedCategory = CategoryEntity.empty();
    _categoryDataStreamController.dispose();
    _searchActivityStreamController.close();
  }

  // String get getPaginatedUrlSegment => "name=$searchTerm&categoryId=${selectedCategory.id > 0?selectedCategory.id:""}&size=$pageSize&pageNumber=$pageNumber";
  // String getPaginatedAndFilteredUrlSegment(int pageSize, int pageNumber) => "name=$searchTerm&categoryId=${selectedCategory.id > 0?selectedCategory.id:""}&size=$pageSize&pageNumber=$pageNumber";
  String getPaginatedUrlSegment(
          int pageSize, int pageNumber, int organizationID, int categoryID) =>
      "pagination=true&organization_id=$organizationID&current_page=$pageNumber&category_id=$categoryID&search=$searchTerm";
  String getPaginatedAndFilterUrlSegment(
          int pageSize, int pageNumber, int organizationID) =>
      "pagination=true&organization_id=$organizationID&current_page=$pageNumber&category_id=${selectedCategory.id > 0 ? selectedCategory.id : ""}&search=$searchTerm";
}
