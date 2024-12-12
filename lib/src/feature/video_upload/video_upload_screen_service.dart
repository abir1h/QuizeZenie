import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../../common/widgets/app_stream.dart';


abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
  void navigateToBack();
  bool isPlayerFullscreen();
  void changeOrientationToPortrait();

}

mixin VideoDetailsScreenService<T extends StatefulWidget> on State<T>
implements _ViewModel {
  late _ViewModel _view;

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    ///Dispose all variables
    bookmarkStreamController.dispose();
    playerStreamController.dispose();
    playbackPausePlayStreamController.dispose();
    super.dispose();
  }

  ///private fields
  late String _screenArgs;

  final AppStreamController<bool> bookmarkStreamController =
  AppStreamController();
  final AppStreamController<String> playerStreamController =
  AppStreamController();
  final AppStreamController<bool> playbackPausePlayStreamController =
  AppStreamController();

  ///Load or re-load course details
  void loadInitialData(String args) {
    if (!mounted) return;
    _screenArgs = args;

    ///Loading state
    // pageDataStreamController.add(LoadingState<ContentDetailsEntity>());
    // CourseDetailsGateway.getContentDetailsData(_screenArgs.contentId)
    //     .then((value) {
      ///Data loaded state
      // if (value.status == Status.success) {
    //     pageDataStreamController
    //         .add(DataLoadedState<ContentDetailsEntity>(value.data!));
    //     onContentSelect(value.data!.allContents[0]);
    //   // }
    // });
    _onPlayVideo(args);
  }

  // ///Change video playback orientation
  // Future<bool> onGoBack() async {
  //   if (_view.isPlayerFullscreen()) {
  //     _view.changeOrientationToPortrait();
  //   } else {
  //     ///If currently playing video then save the study duration
  //     if (playerStreamController.value != null &&
  //         (playerStreamController.value
  //         as DataLoadedState<ContentDetailsEntity>)
  //             .data
  //             .type ==
  //             CourseContentType.video &&
  //         (playerStreamController.value
  //         as DataLoadedState<ContentDetailsEntity>)
  //             .data
  //             .id !=
  //             ContentDetailsEntity.empty().id) {
  //       playbackPausePlayStreamController.add(DataLoadedState<bool>(false));
  //       // await _syncContentStudyDuration((playerStreamController.value as DataLoadedState<ContentDetailsEntity>).data);
  //     }
  //
  //     ///Go back
  //     _view.navigateToBack();
  //   }
  //   return Future.value(false);
  // }


  ///Video playback section
  void _onPlayVideo(String content) async {
    ///Debounce click
    // if(playerStreamController.value != null && (playerStreamController.value as DataLoadedState<CourseDetailsContent>).data.id == content.id) {
    //   playbackPausePlayStreamController.add(DataLoadedState<bool>(true));
    //   return;
    // }

    // ///Activate player widget
    // playerActivationStreamController
    //     .add(DataLoadedState<ActivePlayerType>(content.video.rawUrl.isNotEmpty
    //     ? ActivePlayerType.solidVidePlayer
    //     : content.video.s3Url.isNotEmpty
    //     ? ActivePlayerType.hlsPlayer
    //     : content.video.youtubeUrl.isNotEmpty
    //     ? ActivePlayerType.youtubePlayer
    //     : ActivePlayerType.none));
    WakelockPlus.enable();

    ///Play the video
    // _isPlaybackComplete = false;
    // var videoContent = VideoContentViewModel.fromJson(content.toJson());
    playerStreamController
        .add(DataLoadedState<String>(content));
  }

  void onPlaybackProgressChanged(
      double playedPosition, double totalDuration) {
    // ///Update last played position only if played position is larger
    // int playedPositionSec = (playedPosition ~/ 1000).round();
    // if(currentContent.lastStudyTimeSec < playedPositionSec) {
    //   currentContent.lastStudyTimeSec = playedPositionSec;
    // }
    //
    // ///Detect if playback completed or not
    // if(!_isPlaybackComplete && playedPosition > 0 && playedPosition == totalDuration){
    //   _isPlaybackComplete = true;
    //
    //   _view.changeOrientationToPortrait();
    //   playerActivationStreamController.add(DataLoadedState<ActivePlayerType>(ActivePlayerType.none));
    //
    //   ///Sync study duration & unlock next content
    //   _syncContentStudyDuration(currentContent).then((value){
    //     if(value.nextUnlock){
    //       ///Unlock next content
    //       _reloadCourseDetails();
    //     }
    //   });
    // }
  }
  double onInterceptPlaybackSeekToPosition(
      double seekPosition, double totalDuration) {
    /// seekIntercept logic
    // return currentContent.lastStudyTimeSec * 1000 >= seekPosition ? seekPosition : (currentContent.lastStudyTimeSec * 1000).toDouble();
    return seekPosition;
  }

  ///HLS Player Service
  final StreamController<bool> _playerPausePlayStreamController =
  StreamController.broadcast();
  Stream<bool> get playerPausePlayStream =>
      _playerPausePlayStreamController.stream;

  void onSeekStart(int value) {
    print(value);
  }

  void onSeekEnd(int value) {
    print(value);
  }

  onUpdatePlayback(
      {required int currentPosition,
        required bool isEnded,
        required bool isPlaying,
        required int totalDuration}) {
    print(currentPosition);
  }
}


// class VideoContentViewModel extends ContentDetailsEntity {
//   VideoContentViewModel.fromJson(Map<String, dynamic> json)
//       : super.fromJson(json);
//   VideoContentViewModel.empty() : super.empty();
// }
//
// enum CourseContentType { video, script, mockTest, none }
//
//
//
// class ContentDetailsEntity {
//   late String videoPath;
//
//   ContentDetailsEntity({
//     required this.videoPath,
//   });
//
//   ContentDetailsEntity.empty() {
//     videoPath = "";
//
//   }
//
//   ContentDetailsEntity.fromJson(Map<String, dynamic> json) {
//     videoPath = videoPath;
//   }
//
//   Map<String, dynamic> toJson() => {
//     "videoPath": videoPath,
//   };
// }