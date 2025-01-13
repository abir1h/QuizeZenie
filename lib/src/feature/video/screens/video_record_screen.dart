import 'dart:io';
import 'dart:math' as math;

import 'package:co_learning_mobile_app/src/feature/bookmark/models/feedback.dart';
import 'package:co_learning_mobile_app/src/feature/bookmark/models/folder_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/constants/common_imports.dart';
import '../../video_upload/video_upload_screen.dart';
import '../services/video_record_service.dart';
import '../../../common/widgets/custom_toasty.dart';
import '../widgets/feedback_details_view_bottom_sheet.dart';
import '../widgets/feedback_dropdown_video_record_screen.dart';
import '../widgets/select_folder_dropdown_video_recorded_screen.dart';
import '../widgets/video_save_dialog_widget.dart';

class VideoRecordScreen extends StatefulWidget {
  const VideoRecordScreen({super.key});
  @override
  State<VideoRecordScreen> createState() => _VideoRecordScreenState();
}

class _VideoRecordScreenState extends State<VideoRecordScreen>
    with AppTheme, VideoRecordService, VideoSaveDialogWidget {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initializeCamera();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: clr.blackColor,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
              child: Icon(Icons.arrow_back,
                  color: clr.darkGreyHeaderTextColor, size: size.s24),
            ),
          ),
          title: isRecording
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.fiber_manual_record,
                        color: Colors.red, size: size.s16),
                    size.s8.kWidth,
                    Text(
                      '${(timerSeconds ~/ 60).toString().padLeft(2, '0')}:${(timerSeconds % 60).toString().padLeft(2, '0')}',
                      style: TextStyle(
                          color: clr.darkGreyHeaderTextColor,
                          fontSize: size.textSmall),
                    ),
                    size.s16.kWidth
                  ],
                )
              : Text(
                  'Select options',
                  style: TextStyle(
                      color: clr.darkGreyHeaderTextColor,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w500),
                ),
          actions: [
            IconButton(
                onPressed: !isRecording ? () {} : null,
                icon: Icon(Icons.restart_alt_outlined,
                    color: !isRecording
                        ? clr.darkGreyHeaderTextColor
                        : Colors.transparent,
                    size: size.s24)),
          ],
          centerTitle: true,
          backgroundColor: clr.whiteColor,
        ),
        body: cameraController != null && cameraController!.value.isInitialized
            ? Stack(
                fit: StackFit.expand,
                children: [
                  // Camera Preview
                  Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(isFrontCamera ? math.pi : 0),
                      child: CameraPreview(cameraController!)),
                  Column(
                    children: [
                      if (!isRecording)
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(size.s16),
                            decoration: BoxDecoration(
                                color: clr.bgColorWhite.withOpacity(.6)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: size.s16,vertical: size.s24),
                                  child: SelectFolderDropDownVideoRecordScreen<
                                      FolderEntity>(
                                    onLoadData: getFolderListEntityList,
                                    onSelected: (x) {
                                      selectedFolderEntity = x;
                                    },
                                    onGenerateTitle: (x) => x.name,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (!isRecording)
                        Padding(
                          padding: EdgeInsets.only(
                              left: size.s16,
                              right: size.s16,
                              bottom: size.s24),
                          child:
                              FeedBackDropDownVideoRecordScreen<FeedbackEntity>(     
                            onLoadData: getFeedEntityList,
                            onSelected: (x) {
                              selectedFeedbackEntity = x;
                              onShownFeedbackBottomSheet(x);
                            },
                            onGenerateTitle: (x) => x.name,
                          ),
                        ),
                      if (!isRecording)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: size.s4),
                          decoration: BoxDecoration(color: clr.whiteColor),
                          width: double.infinity,
                          child: DropdownButtonFormField<String>(
                            hint: Text("Tap to select video quality",
                                style: TextStyle(
                                    color: clr.iconColorGray,
                                    fontWeight: FontWeight.w500,
                                    fontSize: size.textXSmall)),
                            dropdownColor: clr.whiteColor,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: size.s8,
                                vertical: size.s8,
                              ),
                              isDense: false,
                              filled: true,
                              fillColor: clr.whiteColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            icon: SvgPicture.asset(ImageAssets.icDropdown),
                            isExpanded: true,
                            style: TextStyle(
                                color: clr.blackColor,
                                fontSize: size.textSmall,
                                overflow: TextOverflow.ellipsis),
                            items: itemList.values.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: SizedBox(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.done,
                                        color: qualityDropDownValue == value
                                            ? clr.iconColorGray
                                            : Colors.transparent,
                                        size: 20.r,
                                      ),
                                      size.s4.kWidth,
                                      Expanded(
                                          child: Text(
                                        value,
                                        style: TextStyle(
                                            color: clr.iconColorGray,
                                            fontWeight: FontWeight.w500,
                                            fontSize: size.textXSmall),
                                      ))
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                qualityDropDownValue = newValue!;
                                // Find the key for the value
                                resolutionPreset = itemList.entries
                                    .firstWhere(
                                      (entry) =>
                                          entry.value == qualityDropDownValue,
                                      orElse: () => MapEntry(
                                          ResolutionPreset.high,
                                          qualityDropDownValue),
                                    )
                                    .key;
                              });
                            },
                          ),
                        ),
                      Expanded(flex: !isRecording ? 0 : 1, child: Container()),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: size.s12, horizontal: size.s32),
                        decoration: BoxDecoration(
                          color: clr.whiteColor,
                          border: Border(
                            top: BorderSide(
                              color: clr.darkGreyHeaderTextColor,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                size.s4.kHeight,
                                GestureDetector(
                                    onTap: !isRecording ? flipCamera : null,
                                    child: SvgPicture.asset(
                                      ImageAssets.icFlipCamera,
                                      color: !isRecording
                                          ? clr.darkGreyHeaderTextColor
                                          : Colors.transparent,
                                    )),
                                size.s1.kHeight,
                                Text(!isFrontCamera ? "Front" : "Back",
                                    style: TextStyle(
                                        fontSize: size.textXXXSmall,
                                        color: !isRecording
                                            ? clr.blackColor
                                            : Colors.transparent)),
                              ],
                            ),
                            50.w.kWidth,
                            // Record button
                            GestureDetector(
                              onTap: () {
                                if (selectedFolderEntity.id.isEmpty ||
                                    selectedFeedbackEntity.id == -1) {
                                  Toasty.of(context).showWarning(
                                      "Please Select Folder or Feedback!");
                                } else {
                                  if (isRecording) {
                                    stopRecording();
                                  } else {
                                    startRecording();
                                  }
                                }
                              },
                              child: isRecording
                                  ? Container(
                                      constraints: BoxConstraints(
                                        maxWidth: size.s56,
                                        maxHeight: size.s56,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: clr.amberColor, width: 3.w),
                                        color: clr.amberColor,
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.all(size.s8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.w),
                                          color: clr.whiteColor,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      constraints: BoxConstraints(
                                        maxWidth: size.s56,
                                        maxHeight: size.s56,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: clr.amberColor, width: 3.w),
                                        color: clr.whiteColor,
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.all(size.s4),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: clr.amberColor,
                                              width: 1.w),
                                          color: clr.whiteColor,
                                        ),
                                      ),
                                    ),
                            ),
                            50.w.kWidth,
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                size.s4.kHeight,
                                GestureDetector(
                                  onTap:
                                      isRecording ? pauseResumeRecording : null,
                                  child: Icon(
                                    isPaused
                                        ? Icons.play_circle
                                        : Icons.pause_circle,
                                    size: size.s32 + size.s4,
                                    color: isRecording
                                        ? clr.darkGreyHeaderTextColor
                                        : Colors.transparent,
                                  ),
                                ),
                                size.s1.kHeight,
                                Text(isPaused ? "Play" : "Pause",
                                    style: TextStyle(
                                        fontSize: size.textXXXSmall,
                                        color: isRecording
                                            ? clr.blackColor
                                            : Colors.transparent)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  @override
  void forceClose() {
    Navigator.of(context).pop();
  }

  @override
  void showSuccess(String message) {
    Toasty.of(context).showSuccess(message);
  }

  @override
  void showWarning(String message) {
    Toasty.of(context).showWarning(message);
  }

  @override
  void showVideoSaveDialog(File file) {
    showVideoSaveDialogWidget(
      context: context,
      folderName: selectedFolderEntity.name
    ).then((value) {
      if (value.isNotEmpty) {
        File videoFile = renameVideoFile(value.trim(), file);
        ///Navigate to upload page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => VideoUploadScreen(videoAssets: videoFile,folder: selectedFolderEntity,feedback: selectedFeedbackEntity,)),
        );
      }
    });
  }

  @override
  void showFeedbackReviewBottomSheet(FeedbackEntity feedbackEntity) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return FeedBackDetailsBottomSheet(
          data: feedbackEntity,
        );
      },
    );
  }
}
