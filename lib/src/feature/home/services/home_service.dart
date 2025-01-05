import 'package:flutter/material.dart';

import '../../../common/constants/app_constant.dart';
import '../../../common/models/action_result.dart';
import '../../../common/models/page_service.dart';
import '../../../common/widgets/app_stream.dart';
import '../gateways/home_gateway.dart';
import '../models/home_entity.dart';

abstract class _ViewModel {
  void navigateToTaskDetailsScreen(int taskId);
  void showWarning(String message);
  void showSuccess(String message);
}

mixin HomeService<T extends StatefulWidget> on State<T> implements _ViewModel {
  late _ViewModel _view;

  late ServiceState serviceState = ServiceState();

  @override
  void initState() {
    _view = this;
    loadInitialData();
    super.initState();
  }

  @override
  void dispose() {
    homeStreamController.dispose();
    super.dispose();
  }

  final AppStreamController<HomeEntity> homeStreamController =
      AppStreamController();

  void loadInitialData() {
    ///Loading state
    if (!mounted) return;

    homeStreamController.add(LoadingState());

    try {
      HomeGateway.getDashboardData().then((value) {
        ///Data loaded state
        if (value.status == Status.success) {
          homeStreamController.add(DataLoadedState<HomeEntity>(value.data!));
        }

        ///Error state
        else {
          ///Try reloading
          Future.delayed(Duration(seconds: AppConstant.reloadInSeconds))
              .then((value) {
            if (mounted) loadInitialData();
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void onTap(int taskId) {
    _view.navigateToTaskDetailsScreen(taskId);
  }
}
