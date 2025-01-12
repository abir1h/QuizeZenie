import 'package:flutter/material.dart';

import '../../../common/constants/app_constant.dart';
import '../../../common/models/action_result.dart';
import '../../../common/routes/app_route_args.dart';
import '../../../common/widgets/app_stream.dart';
import '../gateways/feedback_score_gateway.dart';
import '../models/feedback_score_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin GiveFeedbackScoreService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  late GiveScoreScreenArgs screenArgs;

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

  final AppStreamController<FeedbackScoreEntity> feedbackScoreStreamController =
      AppStreamController();

  ///Load Feedback Score Data
  // void loadFeedbackScoreData(String videoId) {
  //   ///Loading state
  //   if (!mounted) return;
  //
  //   feedbackScoreStreamController.add(LoadingState());
  //
  //   try {
  //     FeedbackScoreGateway.getFeedbackScoreList(videoId).then((value) {
  //       ///Data loaded state
  //       if (value.status == Status.success) {
  //         feedbackScoreStreamController
  //             .add(DataLoadedState<FeedbackScoreEntity>(value.data!));
  //       }
  //
  //       ///Error state
  //       else {
  //         ///Try reloading
  //         Future.delayed(Duration(seconds: AppConstant.reloadInSeconds))
  //             .then((value) {
  //           if (mounted) loadFeedbackScoreData(videoId);
  //         });
  //       }
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
