import 'dart:async';
import 'player_widget.dart';
import 'package:flutter/material.dart';
import '../../common/widgets/app_stream.dart';

class PreviewPlayerWidget extends StatefulWidget {
  final Stream<DataState<String>> playerStream;
  final Stream<DataState<bool>> playbackStream;
  final Widget? overlay;

  final double Function(
      double seekPosition, double totalDuration)? interceptSeekTo;
  final void Function(
      double playedPosition, double totalDuration)? onProgressChanged;
  final void Function( Duration videoTotalDuration)? onTotalVideoDuration;

  const PreviewPlayerWidget({
    super.key,
    required this.playerStream,
    required this.playbackStream,
    this.overlay,
    this.interceptSeekTo,
    this.onProgressChanged, this.onTotalVideoDuration,
  });

  @override
  _PreviewPlayerWidgetState createState() => _PreviewPlayerWidgetState();
}

class _PreviewPlayerWidgetState extends State<PreviewPlayerWidget> {
  final PreviewRawVideoPlayerController _playerController = PreviewRawVideoPlayerController();

  // VideoContentViewModel _currentContent = VideoContentViewModel.empty();
  StreamSubscription<DataState<String>>? _subscription;
  StreamSubscription<DataState<bool>>? _playbackSubscription;

  @override
  void initState() {
    _playerController.totalDuration=_totalVideoDuration;
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

  void _onPlayVideo(DataState<String> event) {
    if (!mounted) return;
    // _currentContent = (event as DataLoadedState<String>).data;
    _playerController.play(
      (event as DataLoadedState<String>).data,
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
    return PreviewRawVideoPlayer(
      controller: _playerController,
      overlay: Align(alignment: Alignment.topLeft, child: widget.overlay),
    );
  }
}