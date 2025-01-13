import 'package:co_learning_mobile_app/src/feature/bookmark/models/feedback.dart';
import 'package:co_learning_mobile_app/src/feature/bookmark/models/folder_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/widgets/custom_dropdown_widget.dart';
import '../../../common/widgets/custom_toasty.dart';
import '../../../common/constants/common_imports.dart';
import '../../../common/utility/app_label.dart';
import '../../../common/widgets/custom_button.dart';
import '../../video_upload/video_upload_screen.dart';
import '../services/video_upload_info_screen_service.dart';
import '../widgets/feed_back_widget.dart';

class VideoUploadInfoScreen extends StatefulWidget {
  const VideoUploadInfoScreen({super.key});

  @override
  State<VideoUploadInfoScreen> createState() => _VideoUploadInfoScreenState();
}

class _VideoUploadInfoScreenState extends State<VideoUploadInfoScreen>
    with AppTheme, Language, VideoUploadInfoScreenService {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.backgroundColor,
      appBar: AppBar(
        backgroundColor: clr.whiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(
          label(e: "Upload videos", b: "បង្ហោះវីដេអូ"),
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: size.textSmall,
              color: clr.textGrayColor),
        ),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height),
        child: Container(
          margin: EdgeInsets.only(top: size.s8),
          padding:
              EdgeInsets.symmetric(horizontal: size.s16, vertical: size.s20),
          decoration: BoxDecoration(color: clr.whiteColor),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    label(
                        e: "Upload video from gallery",
                        b: "បង្ហោះវីដេអូពីវិចិត្រសាល"),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: size.textSmall,
                        color: clr.blackColor)),
                size.s8.kHeight,
                Text(
                    label(
                        e:
                            "Please select  video from Gallery” to select pre recorded video.",
                        b:
                            "សូមជ្រើសរើសវីដេអូពីវិចិត្រសាល ដើម្បីជ្រើសរើសវីដេអូដែលបានថតទុកមុន។"),
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: size.textXXSmall,
                        color: clr.textLightGrey)),
                size.s24.kHeight,
                files!.isEmpty
                    ? GestureDetector(
                        onTap: () {
                          pickVideoFile();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: size.s20 + 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(size.s8),
                              color: clr.whiteColor,
                              border: Border.all(
                                  color: clr.appPrimaryColor, width: size.s1)),
                          child: Column(
                            children: [
                              Center(
                                child: SvgPicture.asset(ImageAssets.myVideos),
                              ),
                              size.s12.kHeight,
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: label(e: "Tap here", b: "ចុចទីនេះ"),
                                  style: TextStyle(
                                      color: clr.blueText,
                                      fontSize: size.textXSmall,
                                      fontWeight: FontWeight.w500),
                                  children: [
                                    TextSpan(
                                      text: label(
                                          e: " to Select a video",
                                          b: " ដើម្បីជ្រើសរើសវីដេអូ"),
                                      style: TextStyle(
                                          color: clr.lightGray,
                                          fontSize: size.textXSmall,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              size.s4.kHeight,
                              Text(
                                  label(
                                      e:
                                          "Supported video file type: mp4, mkv, flv",
                                      b:
                                          "ប្រភេទឯកសារវីដេអូដែលគាំទ្រ៖ mp4, mkv, flv"),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: size.textXXSmall,
                                      color: clr.textLightGrey)),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.all(size.s12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(size.s8),
                            color: clr.whiteColor,
                            border: Border.all(
                                color: clr.greyBorder, width: size.s1)),
                        child: isLoading
                            ? Padding(
                                padding: EdgeInsets.all(size.s12),
                                child: const CircularProgressIndicator(),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (thumbnailResult != null) ...[
                                    AspectRatio(
                                      aspectRatio: 319 / 128,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(size.s8),
                                        child: Image.memory(
                                          thumbnailResult!
                                              .bytes, // Use the image bytes here
                                          fit: BoxFit
                                              .cover, // Adjust the fit as needed
                                        ),
                                      ),
                                    ),
                                    size.s4.kHeight,
                                    Text(
                                      thumbnailResult!.videoName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: size.textXSmall,
                                          color: clr.greyVideoTitle),
                                    ),
                                    /* Row(
                                      children: [
                                        Text(
                                          "Duration: ${convertMillisecondsToHMS(thumbnailResult!.videoDuration)}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: size.textXXSmall,
                                              color: clr.greyVideoTitle),
                                        ),
                                      ],
                                    ),*/
                                    size.s8.kHeight,
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () => pickVideoFile(),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: size.s4),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        size.s4 + 2),
                                                color: clr.inactiveToggleColor,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  label(
                                                      e: "Change",
                                                      b: "ផ្លាស់ប្តូរ"),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize:
                                                          size.textXXSmall,
                                                      color:
                                                          clr.greyVideoTitle),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        size.s20.kWidth,
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                files!.clear();
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: size.s4),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        size.s4 + 2),
                                                color: clr.removeBgCardColor,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  label(
                                                      e: "Remove", b: "ដកចេញ"),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize:
                                                          size.textXXSmall,
                                                      color: clr
                                                          .removeBgCardColorText),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ]
                                ],
                              ),
                      ),
                size.s24.kHeight,
                Text(
                  label(e: "Name of the recording", b: "ឈ្មោះនៃការថត"),
                  style: TextStyle(
                      color: clr.blackColor,
                      fontSize: size.textXSmall,
                      fontWeight: FontWeight.w500),
                ),
                size.s8.kHeight,
                TextField(
                  controller: videoNameController,
                  cursorRadius: const Radius.circular(100),
                  decoration: InputDecoration(
                    hintText:
                        label(e: "Name of the recording", b: "ឈ្មោះនៃការថត"),
                    hintStyle: TextStyle(
                      color: clr.placeHolderTextColorGray,
                      fontSize: size.textXSmall,
                      fontWeight: FontWeight.w400,
                      fontFamily: StringData.fontFamilyPoppins,
                    ),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: clr.inactiveGray, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: clr.inactiveGray, width: 1)),
                    disabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: clr.inactiveGray, width: 1)),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: size.s10, horizontal: size.s20),
                  ),
                ),
                size.s8.kHeight,
                Text(
                  label(e: "Feedback Criteria", b: "លក្ខណៈវិនិច្ឆ័យមតិ"),
                  style: TextStyle(
                      color: clr.blackColor,
                      fontSize: size.textXSmall,
                      fontWeight: FontWeight.w500),
                ),
                size.s8.kHeight,
                CustomDropDown<FeedbackEntity>(
                    prefix: ImageAssets.assignment_turned_in,
                    onLoadData: getFeedEntityList,
                    onSelected: (status) {
                      feedbackEntity = status;
                    },
                    hintText: label(
                        e: "Name of Feedback Criteria...",
                        b: "ជ្ឈ្មោះ​នៃ​លក្ខណៈ​វិនិច្ឆ័យ​នៃ​ការ​ផ្ដល់​យោបល់..."),
                    onGenerateTitle: (x) => x.name),
                size.s8.kHeight,
                Text(
                  label(e: "Folder or Category", b: "ថតឬប្រភេទ"),
                  style: TextStyle(
                      color: clr.blackColor,
                      fontSize: size.textXSmall,
                      fontWeight: FontWeight.w500),
                ),
                size.s8.kHeight,
                CustomDropDown<FolderEntity>(
                    prefix: ImageAssets.folder,
                    onLoadData: getFolderListEntityList,
                    onSelected: (status) {
                      folderEntity = status;
                    },
                    hintText: label(
                        e: "Select Folder or Category",
                        b: "ជ្រើសរើស Folder ឬ Category"),
                    onGenerateTitle: (x) => x.name),
                size.s24.kHeight,
                CustomButton(
                    onTap:onTapContinueButton,
                    title: "Continue",
                    radius: size.s8,
                    verticalPadding: size.s10,
                    textSize: size.textXSmall,
                    bgColor: files!.isEmpty
                        ? clr.disableButtonGray
                        : clr.appPrimaryColor),
                size.s64.kHeight,
              ],
            ),
          ),
        ),
      ),
    );
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
  void onNavigateVideoUploadScreen(FeedbackEntity feedback, FolderEntity folder, String videoName) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => VideoUploadScreen(videoAssets: files![0],folder: folder,feedback: feedback, videoName: videoName,)),
    );
  }
}
