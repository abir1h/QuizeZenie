import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:co_learning_mobile_app/src/common/widgets/app_scaffold.dart';
import 'package:co_learning_mobile_app/src/common/widgets/app_scroll_view.dart';
import 'package:co_learning_mobile_app/src/common/widgets/custom_button.dart';
import 'package:co_learning_mobile_app/src/common/widgets/custom_toasty.dart';
import 'package:co_learning_mobile_app/src/feature/bookmark/models/chapter.dart';
import 'package:co_learning_mobile_app/src/feature/video/models/video_entity.dart';
import 'package:co_learning_mobile_app/src/feature/video_upload/video_player_widget.dart';
import 'package:co_learning_mobile_app/src/feature/video_upload/services/video_upload_screen_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/constants/app_constant.dart';
import '../../common/constants/common_imports.dart';
import '../../common/widgets/action_button.dart';
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

      loadInitialData(widget.videoAssets.path, widget.folder, widget.feedback,widget.videoName);
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
          floatingActionButton: Container(
            width: 1.sw,
            decoration: BoxDecoration(color: clr.whiteColor, boxShadow: [
              BoxShadow(
                  offset: Offset(0, -2),
                  blurRadius: size.s4,
                  spreadRadius: 0,
                  color: clr.blackColor.withOpacity(.1))
            ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.s16, vertical: size.s12),
                  child: Row(
                    children: [
                      Expanded(
                        child: ActionButton<VideoEntity>(
                            title: "Save Draft",
                            radius: size.s8,
                            buttonColor: clr.disableButtonGray,textColor: Colors.white,
                            tapAction: () =>throw UnimplementedError(),
                            onSuccess: (success) {

                            }),
                      ),
                      size.s16.kWidth,
                      Expanded(
                        child: ActionButton<VideoEntity>(
                            title: "Publish Video",
                            radius: size.s8,
                            textColor: clr.whiteColor,
                            tapAction: () =>publishVideo(true,videoId),
                            onSuccess: (success) {
                              Navigator.pop(context);

                            }),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
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
              /*Slider(
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
                  ),*/

              ///My Courses
              Expanded(
                child: AppStreamBuilder<List<ChapterEntity>>(
                    stream: chapterStreamController.stream,
                    loadingBuilder: (context) {
                      return Container(
                        padding: EdgeInsets.only(
                          left: 24.w,
                          right: 24.w,
                          top: 24.w,
                          bottom: 24.w,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18.w),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 42.w,
                              width: 42.w,
                              child: CircularProgressIndicator(
                                valueColor: const AlwaysStoppedAnimation(
                                  Colors.indigo,
                                ),
                                strokeWidth: 2.w,
                              ),
                            ),
                            SizedBox(height: 16.w,),
                            Text(
                              "Please wait..",
                              style: TextStyle(
                                color: Colors.indigo,
                                fontSize: 20.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                    dataBuilder: (context, data) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.s16, vertical: size.s12),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                      'Chapters',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: size.textSmall,
                                          color: clr.textColorBlack1),
                                    )),
                                GestureDetector(
                                  onTap:onTapCreateChapter,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.s12,
                                        vertical: size.s4),
                                    decoration: BoxDecoration(
                                      color: clr.appPrimaryColor,
                                      borderRadius:
                                      BorderRadius.circular(size.s4),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Create",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: clr.whiteColor,
                                            fontSize: size.textXXSmall),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            size.s16.kHeight,
                            Flexible(
                              child: ChapterItemSectionWidget<ChapterEntity>(
                                items: data,
                                buildItem: (context, index, item) {
                                  return Column(
                                    children: [
                                      ChapterItemWidget(
                                        key: ObjectKey(item),
                                        onTapEdit: () {

                                          showCupertinoModalPopup(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CreateChapterBottomSheet(
                                                videoId: videoId,
                                                totalDuration: totalVideoDuration!,
                                                userPosition: userPlayedPosition!,
                                                title: item.title,
                                                chapterTime:  Duration(seconds:  item.startTimeSeconds.round()),
                                                chapterId: item.id,

                                                chapterList: (value) {
                                                  onLoadChapterList(value);
                                                },
                                              );
                                            },
                                          );
                                        },
                                        onDelete: ()=>chapterDelete(item.id),
                                        data: item,
                                      ),
                                      if(index==data.length-1)
                                      SizedBox(height: 100,)
                                    ],
                                  );
                                },
                              ),
                            ),


                          ],
                        ),
                      );
                    },
                    emptyBuilder: (context, message, icon) => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        size.s8.kHeight,
                        GestureDetector(
                          onTap: onTapCreateChapter,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.s16),
                            padding:
                            EdgeInsets.symmetric(vertical: size.s8),
                            decoration: BoxDecoration(
                                color: clr.chapterBackground,
                                borderRadius:
                                BorderRadius.circular(size.s8),
                                border:
                                Border.all(color: clr.chapterBorder)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  ImageAssets.book,
                                  height: size.s20,
                                ),
                                size.s10.kWidth,
                                Text(
                                  "Create Chapter",
                                  style: TextStyle(
                                      fontSize: size.textXSmall,
                                      fontWeight: FontWeight.w500,
                                      color: clr.chapterTextColor),
                                )
                              ],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            size.s16.kHeight,
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.s16),
                              child: Text(
                                "If you have feedback on an individual scene, it will be displayed here.",
                                style: TextStyle(
                                    color: clr.textLightGrey,
                                    fontSize: size.textXXSmall,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins"),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            size.s42.kHeight,
                            Center(
                              child: SvgPicture.asset(
                                ImageAssets.groupImage,
                                height: 100,
                                width: 116,
                              ),
                            ),
                            SizedBox(height: size.s16),
                          ],
                        ),
                      ],
                    )),
              ),
            ],
          ),),
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
    if (videoId.isNotEmpty) {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CreateChapterBottomSheet(
            videoId: videoId,
            totalDuration: totalVideoDuration!,
            userPosition: userPlayedPosition!,

            chapterList: (value) {
              onLoadChapterList(value);
            },
          );
        },
      );
    } else {
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
  final VoidCallback onTapEdit;
  final VoidCallback onDelete;
  const ChapterItemWidget({
    super.key,
    required this.data,
    required this.onTapEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.s16, vertical: size.s12),
      decoration: BoxDecoration(
          color: clr.whiteColor,
          borderRadius: BorderRadius.circular(size.s8),
          border: Border.all(color: clr.borderGray, width: size.s1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(size.s8), // Rounded image
                  child: AspectRatio(aspectRatio: 120/72,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,

                      imageUrl: data.thumbnailUrl,
                      // placeholder: (context, url) =>
                      //     const CircularProgressIndicator(), // Placeholder widget
                      errorWidget: (context, url, error) => Image.network(
                        "https://archive.org/download/placeholder-image/placeholder-image.jpg",
                        height: 60.h,
                        width: 60.w,
                        fit: BoxFit.cover,
                        color: clr.borderGray,
                      ), // Error widget
                    ),
                  ),
                ),
              ),
              size.s12.kWidth,
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: size.textSmall,
                        color: clr.textColorGrey2,
                      ),
                    ),
                    size.s20.kHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.s12, vertical: size.s4),
                          decoration: BoxDecoration(
                            color: clr.scoreExpandedCardItemColor,
                            borderRadius: BorderRadius.circular(size.s4),
                          ),
                          child: Text(
                            formatDuration(data.startTimeSeconds),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: size.textSmall,
                              color: clr.blackColor,
                            ),
                          ),
                        ),
                        Expanded(child: size.s8.kWidth),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap:onDelete,
                                child: SvgPicture.asset(ImageAssets.delete)),
                            size.s8.kWidth,
                            GestureDetector(
                              onTap: onTapEdit,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.s12, vertical: size.s2),
                                decoration: BoxDecoration(
                                  color: clr.scoreExpandedCardItemColor,
                                  borderRadius: BorderRadius.circular(size.s4),
                                ),
                                child: Center(
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: size.textSmall,
                                      color: clr.appPrimaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              size.s12.kWidth,
            ],
          ),
        ],
      ),
    );
  }

  String formatDuration(int totalSeconds) {
    Duration duration = Duration(seconds: totalSeconds);

    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }
  }
}
