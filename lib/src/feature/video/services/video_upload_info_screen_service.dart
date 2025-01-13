import 'dart:async';
import 'dart:io';
import 'package:co_learning_mobile_app/src/common/widgets/custom_toasty.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'dart:typed_data';

import '../../../common/models/action_result.dart';
import '../../bookmark/models/feedback.dart';
import '../../bookmark/models/folder_entity.dart';
import '../gateways/video_recorded_screen_gateway.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
  void onNavigateVideoUploadScreen(FeedbackEntity feedback,FolderEntity folder,String videoName);
}

mixin VideoUploadInfoScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;
  List<File>? files = [];

  TextEditingController videoNameController = TextEditingController();
  bool isLoading = true;
  var thumbnail;
  ThumbnailRequest? thumbnailRequest;
  ThumbnailResult? thumbnailResult;

  FeedbackEntity feedbackEntity = FeedbackEntity.empty();
  FolderEntity folderEntity = FolderEntity.empty();

  /// Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  Future<List<FeedbackEntity>> getFeedEntityList() async {
    return VideoRecordedScreenGateway.getFeedbackList().then((value) {
      if (value.status == Status.success) {
        return value.data!;
      } else {
        _view.showWarning(value.message);
        return [];
      }
    });
  }

  Future<List<FolderEntity>> getFolderListEntityList() async {
    return VideoRecordedScreenGateway.getFolderList().then((value) {
      if (value.status == Status.success) {
        return value.data!;
      } else {
        _view.showWarning(value.message);
        return [];
      }
    });
  }

  void pickVideoFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowCompression: true,
      type: FileType.custom,
      compressionQuality: 30,
      allowedExtensions: [
        'avi',
        'flv',
        'mkv',
        'mov',
        'mp4',
        'mpeg',
        'webm',
        'wmv'
      ],
    );

    if (result != null) {
      setState(() {
        files = result.paths.map((path) => File(path!)).toList();
        isLoading = true;
      });

      if (files != null && files!.isNotEmpty) {
        final videoFilePath = files![0].path;
        thumbnailRequest = ThumbnailRequest(
          video: videoFilePath,
          thumbnailPath: null,
          imageFormat: ImageFormat.JPEG,
          maxHeight: 200,
          maxWidth: 200,
          timeMs: 5000,
          quality: 75,
          attachHeaders: false,
        );

        thumbnailResult = await genThumbnail(thumbnailRequest!);

        setState(() {
          isLoading = false;
        });
      }
    } else {
      debugPrint("No file selected");
      _view.showWarning("No file selected");
    }
  }

  Future<ThumbnailResult> genThumbnail(ThumbnailRequest r) async {
    Uint8List bytes;
    final completer = Completer<ThumbnailResult>();

    final videoFileName = r.video.split('/').last;

    if (r.thumbnailPath != null) {
      final thumbnailFile = await VideoThumbnail.thumbnailFile(
        video: r.video,
        thumbnailPath: r.thumbnailPath,
        imageFormat: r.imageFormat,
        maxHeight: r.maxHeight,
        maxWidth: r.maxWidth,
        timeMs: r.timeMs,
        quality: r.quality,
      );

      debugPrint('thumbnail file is located: $thumbnailFile');

      bytes = await thumbnailFile.readAsBytes();
    } else {
      bytes = await VideoThumbnail.thumbnailData(
        video: r.video,
        imageFormat: r.imageFormat,
        maxHeight: r.maxHeight,
        maxWidth: r.maxWidth,
        timeMs: r.timeMs,
        quality: r.quality,
      );
    }

    final imageDataSize = bytes.length;
    debugPrint('image size: $imageDataSize');

    final image = Image.memory(bytes);
    image.image.resolve(ImageConfiguration.empty).addListener(
          ImageStreamListener(
            (ImageInfo info, bool _) {
              completer.complete(
                ThumbnailResult(
                  bytes: bytes,
                  dataSize: imageDataSize,
                  height: info.image.height,
                  width: info.image.width,
                  videoDuration: r.timeMs,
                  videoName: videoFileName,
                ),
              );
            },
            onError: completer.completeError,
          ),
        );
    return completer.future;
  }

  void onTapContinueButton() {
    if (folderEntity.id.isEmpty || feedbackEntity.id == -1) {
      Toasty.of(context).showWarning("Please Select Folder or Feedback!");
    } else {
      onNavigateVideoUploadScreen(feedbackEntity,folderEntity,videoNameController.text.trim());
    }
  }
}

class ThumbnailRequest {
  const ThumbnailRequest({
    required this.video,
    required this.thumbnailPath,
    required this.imageFormat,
    required this.maxHeight,
    required this.maxWidth,
    required this.timeMs,
    required this.quality,
    required this.attachHeaders,
  });

  final String video;
  final String? thumbnailPath;
  final ImageFormat imageFormat;
  final int maxHeight;
  final int maxWidth;
  final int timeMs;
  final int quality;
  final bool attachHeaders;
}

class ThumbnailResult {
  const ThumbnailResult({
    required this.bytes,
    required this.dataSize,
    required this.height,
    required this.width,
    required this.videoName,
    required this.videoDuration,
  });

  final Uint8List bytes;
  final int dataSize;
  final int height;
  final int width;
  final String videoName;
  final int videoDuration;
}

class FeedBack {
  int id;
  String title;
  FeedBack({required this.id, required this.title});
}
