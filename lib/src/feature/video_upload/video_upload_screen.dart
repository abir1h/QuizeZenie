import 'dart:io';

import 'package:co_learning_mobile_app/src/common/widgets/app_scaffold.dart';
import 'package:co_learning_mobile_app/src/feature/video_upload/video_player_widget.dart';
import 'package:co_learning_mobile_app/src/feature/video_upload/video_upload_screen_service.dart';
import 'package:flutter/material.dart';

class VideoUploadScreen extends StatefulWidget {
  final File videoAssets;
  const VideoUploadScreen({super.key, required this.videoAssets});

  @override
  State<VideoUploadScreen> createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoUploadScreen>
    with VideoDetailsScreenService {
  @override
  void initState() {
    ///Initially load course details
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadInitialData(widget.videoAssets.path);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: "Video Upload",
        child: Column(
          children: [
            PreviewPlayerWidget(
              playerStream: playerStreamController.stream,
              playbackStream: playbackPausePlayStreamController.stream,
              onProgressChanged: onPlaybackProgressChanged,
              interceptSeekTo: onInterceptPlaybackSeekToPosition,
              // overlay: GestureDetector(
              //   onTap: onGoBack,
              //   child: const BackButtonWidget(),
              // ),
            )
          ],
        ));
  }

  @override
  void changeOrientationToPortrait() {
    // TODO: implement changeOrientationToPortrait
  }

  @override
  bool isPlayerFullscreen() {
    // TODO: implement isPlayerFullscreen
    throw UnimplementedError();
  }

  @override
  void navigateToBack() {
    // TODO: implement navigateToBack
  }

  @override
  void showSuccess(String message) {
    // TODO: implement showSuccess
  }

  @override
  void showWarning(String message) {
    // TODO: implement showWarning
  }
}
