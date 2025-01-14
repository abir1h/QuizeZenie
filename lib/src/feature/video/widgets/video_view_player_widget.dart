import 'dart:async';
import 'dart:io';
import 'package:co_learning_mobile_app/src/common/utility/app_label.dart';
import 'package:co_learning_mobile_app/src/feature/bookmark/models/chapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoViewRawVideoPlayerController {
  void Function(String url, Duration? playPosition, bool? autoPlay)? _onPlay;
  void Function()? _onTogglePausePlay;
  void Function()? _onPause;
  void Function()? _onResume;
  void Function(double playedPosition, double totalDuration)? onProgressChange;
  void Function(Duration? totalDuration)? totalDuration;
  double Function(double seekPosition, double totalDuration)? interceptSeekTo;

  void play(
    String url, {
    bool autoPlay = false,
    Duration? playPosition,
  }) {
    _onPlay?.call(url, playPosition, autoPlay);
  }

  void togglePausePlay() {
    _onTogglePausePlay?.call();
  }

  void pause() {
    _onPause?.call();
  }

  void resume() {
    _onResume?.call();
  }

  void dispose() {
    _onPlay = null;
    _onTogglePausePlay = null;
    onProgressChange = null;
    interceptSeekTo = null;
    _onPause = null;
    _onResume = null;
  }
}

class VideoViewRawVideoPlayer extends StatefulWidget {
  final VideoViewRawVideoPlayerController controller;
  final Widget? overlay;
  final double aspectRatio;
  final List<ChapterEntity> chapters;
  const VideoViewRawVideoPlayer({
    super.key,
    required this.controller,
    this.overlay,
    this.aspectRatio = 16 / 9,
    required this.chapters,
  });

  @override
  _VideoViewRawVideoPlayerState createState() =>
      _VideoViewRawVideoPlayerState();
}

class _VideoViewRawVideoPlayerState extends State<VideoViewRawVideoPlayer> {
  final StreamController<String> _uiRefreshController =
      StreamController.broadcast();
  Sink<String>? get _uiRefreshSink =>
      _uiRefreshController.isClosed ? null : _uiRefreshController.sink;
  VideoPlayerController? _controller;
  Timer? _hideTimer;
  double _playedPosition = 0;
  double _videoDuration = 0;
  double _sliderValue = 0;
  bool _sliderInProgress = false;
  bool _controlVisible = true;
  bool _loadingError = false;
  List<double> _chapterPositions = [];

  double convertSecondsToMilliseconds(int seconds) {
    // Convert to milliseconds by multiplying by 1000
    return seconds * 1000.0; // Result will be a double
  }

  @override
  void initState() {
    super.initState();
    widget.controller._onPlay = _onPlayNewVideo;
    widget.controller._onPause = _pause;
    widget.controller._onResume = _resume;
    widget.controller._onTogglePausePlay = _togglePausePlay;

    widget.controller.totalDuration = (duration) {
      if (duration != null) {
        _chapterPositions = widget.chapters
            .map((chapter) =>
                convertSecondsToMilliseconds(chapter.startTimeSeconds))
            .toList();
      }
    };
  }

  @override
  void dispose() {
    widget.controller.dispose();
    _controller?.removeListener(_playerStateListener);
    _controller?.dispose();
    _uiRefreshController.close();
    _hideTimer?.cancel();
    super.dispose();
  }

  void _onPlayNewVideo(
      String url, Duration? playPosition, bool? autoPlay) async {
    try {
      await _controller?.dispose();
    } catch (_) {}
    _controller = null;
    _loadingError = false;
    _playedPosition = 0;
    _videoDuration = 0;
    _sliderValue = 0;
    _sliderInProgress = false;
    _controlVisible = true;
    _loadingError = false;
    if (mounted) {
      setState(() {
        debugPrint("New file played");
      });
    }
    if (url.isEmpty) return;

    _controller = VideoPlayerController.network(url);
    _controller?.addListener(_playerStateListener);
    _controller?.initialize().then((value) {
      if (_controller!.value.isInitialized) {
        widget.controller.totalDuration?.call(_controller?.value.duration);
      }
      if ((autoPlay ?? false) &&
          (_controller?.value.isInitialized ?? false) &&
          !_controller!.value.isPlaying) {
        _togglePausePlay();
      }
      if (playPosition != null && (_controller?.value.isInitialized ?? false)) {
        if (_controller!.value.duration > playPosition) {
          _seekToPosition(playPosition.inMilliseconds.toDouble());
        }
      }
    }).catchError((value) {
      _loadingError = true;
      _controlVisible = true;
    }).whenComplete(() {
      if (mounted) setState(() {});
    });
  }

  void _playerStateListener() {
    if (_controller != null && _controller!.value.isInitialized) {
      _playedPosition =
          (_controller?.value.position.inMilliseconds.toDouble() ?? 0.0);
      _videoDuration =
          (_controller?.value.duration.inMilliseconds.toDouble() ?? 0.0);
      widget.controller.onProgressChange?.call(_playedPosition, _videoDuration);

      ///Update player progress
      if (!_sliderInProgress) {
        _sliderValue = _playedPosition;
        if (_sliderValue > _videoDuration) {
          _sliderValue = _videoDuration;
        }

        ///Video played complete
        if (_videoDuration > 0 && _videoDuration == _playedPosition) {
          _sliderValue = 0;
          _playedPosition = 0;
          _controlVisible = true;
        }
      }
    } else {
      _sliderValue = 0;
      _playedPosition = 0;
      _videoDuration = 0;
      widget.controller.onProgressChange?.call(_playedPosition, _videoDuration);
    }
    _uiRefreshSink?.add("refresh");
  }

  void _toggleOrientation() {
    if (mounted) {
      setState(() {
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
        } else {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
          ]);
        }
      });
    }
  }

  void _toggleControlVisibility() {
    _controlVisible = !_controlVisible;
    _uiRefreshSink?.add("refresh");
    if (_controlVisible && (_controller?.value.isPlaying ?? false)) {
      cancelAndRestartTimer();
    } else {
      _hideTimer?.cancel();
    }
  }

  void _togglePausePlay() {
    if (_controller != null && _controller!.value.isInitialized) {
      if (_controller!.value.isPlaying) {
        _pause();
      } else {
        _resume();
      }
    }
  }

  void _pause() {
    if (_controller != null && _controller!.value.isInitialized) {
      if (_controller!.value.isPlaying) {
        _controller!.pause().whenComplete(() {
          _controlVisible = true;
          _hideTimer?.cancel();
        });
      }
      _uiRefreshSink?.add("refresh");
    }
  }

  void _resume() {
    if (_controller != null && _controller!.value.isInitialized) {
      if (!_controller!.value.isPlaying) {
        _controller!.play().whenComplete(() {
          cancelAndRestartTimer();
        });
      }
      _uiRefreshSink?.add("refresh");
    }
  }

  void _seekToPosition(double value) {
    _sliderInProgress = true;
    _sliderValue = value;
    _uiRefreshSink?.add("refresh");
    if (_controller != null &&
        _controller!.value.isInitialized &&
        _playedPosition != value) {
      _controller
          ?.seekTo(Duration(milliseconds: _sliderValue.toInt()))
          .whenComplete(() {
        _sliderInProgress = false;
        cancelAndRestartTimer();
      });
    } else {
      _sliderInProgress = false;
    }
  }

  void cancelAndRestartTimer() {
    _hideTimer?.cancel();
    _startHideTimer();
  }

  void _startHideTimer() {
    _controlVisible = true;
    _uiRefreshSink?.add("refresh");
    _hideTimer = Timer(const Duration(seconds: 3), () {
      _controlVisible = false;
      _uiRefreshSink?.add("refresh");
    });
  }

  String formatDuration(Duration position) {
    final ms = position.inMilliseconds;

    int seconds = ms ~/ 1000;
    final int hours = seconds ~/ 3600;
    seconds = seconds % 3600;
    final minutes = seconds ~/ 60;
    seconds = seconds % 60;

    final hoursString = hours >= 10
        ? '$hours'
        : hours == 0
            ? '0'
            : '0$hours';

    final minutesString = minutes >= 10
        ? '$minutes'
        : minutes == 0
            ? '0'
            : '0$minutes';

    final secondsString = seconds >= 10
        ? '$seconds'
        : seconds == 0
            ? '00'
            : '0$seconds';

    final formattedTime =
        '${hoursString == '0' ? '' : '$hoursString:'}$minutesString:$secondsString';

    return formattedTime;
  }

  static const List<double> _examplePlaybackRates = <double>[
    1.0,
    1.25,
    1.5,
  ];
  @override
  Widget build(BuildContext context) {
    return OrientationDetectorWidget(
      aspectRatio: widget.aspectRatio,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ///Background color
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: Colors.black,
          ),

          ///Actual video player
          if (_controller?.value.isInitialized ?? false)
            Center(
              child: AspectRatio(
                aspectRatio: widget.aspectRatio,
                child: VideoPlayer(
                  _controller!,
                ),
              ),
            ),

          ///Player controls
          StreamBuilder<String>(
              stream: _uiRefreshController.stream,
              builder: (context, snapshot) {
                ///Error view
                if (_loadingError) {
                  return Container(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    color: Colors.black.withOpacity(0.6),
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.error,
                            color: Colors.white,
                            size: 32,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Loading failed!",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return GestureDetector(
                  onTap: _toggleControlVisibility,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: _controlVisible ||
                            (_controller?.value.isBuffering ?? false)
                        ? 1
                        : 0.0,
                    child: Container(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      color: Colors.black.withOpacity(0.6),
                      child: IgnorePointer(
                        ignoring: !_controlVisible,
                        child: Stack(
                          children: [
                            ///Loading control
                            if (!(_controller?.value.isInitialized ?? false) ||
                                (_controller?.value.isBuffering ?? false))
                              const Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 64,
                                  width: 64,
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                    strokeWidth: 3,
                                  ),
                                ),
                              ),

                            ///Play or Pause control
                            if ((_controller?.value.isInitialized ?? false) &&
                                !(_controller?.value.isBuffering ?? false))
                              Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: _togglePausePlay,
                                  child: Container(
                                    height: 64,
                                    width: 64,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 3,
                                        )),
                                    child: FittedBox(
                                      child: Icon(
                                        _controller!.value.isPlaying
                                            ? Icons.pause_rounded
                                            : Icons.play_arrow_rounded,
                                        size: 64,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            ///Bottom bar controls
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 16, bottom: 8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ///Progress slider
                                    Row(
                                      children: [
                                        Expanded(
                                          child: SliderTheme(
                                            data: SliderThemeData(
                                              thumbShape: RoundSliderThumbShape(
                                                  enabledThumbRadius: 6),
                                              overlayShape:
                                                  RoundSliderOverlayShape(
                                                      overlayRadius: 12.0),
                                              trackShape: ChapterTrackShape(
                                                chapters: widget.chapters,
                                                videoDuration: _videoDuration,
                                              ),
                                              trackHeight: 4,
                                              overlayColor: Colors.transparent,
                                              thumbColor: Colors.white,
                                              activeTrackColor: Colors.white,
                                              inactiveTrackColor: Colors.grey,
                                            ),
                                            child: Slider(
                                              min: 0,
                                              max: _videoDuration,
                                              activeColor: Colors.red,
                                              inactiveColor:
                                                  Colors.grey.withOpacity(.8),
                                              value: _sliderValue,
                                              onChangeStart: (x) {
                                                _sliderInProgress = true;
                                                _sliderValue = x;
                                                _controlVisible = true;
                                                _uiRefreshSink?.add("refresh");
                                              },
                                              onChanged: (x) {
                                                _controlVisible = true;
                                                if (widget.controller
                                                        .interceptSeekTo !=
                                                    null) {
                                                  double _value = widget
                                                          .controller
                                                          .interceptSeekTo!(
                                                      x, _videoDuration);
                                                  assert(
                                                      _value <= _videoDuration,
                                                      "Seek to value can't be greater than video duration");
                                                  _sliderValue = _value;
                                                } else {
                                                  _sliderValue = x;
                                                }
                                                _uiRefreshSink?.add("refresh");
                                              },
                                              onChangeEnd: (x) {
                                                if (widget.controller
                                                        .interceptSeekTo !=
                                                    null) {
                                                  double _value = widget
                                                          .controller
                                                          .interceptSeekTo!(
                                                      x, _videoDuration);
                                                  assert(
                                                      _value <= _videoDuration,
                                                      "Seek to value can't be greater than video duration");
                                                  _sliderValue = _value;
                                                  _seekToPosition(_sliderValue);
                                                } else {
                                                  _sliderValue = x;
                                                  _seekToPosition(_sliderValue);
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    ///Content duration and played duration
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            "${formatDuration(Duration(milliseconds: _sliderValue.toInt()))} / ${formatDuration((_controller?.value.duration ?? const Duration()))}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        if (_getCurrentChapterName() != null)
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Icon(
                                              Icons.circle,
                                              color: Colors.white,
                                              size: 4,
                                            ),
                                          ),
                                        if (_getCurrentChapterName() != null)
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _getCurrentChapterName()!,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(width: 4),
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
                                                  color: Colors.white,
                                                  size: 14,
                                                )
                                              ],
                                            ),
                                          ),
                                        Spacer(),
                                        PopupMenuButton<double>(
                                          initialValue:
                                              _controller?.value.playbackSpeed,
                                          tooltip: 'Playback speed',
                                          onSelected: (double speed) {
                                            _controller
                                                ?.setPlaybackSpeed(speed);
                                          },
                                          itemBuilder: (BuildContext context) {
                                            return <PopupMenuItem<double>>[
                                              for (final double speed
                                                  in _examplePlaybackRates)
                                                PopupMenuItem<double>(
                                                  value: speed,
                                                  child: Text('${speed}x'),
                                                )
                                            ];
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Text(
                                              '${_controller?.value.playbackSpeed}x',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        VolumeControl(
                                          onValue: (value) {
                                            if (!value) {
                                              _controller?.setVolume(1.0);
                                            } else {
                                              _controller?.setVolume(0.0);
                                            }
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),

          ///User defined overlay
          if (widget.overlay != null)
            StreamBuilder<String>(
              stream: _uiRefreshController.stream,
              builder: (context, snapshot) {
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _controlVisible ||
                          (_controller?.value.isBuffering ?? false)
                      ? 1
                      : 0.0,
                  child: widget.overlay!,
                );
              },
            ),
        ],
      ),
    );
  }

  String? _getCurrentChapterName() {
    if (_controller == null || !_controller!.value.isInitialized) return null;

    final currentPosition = _sliderValue;
    for (int i = widget.chapters.length - 1; i >= 0; i--) {
      if (currentPosition >=
          convertSecondsToMilliseconds(widget.chapters[i].startTimeSeconds)) {
        return widget.chapters[i].title;
      }
    }
    return null;
  }
}

class OrientationDetectorWidget extends StatefulWidget {
  final double aspectRatio;
  final Widget child;
  const OrientationDetectorWidget(
      {super.key, required this.child, this.aspectRatio = 16 / 9});

  @override
  _OrientationDetectorWidgetState createState() =>
      _OrientationDetectorWidgetState();
}

class _OrientationDetectorWidgetState extends State<OrientationDetectorWidget> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      MediaQueryData _mediaQuery = MediaQuery.of(context);
      if (_mediaQuery.orientation == Orientation.portrait) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      }

      if (_mediaQuery.orientation == Orientation.portrait) {
        return AspectRatio(
          aspectRatio: widget.aspectRatio,
          child: widget.child,
        );
      } else {
        return SizedBox(
          height: _mediaQuery.size.height,
          width: _mediaQuery.size.width,
          child: widget.child,
        );
      }
    });
  }
}

class ChapterTrackShape extends SliderTrackShape with BaseSliderTrackShape {
  final List<ChapterEntity> chapters;
  final double videoDuration;

  const ChapterTrackShape({
    required this.chapters,
    required this.videoDuration,
  });

  double convertSecondsToMilliseconds(int seconds) {
    // Convert to milliseconds by multiplying by 1000
    return seconds * 1000.0; // Result will be a double
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
    Offset? secondaryOffset,
  }) {
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);

    // If the slider is disabled, use the disabled track colors
    final activeTrackColorTween = ColorTween(
      begin: sliderTheme.disabledActiveTrackColor,
      end: sliderTheme.activeTrackColor,
    );
    final inactiveTrackColorTween = ColorTween(
      begin: sliderTheme.disabledInactiveTrackColor,
      end: sliderTheme.inactiveTrackColor,
    );
    final activeTrackColor = activeTrackColorTween.evaluate(enableAnimation)!;
    final inactiveTrackColor =
        inactiveTrackColorTween.evaluate(enableAnimation)!;

    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    // Draw the inactive track
    final Paint inactivePaint = Paint()..color = inactiveTrackColor;
    final Paint activePaint = Paint()..color = activeTrackColor;

    final horizontalAdjustment = 2.0;
    final trackHeight = sliderTheme.trackHeight!;
    final trackLeft = trackRect.left + horizontalAdjustment;
    final trackTop = trackRect.top + (trackRect.height - trackHeight) / 2;
    final trackWidth = trackRect.width - 2 * horizontalAdjustment;
    final trackRectangle =
        Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);

    // Draw inactive track
    context.canvas.drawRect(trackRectangle, inactivePaint);

    // Draw active track
    final activeRect = Rect.fromLTWH(
      trackLeft,
      trackTop,
      thumbCenter.dx - trackLeft,
      trackHeight,
    );
    context.canvas.drawRect(activeRect, activePaint);

    // Draw chapter markers
    final Paint markerPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;

    for (var chapter in chapters) {
      final double markerPosition =
          convertSecondsToMilliseconds(chapter.startTimeSeconds) /
              videoDuration;
      final double markerX = trackLeft + (trackWidth * markerPosition);

      context.canvas.drawLine(
        Offset(markerX, trackTop - 2),
        Offset(markerX, trackTop + trackHeight + 2),
        markerPaint,
      );
    }
  }
}

class VolumeControl extends StatefulWidget {
  final ValueChanged<bool> onValue;
  const VolumeControl({super.key, required this.onValue});

  @override
  State<VolumeControl> createState() => _VolumeControlState();
}

class _VolumeControlState extends State<VolumeControl> {
  bool isVolumeMute = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (mounted) {
          setState(() {
            isVolumeMute = !isVolumeMute;
          });
          widget.onValue.call(isVolumeMute);
        }
      },
      child: Icon(
        !isVolumeMute ? Icons.volume_up : Icons.volume_off,
        color: Colors.white,
        size: 24,
      ),
    );
  }
}
