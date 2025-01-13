import 'package:flutter/material.dart';

import '../../../common/constants/app_constant.dart';
import '../../../common/models/action_result.dart';
import '../../../common/routes/app_route_args.dart';
import '../../../common/widgets/app_stream.dart';
import '../../bookmark/models/feedback.dart';
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
    super.dispose();
  }

  Future<ActionResult<List<FeedbackScoreEntity>>> giveScore(
      String videoId, FeedbackEntity feedbackEntity) async {
    return FeedbackScoreGateway.giveScore(videoId, feedbackEntity)
        .then((value) {
      if (value.status != Status.success) {
        _view.showWarning(value.message);
      } else {
        _view.showSuccess(value.message);
        // setState(() {
        //   loadCommentData(videoId);
        // });
      }
      return value;
    });
  }
}
