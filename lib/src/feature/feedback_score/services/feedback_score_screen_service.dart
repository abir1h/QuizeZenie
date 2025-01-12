import 'dart:async';

import 'package:flutter/material.dart';

import '../../../common/constants/app_constant.dart';
import '../../../common/models/action_result.dart';
import '../../../common/models/page_service.dart';
import '../../../common/routes/app_route_args.dart';
import '../../../common/widgets/app_stream.dart';
import '../../../common/widgets/paginated_list_view.dart';
import '../gateways/feedback_score_gateway.dart';
import '../models/feedback_score_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
  void navigateToFeedbackScoreDetailsScreen(
      String videoId, String feedbackScoreId);
}

mixin FeedbackScoreScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  late FeedbackScoreArgs screenArgs;

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

  late ServiceState serviceState = ServiceState();
  PaginatedListViewController<FeedbackScoreEntity> paginationController =
      PaginatedListViewController();

  final AppStreamController<PaginatedListViewController<FeedbackScoreEntity>>
      feedbackScoreStreamController = AppStreamController();

  ///Load enrolled course list

  void loadInitialData(String videoId) {
    ///Loading state
    if (!mounted) return;
    paginationController.clear();
    feedbackScoreStreamController.add(LoadingState());
    FeedbackScoreGateway.getFeedbackScoreListWithPagination(
      serviceState.getPaginatedUrlSegmentForFeedback(
          videoId, paginationController.pageSize, 1),
    ).then((value) {
      if (!mounted) return;

      ///Data loaded state
      if (value.status == Status.success && value.data!.total > 0) {
        paginationController.setTotalItemCount(value.data!.total);
        paginationController.addItems(value.data!.records);
        feedbackScoreStreamController
            .add(DataLoadedState(paginationController));
      }

      ///Empty state
      else if (value.status == Status.success && value.data!.total <= 0) {
        feedbackScoreStreamController
            .add(EmptyState(message: "No video bookmarked"));
      }

      ///Error state
      else {
        ///Try reloading
        _view.showWarning(value.message);
        Future.delayed(Duration(seconds: AppConstant.reloadInSeconds))
            .then((value) {
          if (mounted) loadInitialData(videoId);
        });
      }
    });
  }

  ///Load more data

  Future<bool> _onLoadMoreItems(int nextPage) async {
    Completer<bool> _completer = Completer();
    FeedbackScoreGateway.getFeedbackScoreListWithPagination(
      serviceState.getPaginatedUrlSegmentForFeedback(
        screenArgs.videoId,
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

  void onTapScoreDetails(String videoId, String feedbackScoreId) {
    _view.navigateToFeedbackScoreDetailsScreen(videoId, feedbackScoreId);
  }
}
