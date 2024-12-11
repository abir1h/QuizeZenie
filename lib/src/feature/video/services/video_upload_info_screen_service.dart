import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin VideoUploadInfoScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;
  List<File>? files = [];

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
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
      });
    } else {
      debugPrint("No file selected");
      _view.showWarning("No file selected");
    }
  }
}
