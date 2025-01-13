import 'dart:io';

import 'package:co_learning_mobile_app/src/common/widgets/app_scaffold.dart';
import 'package:co_learning_mobile_app/src/common/widgets/app_scroll_view.dart';
import 'package:co_learning_mobile_app/src/common/widgets/custom_button.dart';
import 'package:co_learning_mobile_app/src/common/widgets/custom_toasty.dart';
import 'package:co_learning_mobile_app/src/feature/bookmark/models/chapter.dart';
import 'package:co_learning_mobile_app/src/feature/video_upload/video_player_widget.dart';
import 'package:co_learning_mobile_app/src/feature/video_upload/services/video_upload_screen_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/constants/common_imports.dart';
import '../../common/widgets/app_stream.dart';
import '../bookmark/models/feedback.dart';
import '../bookmark/models/folder_entity.dart';
import '../video/screens/chapter_create_bottom_sheet_screen.dart';
import '../video/widgets/feed_back_widget.dart';

class VideoUploadScreen extends StatefulWidget {
  final File videoAssets;
  final FolderEntity folder;
  final FeedbackEntity feedback;
  final String videoName;
  const VideoUploadScreen(
      {super.key,
      required this.videoAssets,
      required this.folder,
      required this.feedback, required this.videoName});

  @override
  State<VideoUploadScreen> createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoUploadScreen>
    with VideoUploadScreenServices, AppTheme {
  @override
  void initState() {
    ///Initially load course details
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadInitialData(widget.videoAssets.path, widget.folder, widget.feedback);
    });
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: AppScaffold(
          title: "Video Upload",
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                children: [
                  PreviewPlayerWidget(
                    playerStream: playerStreamController.stream,
                    playbackStream: playbackPausePlayStreamController.stream,
                    onProgressChanged: onPlaybackProgressChanged,
                    interceptSeekTo: onInterceptPlaybackSeekToPosition,
                    onTotalVideoDuration: onTotalVideoDuration,
                    // overlay: GestureDetector(
                    //   onTap: onGoBack,
                    //   child: const BackButtonWidget(),
                    // ),
                  ),
                  // IconButton(onPressed: uploadVideoFile, icon: const Icon(Icons.upload)),
                  Slider(
                    value: currentUploadProgress.clamp(0.0, 1.0),
                    onChanged: null,
                    min: 0.0,
                    max: 1.0,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey[300],
                  ),
                  Text(
                    '${(currentUploadProgress * 100).toStringAsFixed(1)}%', // Display percentage
                    style: const TextStyle(fontSize: 16),
                  ),

                  ///My Courses
                  AppStreamBuilder<List<ChapterEntity>>(
                      stream: chapterStreamController.stream,
                      loadingBuilder: (context) {
                        return const Offstage();
                      },
                      dataBuilder: (context, data) {
                        return ChapterItemSectionWidget<ChapterEntity>(
                          items: data,
                          buildItem: (context, index, item) {
                            return ChapterItemWidget(
                              key: ObjectKey(item),
                              onTap: () {},
                              data: item,
                            );
                          },
                        );
                      },
                      emptyBuilder: (context, message, icon) => Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: onTapCreateChapter,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: size.s24),
                                  padding:
                                      EdgeInsets.symmetric(vertical: size.s4),
                                  decoration:
                                      BoxDecoration(color: clr.grayColor),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.menu_book_outlined,
                                        color: Color(0xff717680),
                                        size: 20,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Create Chapter",
                                        style: TextStyle(
                                            color: Color(
                                              0xff717680,
                                            ),
                                            fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: double.maxFinite,
                                height: size.s64,
                                child: Center(
                                  child: Text(
                                    message,
                                  ),
                                ),
                              )
                            ],
                          )),
                ],
              ),
            ],
          )),
    );
  }

  @override
  void changeOrientationToPortrait() {
    // TODO: implement changeOrientationToPortrait
  }

  @override
  bool isPlayerFullscreen() {
    // TODO: implement isPlayerFullscreen
    throw UnimplementedError();
  }

  @override
  void navigateToBack() {
    // TODO: implement navigateToBack
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
  void navigateToChapterCreateBottomSheet() {
    if(videoId.isNotEmpty){
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CreateChapterBottomSheet(
            videoId:videoId,
          );
        },
      );
    }else{
      Toasty.of(context).showWarning("Please wait while uploading video!");
    }

  }
}

class ChapterItemSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const ChapterItemSectionWidget({
    super.key,
    required this.items,
    required this.buildItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: size.s12);
      },
    );
  }
}

class ChapterItemWidget extends StatelessWidget with AppTheme {
  final ChapterEntity data;
  final VoidCallback onTap;
  const ChapterItemWidget({
    super.key,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.s16, vertical: size.s12),
        decoration: BoxDecoration(
            color: clr.bgGood,
            borderRadius: BorderRadius.circular(size.s8),
            border: Border.all(color: clr.scoreBorderColor, width: size.s1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(ImageAssets.icProfile),
                SizedBox(width: size.s8),
                Expanded(
                  child: Text(
                    "User Name",
                    style: TextStyle(
                        color: clr.profileCardTextColor,
                        fontSize: size.textXSmall,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins"),
                  ),
                ),
                Text(
                  "View",
                  style: TextStyle(
                      color: clr.appPrimaryColor,
                      fontSize: size.textXXSmall,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins"),
                ),
              ],
            ),
            SizedBox(height: size.s8),
            Divider(color: clr.scoreDividerColor, height: size.s1),
            SizedBox(height: size.s8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Score:",
                  style: TextStyle(
                      color: clr.profileCardTextColor,
                      fontSize: size.textXSmall,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins"),
                ),
                Text(
                  "20",
                  style: TextStyle(
                      color: clr.scoreColor,
                      fontSize: size.textX28Large,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Poppins"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
