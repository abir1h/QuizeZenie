import 'package:flutter/material.dart';
import '../../../common/models/action_result.dart';
import '../../../common/widgets/app_stream.dart';
import '../../bookmark/models/chapter.dart';
import '../gateways/video_gateway.dart';

abstract class _ViewModel {}

mixin CreateChapterBottomSheetScreenServices<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;
  final AppStreamController<List<ChapterEntity>> chapterStreamController =
      AppStreamController();

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<ActionResult<List<ChapterEntity>>> doCrateChapter(
      String title, String videoId, int time) async {
    return VideoGateway.chapterCreateAction(title, videoId, 23).then((value) {
      if (value.status != Status.success) {}
      return value;
    });
  }
}
