import 'dart:async';
import 'package:flutter/material.dart';

import '../../../common/constants/app_constant.dart';
import '../../../common/models/action_result.dart';
import '../../../common/models/page_service.dart';
import '../../../common/widgets/app_stream.dart';
import '../../../common/widgets/paginated_list_view.dart';
import '../gateway/video_search_gateway.dart';
import '../../video/models/video_entity.dart';
abstract class _ViewModel {
  void showWarning(String message);

}

mixin VideoSearchScreenService<T extends StatefulWidget> on State<T> implements _ViewModel {
  late _ViewModel _view;
  late ServiceState serviceState = ServiceState();

  ///Service configurations
  @override
  void initState() {
    _view = this;
    paginationController.onLoadMore = _onLoadMoreItems;
    super.initState();
    _loadInitialData();
  }

  @override
  void dispose() {
    videoDataStreamController.dispose();
    paginationController.dispose();
    serviceState.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<PaginatedListViewController<VideoEntity>> videoDataStreamController = AppStreamController();

  PaginatedListViewController<VideoEntity> paginationController = PaginatedListViewController();



  ///Load enrolled course list
  void _loadInitialData() {

    print("Service state value "+serviceState.mostRecent.toString());
    ///Loading state
    if(!mounted) return;
    paginationController.clear();
    videoDataStreamController.add(LoadingState());
    SearchVideoGateway.getVideoListWithPagination(serviceState.getSearchPaginatedUrlSegment(paginationController.pageSize,1),).then((value){
      if (!mounted) return;
      ///Data loaded state
      if(value.status == Status.success && value.data!.total > 0){
        paginationController.setTotalItemCount(value.data!.total);
        paginationController.addItems(value.data!.records);
        videoDataStreamController.add(DataLoadedState(paginationController));
      }
      ///Empty state
      else if(value.status == Status.success && value.data!.total <= 0){
        videoDataStreamController.add(EmptyState(
          message: "No Course is available!",
          icon: Icons.layers_outlined,
        ));
      }
      ///Error state
      else{
        ///Try reloading
        _view.showWarning(value.message);
        Future.delayed( Duration(seconds: AppConstant.reloadInSeconds)).then((value){
          if(mounted) _loadInitialData();
        });
      }
    });
  }


/*
  void onLoadCategoryList() {
    ///Loading state
    if(!mounted) return;
    SearchCourseGateway.getAllCategoryList().then((value){
      if(!mounted) return;

      ///Data loaded state
      if(value.status == Status.success && value.data!.isNotEmpty){
        serviceState.addToCategoryStream(DataLoadedState<List<CategoryEntity>>(value.data!));
      }
      ///Empty state
      else if(value.status == Status.success ){
        serviceState.addToCategoryStream(EmptyState(
          message: "No item found!",
        ));
      }
      ///Error state
      else{
        _view.showWarning(value.message);
        serviceState.addToCategoryStream(EmptyState(
          message: "Failed to load!",
        ));
      }
    });
  }
*/
  ///Once user change category selection

  ///This is used to handle search contents. It fires when user change any search term
  void onSearchTermChanged(String value) {
    if(!mounted) return;

    if(serviceState.searchTerm.isNotEmpty){
      serviceState.addToSearchActivityStream(true);

      SearchVideoGateway.getVideoListWithPagination(serviceState.getSearchPaginatedUrlSegment(paginationController.pageSize,1),).then((value){
        if(!mounted) return;

        paginationController.clear();
        serviceState.addToSearchActivityStream(false);

        ///Data loaded state
        if(value.status == Status.success && value.data!.total > 0){
          paginationController.setTotalItemCount(value.data!.total);
          paginationController.addItems(value.data!.records);
          videoDataStreamController.add(DataLoadedState(paginationController));
        }
        ///Empty state
        else if(value.status == Status.success && value.data!.total <= 0){
          videoDataStreamController.add(EmptyState(
            message: "No item found!",
            icon: Icons.search_rounded,
          ));
        }
        ///Error state
        else{
          _view.showWarning(value.message);
        }
      });
    }
    else{
      _loadInitialData();
    }
  }

  ///Load more data
  Future<bool> _onLoadMoreItems(int nextPage) async{
    Completer<bool> completer = Completer();
    SearchVideoGateway.getVideoListWithPagination(serviceState.getSearchPaginatedUrlSegment(
        paginationController.pageSize,
        paginationController.nextPage,

    ),).asStream().listen((value) {
      if (!mounted) return;
      ///Data loaded state
      if(value.status == Status.success && value.data!.total > 0){
        paginationController.setTotalItemCount(value.data!.total);
        paginationController.addItems(value.data!.records);
        completer.complete(true);
      }
      ///Error state
      else{
        ///Try reloading
        _view.showWarning(value.message);
        completer.complete(false);
      }
    });

    return completer.future;
  }



}

