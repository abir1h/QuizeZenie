import 'package:flutter/material.dart';
import '../../../common/models/action_result.dart';
import '../../../common/widgets/app_stream.dart';
import '../../bookmark/models/chapter.dart';
import '../gateways/video_gateway.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin CreateChapterBottomSheetScreenServices<T extends StatefulWidget>
    on State<T> implements _ViewModel {
  late _ViewModel _view;
  final AppStreamController<List<ChapterEntity>> chapterStreamController =
      AppStreamController();
  TextEditingController titleController = TextEditingController();
  int? videoDuration;

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    titleController.clear();

    super.dispose();
  }

  Future<ActionResult<List<ChapterEntity>>> doCrateChapter(
      String title, String videoId, int time) async {
    return VideoGateway.chapterCreateAction(title, videoId, time).then((value) {
      if (value.status != Status.success) {
        _view.showWarning(value.message);
      }
      _view.showSuccess(value.message);

      return value;
    });
  }

  Future<ActionResult<List<ChapterEntity>>> chapterEdit(
      String title, int time, String chapterId) async {
    return VideoGateway.chapterEditAction(title, time, chapterId).then((value) {
      if (value.status != Status.success) {
         _view.showWarning(value.message);
      }
      _view.showSuccess(value.message);

      return value;
    });
  }
}
