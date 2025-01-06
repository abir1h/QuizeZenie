import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/constants/app_theme.dart';

class BottomSheetImagePicker extends StatefulWidget {
  final VoidCallback onCamera, onGallery;
  const BottomSheetImagePicker(
      {super.key, required this.onCamera, required this.onGallery});

  @override
  State<BottomSheetImagePicker> createState() => _BottomSheetImagePickerState();
}

class _BottomSheetImagePickerState extends State<BottomSheetImagePicker>
    with AppTheme {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
    Navigator.pop(context); // Close the bottom sheet
  }

  Future<void> _captureImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
    Navigator.pop(context); // Close the bottom sheet
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top+.3.sh),
            padding:
            EdgeInsets.symmetric(horizontal: size.s16, vertical: size.s12),
            decoration: BoxDecoration(
              color: clr.shadeWhiteColor2,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.s24),
                topRight: Radius.circular(size.s24),
              ),
            ),
            child:  Column(
              children: [
                Text(
                  'Choose an option',
                  style: TextStyle(fontSize: size.s16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.s24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: widget.onCamera,
                        child: const Column(
                          children: [
                            Icon(Icons.camera_alt, size: 50),
                            SizedBox(height: 8),
                            Text('Camera'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: widget.onGallery,
                        child: const Column(
                          children: [
                            Icon(Icons.photo_library, size: 50),
                            SizedBox(height: 8),
                            Text('Gallery'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );;
  }
}