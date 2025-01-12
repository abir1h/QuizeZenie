import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class PreviewRawVideoPlayerController {
  void Function(String url, Duration? playPosition, bool? autoPlay)? _onPlay;
  void Function()? _onTogglePausePlay;
  void Function()? _onPause;
  void Function()? _onResume;
  void Function(double playedPosition, double totalDuration)? onProgressChange;
  void Function(Duration?  totalDuration)? totalDuration;
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

class PreviewRawVideoPlayer extends StatefulWidget {
  final PreviewRawVideoPlayerController controller;
  final Widget? overlay;
  final double aspectRatio;
  const PreviewRawVideoPlayer(
      {super.key,
      required this.controller,
      this.overlay,
      this.aspectRatio = 16 / 9});

  @override
  _PreviewRawVideoPlayerState createState() => _PreviewRawVideoPlayerState();
}

class _PreviewRawVideoPlayerState extends State<PreviewRawVideoPlayer> {
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

  @override
  void initState() {
    super.initState();
    widget.controller._onPlay = _onPlayNewVideo;
    widget.controller._onPause = _pause;
    widget.controller._onResume = _resume;
    widget.controller._onTogglePausePlay = _togglePausePlay;
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

    _controller = VideoPlayerController.file(File(url));
    _controller?.addListener(_playerStateListener);
    _controller?.initialize().then((value) {
      if(_controller!.value.isInitialized){
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
      aspectRatio: _controller?.value.aspectRatio ?? 16 / 9,
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
                aspectRatio: _controller?.value.aspectRatio ?? 16 / 9,
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
                            Padding(
                              padding: const EdgeInsets.only(top: 16,right: 16)
                              ,child: Align(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: _toggleOrientation,
                                  child: const Icon(
                                    Icons.screen_rotation,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),

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
                                            data: const SliderThemeData(
                                              thumbShape: RoundSliderThumbShape(
                                                  enabledThumbRadius: 6),
                                              overlayShape:
                                                  RoundSliderOverlayShape(
                                                      overlayRadius: 12.0),
                                              trackShape:
                                                  PreviewCustomTrackShape(),
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
                                        // GestureDetector(
                                        //   onTap: _toggleOrientation,
                                        //   child: const Icon(
                                        //     Icons.zoom_out_map_rounded,
                                        //     color: Colors.white,
                                        //     size: 24,
                                        //   ),
                                        // ),
                                      ],
                                    ),

                                    ///Content duration and played duration
                                    Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
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
                                        const Spacer(),
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
          // aspectRatio: widget.aspectRatio,
          aspectRatio: 1,
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

class PreviewCustomTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  /// Create a slider track that draws two rectangles with rounded outer edges.
  const PreviewCustomTrackShape();

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
    // If the slider [SliderThemeData.trackHeight] is less than or equal to 0,
    // then it makes no difference whether the track is painted or not,
    // therefore the painting  can be a no-op.
    if (sliderTheme.trackHeight == null || sliderTheme.trackHeight! <= 0) {
      return;
    }

    // Assign the track segment paints, which are leading: active and
    // trailing: inactive.
    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor,
        end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween = ColorTween(
        begin: sliderTheme.disabledInactiveTrackColor,
        end: sliderTheme.inactiveTrackColor);
    final Paint activePaint = Paint()
      ..color = activeTrackColorTween.evaluate(enableAnimation)!;
    final Paint inactivePaint = Paint()
      ..color = inactiveTrackColorTween.evaluate(enableAnimation)!;
    final Paint leftTrackPaint;
    final Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final Radius trackRadius = Radius.circular(trackRect.height / 2);
    final Radius activeTrackRadius =
        Radius.circular((trackRect.height + additionalActiveTrackHeight) / 2);

    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left,
        (textDirection == TextDirection.ltr) ? trackRect.top : trackRect.top,
        thumbCenter.dx,
        (textDirection == TextDirection.ltr)
            ? trackRect.bottom
            : trackRect.bottom,
        topLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
        bottomLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
      ),
      leftTrackPaint,
    );
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        thumbCenter.dx,
        (textDirection == TextDirection.rtl) ? trackRect.top : trackRect.top,
        trackRect.right,
        (textDirection == TextDirection.rtl)
            ? trackRect.bottom
            : trackRect.bottom,
        topRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
        bottomRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
      ),
      rightTrackPaint,
    );
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
