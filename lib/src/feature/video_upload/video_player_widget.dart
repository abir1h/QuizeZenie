import 'dart:async';
import 'package:co_learning_mobile_app/src/feature/video_upload/player_widget.dart';
import 'package:co_learning_mobile_app/src/feature/video_upload/video_upload_screen_service.dart';
import 'package:flutter/material.dart';
import '../../common/widgets/app_stream.dart';

class PreviewPlayerWidget extends StatefulWidget {
  final Stream<DataState<VideoContentViewModel>> playerStream;
  final Stream<DataState<bool>> playbackStream;
  final Widget? overlay;

  final double Function(VideoContentViewModel currentContent,
      double seekPosition, double totalDuration)? interceptSeekTo;
  final void Function(VideoContentViewModel currentContent,
      double playedPosition, double totalDuration)? onProgressChanged;

  const PreviewPlayerWidget({
    super.key,
    required this.playerStream,
    required this.playbackStream,
    this.overlay,
    this.interceptSeekTo,
    this.onProgressChanged,
  });

  @override
  _PreviewPlayerWidgetState createState() => _PreviewPlayerWidgetState();
}

class _PreviewPlayerWidgetState extends State<PreviewPlayerWidget> {
  final PreviewRawVideoPlayerController _playerController = PreviewRawVideoPlayerController();

  VideoContentViewModel _currentContent = VideoContentViewModel.empty();
  StreamSubscription<DataState<VideoContentViewModel>>? _subscription;
  StreamSubscription<DataState<bool>>? _playbackSubscription;

  @override
  void initState() {
    _playerController.interceptSeekTo = _interceptSeekTo;
    _playerController.onProgressChange = _onProgressChanged;
    _subscription = widget.playerStream.listen(_onPlayVideo);
    _playbackSubscription = widget.playbackStream.listen(_onPlaybackChange);
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _playerController.dispose();
    _playbackSubscription?.cancel();
    super.dispose();
  }

  void _onPlayVideo(DataState<ContentDetailsEntity> event) {
    if (!mounted) return;
    _currentContent = (event as DataLoadedState<VideoContentViewModel>).data;
    _playerController.play(
      _currentContent.videoPath,
      autoPlay: true,
      // playPosition:
      // _currentContent.video.lastStudyTime < _currentContent.video.duration
      //     ? Duration(seconds: _currentContent.video.lastStudyTime)
      //     : null,
    );
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
        ?.call(_currentContent, seekPosition, totalDuration) ??
        seekPosition;
  }

  void _onProgressChanged(double playedPosition, double totalDuration) {
    widget.onProgressChanged
        ?.call(_currentContent, playedPosition, totalDuration);
  }

  @override
  Widget build(BuildContext context) {
    return PreviewRawVideoPlayer(
      controller: _playerController,
      overlay: Align(alignment: Alignment.topLeft, child: widget.overlay),
    );
  }
}