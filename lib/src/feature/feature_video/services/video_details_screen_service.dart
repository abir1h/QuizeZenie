import 'package:co_learning_mobile_app/src/common/routes/app_route_args.dart';
import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../common/constants/app_constant.dart';
import '../../../common/models/action_result.dart';
import '../gateways/video_details_screen_gateway.dart';

abstract class _ViewModel {}

mixin VideoDetailsScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  late VideoDetailsScreenArgs _screenArgs;

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
  }

  ///Load or re-load course details
  void loadInitialData(VideoDetailsScreenArgs args) {
    if (!mounted) return;
    _screenArgs = args;

    VideoDetailsGateway.getVideoDetails(_screenArgs.videoId).then((value) {
      ///Data loaded state
      if (value.status == Status.success) {
      }

      ///Error state
      else {
        ///Try reloading

        Future.delayed(Duration(seconds: AppConstant.reloadInSeconds))
            .then((value) {});
      }
    });
  }
}
