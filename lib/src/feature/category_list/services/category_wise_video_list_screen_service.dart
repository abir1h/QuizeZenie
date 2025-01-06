import 'dart:async';
import 'package:flutter/material.dart';

import '../../../common/constants/app_constant.dart';
import '../../../common/models/action_result.dart';
import '../../../common/models/page_service.dart';
import '../../../common/widgets/app_stream.dart';
import '../../../common/widgets/paginated_list_view.dart';
import '../models/category_entity.dart';
import '../gateway/category_gateway.dart';
import '../../../common/routes/app_route_args.dart';

abstract class _ViewModel {
  void showWarning(String message);
}

mixin CategoryWiseVideoListScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;
  int categoryId = -1;
  late CategoryWiseVideoListScreenArgs screenArgs;

  ///Service configurations
  @override
  void initState() {
    _view = this;
    paginationController.onLoadMore = _onLoadMoreItems;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //====================Stream Controller=====================

  late ServiceState serviceState = ServiceState();
  PaginatedListViewController<CategoryEntity> paginationController =
      PaginatedListViewController();

  final AppStreamController<PaginatedListViewController<CategoryEntity>>
      videoListStreamController = AppStreamController();

  ///Load enrolled course list

  void loadInitialData(String categoryId) {

    ///Loading state
    if (!mounted) return;
    paginationController.clear();
    videoListStreamController.add(LoadingState());
    CategoryGateway.getCategoryWiseVideoListWithPagination(
      serviceState.getPaginatedUrlSegment(paginationController.pageSize, 1,),categoryId
    ).then((value) {
      if (!mounted) return;

      ///Data loaded state
      if (value.status == Status.success && value.data!.total > 0) {
        paginationController.setTotalItemCount(value.data!.total);
        paginationController.addItems(value.data!.records);
        videoListStreamController.add(DataLoadedState(paginationController));
      }

      ///Empty state
      else if (value.status == Status.success && value.data!.total <= 0) {
        videoListStreamController.add(EmptyState(
            message:
                "No video bookmarked"));
      }

      ///Error state
      else {
        ///Try reloading
        _view.showWarning(value.message);
        Future.delayed(Duration(seconds: AppConstant.reloadInSeconds))
            .then((value) {
          if (mounted) loadInitialData(screenArgs.categoryId);
        });
      }
    });
  }

  ///Load more data

  Future<bool> _onLoadMoreItems(int nextPage) async {
    Completer<bool> _completer = Completer();
    CategoryGateway.getCategoryWiseVideoListWithPagination(
      serviceState.getPaginatedUrlSegment(
        paginationController.pageSize,
        paginationController.nextPage,
      ),screenArgs.categoryId
    ).asStream().listen((value) {
      if (!mounted) return;

      ///Data loaded state
      if (value.status == Status.success && value.data!.total > 0) {
        paginationController.setTotalItemCount(value.data!.total);
        paginationController.addItems(value.data!.records);
        _completer.complete(true);
      }

      ///Error state
      else {
        ///Try reloading
        _view.showWarning(value.message);
        _completer.complete(false);
      }
    });

    return _completer.future;
  }
}
