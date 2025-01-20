import 'dart:async';
import 'package:co_learning_mobile_app/src/feature/bookmark/models/chapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../common/constants/app_constant.dart';
import '../../../common/models/action_result.dart';
import '../../../common/routes/app_route_args.dart';
import '../../../common/widgets/app_stream.dart';
import '../../bookmark/gateway/bookamark_gateway.dart';
import '../../bookmark/models/bookmark_entity.dart';
import '../../bookmark/models/feedback.dart';
import '../../bookmark/models/form_category.dart';
import '../../feedback_score/gateways/feedback_score_gateway.dart';
import '../../feedback_score/models/feedback_score_entity.dart';
import '../gateways/video_gateway.dart';
import '../models/comment_entity.dart';
import '../models/video_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
  void navigateToBack();
  bool isPlayerFullscreen();
  void changeOrientationToPortrait();
  void navigateToGiveFeedbackScoreScreen(
      String videoId, FeedbackEntity feedback);
  void navigateToFeedbackScoreListScreen(String videoId);
  void navigateToFeedbackScoreDetailsScreen(
      String videoId, String feedbackScoreId);
}

mixin VideoDetailsScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  late VideoDetailsScreenArgs screenArgs;

  int selectedCategoryId = 0;
  int selectedTypeId = 0;

  late VideoEntity videoData;
  String videoStartTime = "";
  String videoEndTime = "";

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
    // bookmarkStreamController.dispose();
    playerStreamController.dispose();
    playbackPausePlayStreamController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    videoDetailsStreamController.dispose();
    commentStreamController.dispose();
    feedbackScoreStreamController.dispose();
    super.dispose();
  }

  ///private fields
  late String _screenArgs;

  // final AppStreamController<bool> bookmarkStreamController =
  // AppStreamController();
  final AppStreamController<VideoContentViewModel> playerStreamController =
      AppStreamController();
  final AppStreamController<bool> playbackPausePlayStreamController =
      AppStreamController();

  final AppStreamController<VideoEntity> videoDetailsStreamController =
      AppStreamController();
  final AppStreamController<List<CommentEntity>> commentStreamController =
      AppStreamController();
  final AppStreamController<List<FeedbackScoreEntity>>
      feedbackScoreStreamController = AppStreamController();
  final AppStreamController<Duration> onPlayedStreamController =
      AppStreamController();
  final StreamController<ChapterEntity> chapterEntityController=  StreamController<ChapterEntity>.broadcast();
  ChapterEntity initialSelectedChapter=ChapterEntity.empty();


  ///Load Video Details Data
  void loadInitialData(String videoId) {
    ///Loading state
    if (!mounted) return;

    videoDetailsStreamController.add(LoadingState());

    try {
      VideoGateway.getVideoDetails(videoId).then((value) {
        ///Data loaded state
        if (value.status == Status.success) {
          videoData = value.data!;
          videoDetailsStreamController
              .add(DataLoadedState<VideoEntity>(value.data!));
          _onPlayVideo(value.data!);
        }

        ///Error state
        else {
          ///Try reloading
          Future.delayed(Duration(seconds: AppConstant.reloadInSeconds))
              .then((value) {
            if (mounted) loadInitialData(videoId);
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  ///Load Comment Data
  void loadCommentData(String videoId) {
    ///Loading state
    if (!mounted) return;

    commentStreamController.add(LoadingState());

    try {
      VideoGateway.getVideoComments(videoId).then((value) {
        ///Data loaded state
        if (value.status == Status.success) {
          commentStreamController
              .add(DataLoadedState<List<CommentEntity>>(value.data!));
        }

        ///Error state
        else {
          ///Try reloading
          Future.delayed(Duration(seconds: AppConstant.reloadInSeconds))
              .then((value) {
            if (mounted) loadCommentData(videoId);
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  ///Do Comment
  Future<ActionResult<CommentEntity>> doComment(String formId, int categoryId,
      int typeId, String videoId, String startTime, String endTime) async {
    return VideoGateway.doComment(
            formId, categoryId, typeId, videoId, startTime, endTime)
        .then((value) {
      if (value.status != Status.success) {
        _view.showWarning(value.message);
      } else {
        _view.showSuccess(value.message);
      }
      return value;
    });
  }

  ///Do Comment
  Future<ActionResult<BookmarkEntity>> doBookmark(String videoId) async {
    return BookmarkGateway.doBookmark(videoId).then((value) {
      if (value.status != Status.success) {
        _view.showWarning(value.message);
      } else {
        videoData.isBookmarked = !videoData.isBookmarked;
        videoDetailsStreamController
            .add(DataLoadedState<VideoEntity>(videoData));
        _view.showSuccess(value.message);
        // setState(() {
        //   loadInitialData(videoId);
        // });
      }
      return value;
    });
  }

  ///Load Feedback Score Data
  void loadFeedbackScoreData(String videoId) {
    ///Loading state
    if (!mounted) return;

    feedbackScoreStreamController.add(LoadingState());

    try {
      FeedbackScoreGateway.getFeedbackScoreList(videoId).then((value) {
        ///Data loaded state
        if (value.status == Status.success) {
          feedbackScoreStreamController
              .add(DataLoadedState<List<FeedbackScoreEntity>>(value.data!));
        }

        ///Error state
        else {
          ///Try reloading
          Future.delayed(Duration(seconds: AppConstant.reloadInSeconds))
              .then((value) {
            if (mounted) loadFeedbackScoreData(videoId);
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  ///Load or re-load course details
  /*void loadInitialData(String args) {
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
  }*/

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
  void _onPlayVideo(VideoEntity content) async {
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
    var videoContent = VideoContentViewModel.fromJson(content.toJson());
    playerStreamController
        .add(DataLoadedState<VideoContentViewModel>(videoContent));
  }

  String formatDuration(int totalSeconds) {
    // Calculate hours, minutes, and seconds
    int hours = totalSeconds ~/ 3600; // Divide by 3600 to get hours
    int minutes = (totalSeconds % 3600) ~/ 60; // Get the remaining minutes
    int seconds = totalSeconds % 60; // Get the remaining seconds

    // Format the output as "hh:mm:ss" with leading zeros if necessary
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void onPlaybackProgressChanged(double playedPosition, double totalDuration) {
    // ///Update last played position only if played position is larger
    int playedPositionSec = (playedPosition ~/ 1000).round();
    videoStartTime = formatDuration(playedPositionSec);
    videoEndTime = formatDuration(playedPositionSec + 10);


    // print(
    //     'VideoDetailsScreenService.onPlaybackProgressChanged$videoStartTime$videoEndTime');
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

  void onTapGiveScore(String videoId, FeedbackEntity feedback) {
    _view.navigateToGiveFeedbackScoreScreen(videoId, feedback);
  }

  void onTapScoreViewAll(String videoId) {
    _view.navigateToFeedbackScoreListScreen(videoId);
  }

  void onTapScoreDetails(String videoId, String feedbackScoreId) {
    _view.navigateToFeedbackScoreDetailsScreen(videoId, feedbackScoreId);
  }
}

class VideoContentViewModel extends VideoEntity {
  VideoContentViewModel.fromJson(super.json) : super.fromJson();
  VideoContentViewModel.empty() : super.empty();
}
