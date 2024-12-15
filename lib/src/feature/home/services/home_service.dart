import 'package:flutter/material.dart';

import '../../../common/constants/app_constant.dart';
import '../../../common/models/action_result.dart';
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

  @override
  void initState() {
    _view = this;
    super.initState();
    loadInitialData();
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
    homeStreamController.add(LoadingState<HomeEntity>());
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
        });      }
    });
  }

  void onTap(int taskId) {
    _view.navigateToTaskDetailsScreen(taskId);
  }
}
