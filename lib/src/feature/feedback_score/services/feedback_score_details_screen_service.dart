import 'package:flutter/material.dart';

import '../../../common/constants/app_constant.dart';
import '../../../common/models/action_result.dart';
import '../../../common/routes/app_route_args.dart';
import '../../../common/widgets/app_stream.dart';
import '../gateways/feedback_score_gateway.dart';
import '../models/feedback_score_details_entity.dart';
import '../models/feedback_score_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin FeedbackScoreDetailsScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  late FeedbackScoreArgs screenArgs;

  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    feedbackScoreStreamController.dispose();
    super.dispose();
  }

  final AppStreamController<FeedbackScoreDetailsEntity>
      feedbackScoreStreamController = AppStreamController();

  ///Load Feedback Score Data
  void loadFeedbackScoreData(String videoId, String scoreId) {
    ///Loading state
    if (!mounted) return;

    feedbackScoreStreamController.add(LoadingState());

    try {
      FeedbackScoreGateway.getFeedbackScoreDetails(videoId, scoreId)
          .then((value) {
        ///Data loaded state
        if (value.status == Status.success) {
          feedbackScoreStreamController
              .add(DataLoadedState<FeedbackScoreDetailsEntity>(value.data!));
        }

        ///Error state
        else {
          ///Try reloading
          Future.delayed(Duration(seconds: AppConstant.reloadInSeconds))
              .then((value) {
            if (mounted) loadFeedbackScoreData(videoId, scoreId);
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
