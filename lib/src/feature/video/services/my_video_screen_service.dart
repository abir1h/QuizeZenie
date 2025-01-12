import 'dart:async';
import '../gateways/video_gateway.dart';
import '../models/video_entity.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/app_constant.dart';
import '../../../common/models/action_result.dart';
import '../../../common/models/page_service.dart';
import '../../../common/widgets/app_stream.dart';
import '../../../common/widgets/paginated_list_view.dart';


abstract class _ViewModel {
  void showWarning(String message);
}

mixin MyVideoListScreenService<T extends StatefulWidget> on State<T>
implements _ViewModel {
  late _ViewModel _view;
  int categoryId = -1;

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
  PaginatedListViewController<VideoEntity> paginationController =
  PaginatedListViewController();

  final AppStreamController<PaginatedListViewController<VideoEntity>>
  videoStreamController = AppStreamController();

  ///Load enrolled course list

  void loadInitialData() {

    ///Loading state
    if (!mounted) return;
    paginationController.clear();
    videoStreamController.add(LoadingState());
    VideoGateway.getVideoListWithPagination(
      serviceState.getPaginatedUrlSegment(paginationController.pageSize, 1),
    ).then((value) {
      if (!mounted) return;

      ///Data loaded state
      if (value.status == Status.success && value.data!.total > 0) {
        paginationController.setTotalItemCount(value.data!.total);
        paginationController.addItems(value.data!.records);
        videoStreamController.add(DataLoadedState(paginationController));
      }

      ///Empty state
      else if (value.status == Status.success && value.data!.total <= 0) {
        videoStreamController.add(EmptyState(
            message:
            "No video bookmarked"));
      }

      ///Error state
      else {
        ///Try reloading
        _view.showWarning(value.message);
        Future.delayed(Duration(seconds: AppConstant.reloadInSeconds))
            .then((value) {
          if (mounted) loadInitialData();
        });
      }
    });
  }

  ///Load more data

  Future<bool> _onLoadMoreItems(int nextPage) async {
    Completer<bool> _completer = Completer();
    VideoGateway.getVideoListWithPagination(
      serviceState.getPaginatedUrlSegment(
        paginationController.pageSize,
        paginationController.nextPage,
      ),
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
