import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
  void forceClose();
  void showVideoSaveDialog(File file);
}

mixin VideoRecordService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  CameraController? cameraController;
  late List<CameraDescription> _cameras;
  bool isRecording = false;
  bool isPaused = false;
  // double zoomLevel = 1.0;
  int timerSeconds = 0;
  Timer? _timer;

  // Keep track of the current camera index
  int _currentCameraIndex = 0;
  bool isFrontCamera = false;
  String qualityDropDownValue = "";
  List<String> itemList = [
    'Mobile-friendly images quality (about 65MB/ 30 minutes)',
    'Average image quality/ smooth (about 90MB/ 30 minutes)',
    'Medium high image quality (about 180MB/ 30 minutes)',
    'Medium image quality (about 150MB/ 30 minutes)',
    'High quality (about 300MB/ 30 minutes)'
  ];

  ///Service configurations
  @override
  void initState() {
    _view = this;
    WakelockPlus.enable();
    super.initState();
  }

  @override
  void dispose() {
    cameraController?.dispose();
    _timer?.cancel();
    WakelockPlus.disable();
    super.dispose();
  }

  Future<bool> onGoBack() {
    _view.forceClose();
    return Future.value(false);
  }

  Future<List<String>> getItems() async {
    return itemList;
  }

  Future<void> initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      cameraController = CameraController(
        _cameras[_currentCameraIndex], // Start with the current camera
        ResolutionPreset.high,
        enableAudio: true,
      );
      await cameraController?.initialize();
      setState(() {});
    } else {
      _view.showWarning("No camera available!");
    }
  }

  Future<void> startRecording() async {
    if (!cameraController!.value.isInitialized) return;
    await cameraController!.startVideoRecording();
    setState(() {
      isRecording = true;
      timerSeconds = 0;
    });
    _startTimer();
  }

  Future<void> stopRecording() async {
    if (!cameraController!.value.isRecordingVideo) return;

    XFile video = await cameraController!.stopVideoRecording();

    final Directory directory = await getApplicationDocumentsDirectory();
    final String recordedVideoPath = video.path;
    final String newFileName =
        join(directory.path, '${DateTime.now().millisecondsSinceEpoch}.mp4');
    final File tempFile = File(recordedVideoPath);
    final File newFile = tempFile.renameSync(newFileName);
    setState(() {
      isRecording = false;
      isPaused = false;
      _timer?.cancel();
      qualityDropDownValue = "";
    });
    debugPrint('Inside Recording stopped: ${video.path}');
    debugPrint('Recording saved to: ${newFile.path}');
    // Navigate to Upload page
    _view.showVideoSaveDialog(newFile);
  }

  Future<void> pauseResumeRecording() async {
    if (isPaused) {
      await cameraController!.resumeVideoRecording();
      _startTimer();
    } else {
      await cameraController!.pauseVideoRecording();
      _timer?.cancel();
    }
    setState(() {
      isPaused = !isPaused;
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timerSeconds++;
      });
    });
  }

  Future<void> flipCamera() async {
    // Toggle between front and back cameras
    _currentCameraIndex = (_currentCameraIndex + 1) % _cameras.length;

    // Dispose of the current controller and initialize a new one
    await cameraController?.dispose();

    isFrontCamera = _cameras[_currentCameraIndex].lensDirection ==
        CameraLensDirection.front;
    cameraController = CameraController(
        _cameras[_currentCameraIndex], ResolutionPreset.high,
        enableAudio: true);
    await cameraController?.initialize();
    setState(() {});
  }
}
