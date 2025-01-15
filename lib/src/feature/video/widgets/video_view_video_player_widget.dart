import 'dart:async';
import 'package:co_learning_mobile_app/src/feature/bookmark/models/chapter.dart';
import 'package:co_learning_mobile_app/src/feature/video/models/video_entity.dart';

import '../../../common/widgets/app_stream.dart';
import '../services/video_details_screen_service.dart';
import 'video_view_player_widget.dart';
import 'package:flutter/material.dart';

class VideoViewPlayerWidget extends StatefulWidget {
  final Stream<DataState<VideoContentViewModel>> playerStream;
  final List<ChapterEntity> chapters;
  final Stream<DataState<bool>> playbackStream;
  final Stream<DataState<Duration>>? playedPositionStream;
  final Widget? overlay;
  final VoidCallback? onTapChapter;

  final double Function(
      double seekPosition, double totalDuration)? interceptSeekTo;
  final void Function(
      double playedPosition, double totalDuration)? onProgressChanged;
  final void Function( Duration videoTotalDuration)? onTotalVideoDuration;

  const VideoViewPlayerWidget({
    super.key,
    required this.playerStream,
    required this.playbackStream,
    this.onTapChapter,
    this.playedPositionStream,
    this.overlay,
    this.interceptSeekTo,
    this.onProgressChanged, this.onTotalVideoDuration, required this.chapters,
  });

  @override
  _VideoViewPlayerWidgetState createState() => _VideoViewPlayerWidgetState();
}

class _VideoViewPlayerWidgetState extends State<VideoViewPlayerWidget> {
  final VideoViewRawVideoPlayerController _playerController = VideoViewRawVideoPlayerController();

  VideoContentViewModel _currentContent = VideoContentViewModel.empty();
  StreamSubscription<DataState<VideoContentViewModel>>? _subscription;
  StreamSubscription<DataState<bool>>? _playbackSubscription;
  StreamSubscription<DataState<Duration>>? _playedPositionSubscription;

  @override
  void initState() {
    _playerController.totalDuration=_totalVideoDuration;
    _playerController.interceptSeekTo = _interceptSeekTo;
    _playerController.onProgressChange = _onProgressChanged;
    _subscription = widget.playerStream.listen(_onPlayVideo);
    _playbackSubscription = widget.playbackStream.listen(_onPlaybackChange);
    _playedPositionSubscription=widget.playedPositionStream?.listen(_onPlayedPosition);
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _playerController.dispose();
    _playbackSubscription?.cancel();
    _playedPositionSubscription?.cancel();
    super.dispose();
  }

  void _onPlayVideo(DataState<VideoEntity> event) {
    if (!mounted) return;
    _currentContent = (event as DataLoadedState<VideoContentViewModel>).data;
    _playerController.play(_currentContent.videoUrl,
      autoPlay: true,
      // playPosition:
      // _currentContent.video.lastStudyTime < _currentContent.video.duration
      //     ? Duration(seconds: _currentContent.video.lastStudyTime)
      //     : null,
    );
  }
  void _onPlayedPosition(DataState<Duration> event) {
    _playerController.onPlayedPosition((event as DataLoadedState<Duration>).data);
  }

  void _onPlaybackChange(DataState<bool> event) {
    var data = (event as DataLoadedState<bool>).data;
    if (data) {
      _playerController.resume();
    } else {
      _playerController.pause();
    }
  }

  double _interceptSeekTo(double seekPosition, double totalDuration) {
    return widget.interceptSeekTo
        ?.call( seekPosition, totalDuration) ??
        seekPosition;
  }

  void _onProgressChanged(double playedPosition, double totalDuration) {
    widget.onProgressChanged
        ?.call( playedPosition, totalDuration);
  }
  void _totalVideoDuration(Duration? duration){
    widget.onTotalVideoDuration?.call(duration!);
  }

  @override
  Widget build(BuildContext context) {
    return VideoViewRawVideoPlayer(
      controller: _playerController,
      chapters: widget.chapters,
      onTapChapter: (){
        widget.onTapChapter?.call();
      },
      aspectRatio: 16/9,
      overlay: Align(alignment: Alignment.topLeft, child: widget.overlay),
    );
  }
}