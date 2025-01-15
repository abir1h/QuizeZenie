import 'package:co_learning_mobile_app/src/common/widgets/custom_toasty.dart';
import 'package:co_learning_mobile_app/src/feature/bookmark/models/chapter.dart';
import 'package:co_learning_mobile_app/src/feature/video/models/comment_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import '../../../common/constants/common_imports.dart';
import '../../../common/routes/app_route.dart';
import '../../../common/routes/app_route_args.dart';
import '../../../common/widgets/app_stream.dart';
import '../../../common/widgets/circular_loader.dart';
import '../../bookmark/models/feedback.dart';
import '../../bookmark/models/form_category.dart';
import '../../feedback_score/models/feedback_score_entity.dart';
import '../../feedback_score/screens/feedback_score_screen.dart';
import '../models/video_entity.dart';
import '../services/video_details_screen_service.dart';
import '../widgets/chapters_bottom_sheet_screen.dart';
import '../widgets/comment_create_bottom_sheet.dart';
import '../widgets/comments_bottom_sheet.dart';
import '../widgets/feed_back_widget.dart';
import '../widgets/video_view_video_player_widget.dart';

class VideoDetailsScreen extends StatefulWidget {
  final Object? arguments;
  const VideoDetailsScreen({super.key, this.arguments})
      : assert(arguments != null && arguments is VideoDetailsScreenArgs);

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen>
    with VideoDetailsScreenService, AppTheme {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // @override
  // void initState() {
  //   ///Initially load course details
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     loadInitialData(
  //         "https://colearning.s3.ap-southeast-1.amazonaws.com/videos%2F20241230_044004_BigBuckBunny.mp4");
  //   });
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  //   super.initState();
  // }
  @override
  void initState() {
    screenArgs = widget.arguments as VideoDetailsScreenArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadInitialData(screenArgs.videoId);
      loadCommentData(screenArgs.videoId);
      loadFeedbackScoreData(screenArgs.videoId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: MediaQuery.of(context).orientation == Orientation.portrait,
      bottom: true,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: clr.whiteColor,
        body: AppStreamBuilder<VideoEntity>(
          stream: videoDetailsStreamController.stream,
          loadingBuilder: (context) {
            return const Center(
              child: CircularLoader(),
            );
          },
          dataBuilder: (context, data) {
            return Column(
              children: [
                ///Video Player Section
                Stack(
                  children: [
                    VideoViewPlayerWidget(
                      playerStream: playerStreamController.stream,
                      playbackStream: playbackPausePlayStreamController.stream,
                      onProgressChanged: onPlaybackProgressChanged,
                      interceptSeekTo: onInterceptPlaybackSeekToPosition,
                      playedPositionStream: onPlayedStreamController.stream,
                      chapters: data.chapters,
                      onChangedChapter: (value) {
                        initialSelectedChapter = value;
                        chapterEntityController.sink.add(value);
                      },
                      onTapChapter: () {
                        _scaffoldKey.currentState?.showBottomSheet(
                          (context) {
                            return DraggableScrollableSheet(
                              initialChildSize: 0.70,
                              minChildSize: 0.2,
                              maxChildSize: .70,
                              expand: false,
                              builder: (_, controller) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.s16),
                                  decoration: BoxDecoration(
                                    // color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(size.s12),
                                      topRight: Radius.circular(size.s12),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.remove,
                                        color: Colors.grey[600],
                                        size: size.s24,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Chapter in this video",
                                            style: TextStyle(
                                                fontSize: size.textSmall,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Icon(
                                                Icons.close,
                                                size: size.s24,
                                              ))
                                        ],
                                      ),
                                      SizedBox(height: size.s12),
                                      Divider(
                                        color: clr.iconGrey,
                                        height: size.s1,
                                      ),
                                      SizedBox(height: size.s12),
                                      Expanded(
                                          child: StreamBuilder<ChapterEntity>(
                                              stream: chapterEntityController
                                                  .stream,
                                              initialData:
                                                  initialSelectedChapter,
                                              builder: (
                                                BuildContext context,
                                                AsyncSnapshot<ChapterEntity>
                                                    snapshot,
                                              ) {
                                                return ListView.builder(
                                                  controller: controller,
                                                  itemCount:
                                                      data.chapters.length,
                                                  itemBuilder: (_, index) {
                                                    return ViewChapterItemWidget(
                                                      selectedChapter:
                                                          snapshot.data,
                                                      data:
                                                          data.chapters[index],
                                                      onTap: () {
                                                        onPlayedStreamController.add(
                                                            DataLoadedState(Duration(
                                                                seconds: data
                                                                    .chapters[
                                                                        index]
                                                                    .startTimeSeconds)));
                                                      },
                                                    );
                                                  },
                                                );
                                              })),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          enableDrag: true, // Allow dragging the bottom sheet
                        );
                      },
                      onTotalVideoDuration: (e) {},
                    ),
                    Positioned(
                      left: size.s16,
                      top: MediaQuery.of(context).padding.top + size.s2,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: clr.whiteColor,
                          size: size.s24,
                        ),
                      ),
                    )
                  ],
                ),

                ///Details section
                if (MediaQuery.of(context).orientation == Orientation.portrait)
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // PreviewPlayerWidget(
                              //   playerStream: playerStreamController.stream,
                              //   playbackStream: playbackPausePlayStreamController.stream,
                              //   onProgressChanged: onPlaybackProgressChanged,
                              //   interceptSeekTo: onInterceptPlaybackSeekToPosition,
                              //   // overlay: GestureDetector(
                              //   //   onTap: onGoBack,
                              //   //   child: const BackButtonWidget(),
                              //   // ),
                              // ),

                              SizedBox(height: size.s12),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: size.s16),
                                child: Text(
                                  data.title,
                                  style: TextStyle(
                                      color: clr.textColorGrey2,
                                      fontSize: size.textSmall,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins"),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: size.s8),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: size.s16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.visibility,
                                      size: size.s12,
                                      color: clr.iconColorGrey,
                                    ),
                                    SizedBox(width: size.s4),
                                    Text(
                                      data.title,
                                      style: TextStyle(
                                          color: clr.iconColorGrey,
                                          fontSize: size.textXXXSmall,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins"),
                                    ),
                                    SizedBox(width: size.s8),
                                    Icon(
                                      Icons.access_time_filled,
                                      size: size.s12,
                                      color: clr.iconColorGrey,
                                    ),
                                    SizedBox(width: size.s4),
                                    Expanded(
                                      child: Text(
                                        data.title,
                                        style: TextStyle(
                                            color: clr.iconColorGrey,
                                            fontSize: size.textXXXSmall,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Poppins"),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: size.s8),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: size.s16),
                                child: Text(
                                  "Published by: ${data.uploadedBy.firstName} ${data.uploadedBy.lastName}",
                                  style: TextStyle(
                                      color: clr.textColorGrey2,
                                      fontSize: size.textXSmall,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                              SizedBox(height: size.s8),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: size.s16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () => Share.share(data.videoUrl),
                                      child: Container(
                                        padding: EdgeInsets.all(size.s8),
                                        decoration: BoxDecoration(
                                          color: clr.iconsBgColorBlue,
                                          borderRadius:
                                              BorderRadius.circular(size.s12),
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                ImageAssets.icShare),
                                            SizedBox(width: size.s8),
                                            Text(
                                              "Share",
                                              style: TextStyle(
                                                  color: clr.greyVideoTitle,
                                                  fontSize: size.textXXSmall,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Poppins"),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: size.s8),
                                    GestureDetector(
                                      onTap: () {
                                        doBookmark(data.id);
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(size.s8),
                                          decoration: BoxDecoration(
                                            color: clr.iconsBgColorBlue,
                                            borderRadius:
                                                BorderRadius.circular(size.s12),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.bookmark_outlined,
                                                size: size.s16,
                                                color: data.isBookmarked
                                                    ? clr.iconsColorBlue
                                                    : clr.grayColor,
                                              ),
                                              SizedBox(width: size.s8),
                                              Text(
                                                "Bookmark",
                                                style: TextStyle(
                                                    color: clr.greyVideoTitle,
                                                    fontSize: size.textXXSmall,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Poppins"),
                                              )
                                            ],
                                          )),
                                    ),
                                    SizedBox(width: size.s8),
                                    GestureDetector(
                                      onTap: () => onTapGiveScore(
                                          data.id, data.feedback),
                                      child: Container(
                                          padding: EdgeInsets.all(size.s8),
                                          decoration: BoxDecoration(
                                            color: clr.iconsBgColorBlue,
                                            borderRadius:
                                                BorderRadius.circular(size.s12),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.beenhere,
                                                size: size.s16,
                                                color: clr.iconsColorBlue,
                                              ),
                                              SizedBox(width: size.s8),
                                              Text(
                                                "Give Score",
                                                style: TextStyle(
                                                    color: clr.greyVideoTitle,
                                                    fontSize: size.textXXSmall,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Poppins"),
                                              )
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: size.s8),

                              ///Feedback Comment
                              AppStreamBuilder<List<CommentEntity>>(
                                stream: commentStreamController.stream,
                                loadingBuilder: (context) {
                                  return const Center(
                                    child: CircularLoader(),
                                  );
                                },
                                dataBuilder: (context, data2) {
                                  return CommentItemSectionWidget(
                                      onTapViewAll: () => onTapViewAll(data2),
                                      items: data2,
                                      buildItem: (BuildContext context,
                                              int index, item) =>
                                          CommentItemWidget(data: item));
                                },
                                emptyBuilder: (context, message, icon) {
                                  return const Offstage();
                                },
                              ),
                              SizedBox(height: size.s12),

                              ///Feedback Score
                              AppStreamBuilder<List<FeedbackScoreEntity>>(
                                stream: feedbackScoreStreamController.stream,
                                loadingBuilder: (context) {
                                  return const Center(
                                    child: CircularLoader(),
                                  );
                                },
                                dataBuilder: (context, data3) {
                                  return ScoreItemSectionWidget(
                                      onTapViewAll: () =>
                                          onTapScoreViewAll(data.id),
                                      items: data3,
                                      buildItem: (BuildContext context,
                                              int index, item) =>
                                          ScoreItemWidget(
                                            data: item,
                                            onTap: () => onTapScoreDetails(
                                                screenArgs.videoId,
                                                item.scoredBy.id),
                                          ));
                                },
                                emptyBuilder: (context, message, icon) {
                                  return const Offstage();
                                },
                              ),
                              SizedBox(height: size.s12),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: size.s16),
                                child: Text(
                                  "Speaker ratio",
                                  style: TextStyle(
                                      color: clr.textColorGrey2,
                                      fontSize: size.textSmall,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                              SizedBox(height: size.s12),
                              Container(
                                width: double.infinity,
                                margin:
                                    EdgeInsets.symmetric(horizontal: size.s16),
                                padding: EdgeInsets.all(size.s12),
                                decoration: BoxDecoration(
                                  color: clr.ratioBGColor,
                                  borderRadius: BorderRadius.circular(size.s10),
                                  border: Border.all(
                                      color: clr.ratioStrokeColor,
                                      width: size.s1),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Speaker 1: 64%",
                                      style: TextStyle(
                                          color: clr.textColorGrey2,
                                          fontSize: size.textXXSmall,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins"),
                                    ),
                                    SizedBox(height: size.s4),
                                    Container(
                                      color: clr.ratioSpeakerColor,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                    ),
                                    SizedBox(height: size.s8),
                                    Text(
                                      "Speaker 2: 36%",
                                      style: TextStyle(
                                          color: clr.textColorGrey2,
                                          fontSize: size.textXXSmall,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins"),
                                    ),
                                    SizedBox(height: size.s4),
                                    Container(
                                      color: clr.ratioSpeakerColor,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: size.s64 * 2)
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.s16, vertical: size.s10),
                              decoration: BoxDecoration(
                                color: clr.whiteColor,
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, -2),
                                      blurRadius: size.s4,
                                      spreadRadius: 0,
                                      color: clr.blackColor.withOpacity(.1))
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FeedBackWidget(
                                    title: "Good",
                                    image: ImageAssets.chat,
                                    bgColor: clr.bgImprove,
                                    textColor: clr.improveText,
                                    onTap: () {
                                      onTapComment(
                                          true,
                                          data.id,
                                          data.feedback.id.toString(),
                                          data.feedback.formCategories,
                                          videoStartTime,
                                          videoEndTime);
                                      print(
                                          '_VideoDetailsScreenState.build$videoStartTime$videoEndTime');
                                    },
                                  ),
                                  size.s16.kWidth,
                                  FeedBackWidget(
                                    title: "Improvement",
                                    image: ImageAssets.chat,
                                    bgColor: clr.bgGood,
                                    textColor: clr.blueText,
                                    onTap: () => onTapComment(
                                        false,
                                        data.id,
                                        data.feedback.id.toString(),
                                        data.feedback.formCategories,
                                        videoStartTime,
                                        videoEndTime),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
              ],
            );
          },
          emptyBuilder: (context, message, icon) {
            return const Offstage();
          },
        ),
        // floatingActionButton: Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Container(
        //       width: double.infinity,
        //       padding: EdgeInsets.symmetric(
        //           horizontal: size.s16, vertical: size.s10),
        //       decoration: BoxDecoration(
        //         color: clr.whiteColor,
        //         boxShadow: [
        //           BoxShadow(
        //               offset: const Offset(0, -2),
        //               blurRadius: size.s4,
        //               spreadRadius: 0,
        //               color: clr.blackColor.withOpacity(.1))
        //         ],
        //       ),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           FeedBackWidget(
        //             title: "Good",
        //             image: ImageAssets.chat,
        //             bgColor: clr.bgImprove,
        //             textColor: clr.improveText,
        //           ),
        //           size.s16.kWidth,
        //           FeedBackWidget(
        //             title: "Improvement",
        //             image: ImageAssets.chat,
        //             bgColor: clr.bgGood,
        //             textColor: clr.blueText,
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }

  void onTapViewAll(List<CommentEntity> commentEntity) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CommentsBottomSheet(
        commentEntity: commentEntity,
      ),
    );
  }

  void onTapComment(bool isGood, String videoId, String feedbackId,
      List<FormCategory> fomCategory, String startTime, String endTime) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CommentCreateBottomSheet(
        isGood: isGood,
        videoId: videoId,
        feedbackId: feedbackId,
        formCategory: fomCategory,
        startTime: startTime,
        endTime: endTime,
        onSuccess: () {
          loadCommentData(videoId);
        },
      ),
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
  void navigateToFeedbackScoreDetailsScreen(
      String videoId, String feedbackScoreId) {
    Navigator.of(context).pushNamed(AppRoute.feedbackScoreDetailsScreen,
        arguments:
            FeedbackScoreArgs(videoId: videoId, scoreId: feedbackScoreId));
  }

  @override
  void navigateToFeedbackScoreListScreen(String videoId) {
    Navigator.of(context).pushNamed(AppRoute.feedbackScoreScreen,
        arguments: FeedbackScoreArgs(videoId: videoId));
  }

  @override
  void navigateToGiveFeedbackScoreScreen(
      String videoId, FeedbackEntity feedback) {
    Navigator.of(context).pushNamed(AppRoute.giveFeedbackScoreScreen,
        arguments: GiveScoreScreenArgs(
            videoId: videoId,
            feedback: feedback,
            onSuccess: () => loadFeedbackScoreData(videoId)));
  }
}

class CommentItemSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  final VoidCallback? onTapViewAll;
  const CommentItemSectionWidget({
    super.key,
    required this.items,
    required this.buildItem,
    this.onTapViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.s16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "User Feedbacks",
                style: TextStyle(
                    color: clr.textColorBlack1,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins"),
              ),
              if (items.isNotEmpty)
                GestureDetector(
                  onTap: onTapViewAll,
                  child: Container(
                    color: Colors.white,
                    child: Text(
                      "View all (${items.length})",
                      style: TextStyle(
                          color: clr.textColorGrey2,
                          fontSize: size.textXXSmall,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins"),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: size.s8),
        items.isNotEmpty
            ? ListView.separated(
                itemCount: items.length >= 2 ? 2 : items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: size.s16),
                itemBuilder: (context, index) {
                  return buildItem(context, index, items[index]);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: size.s12);
                },
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.s16),
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
                  SizedBox(height: size.s42),
                  Center(
                    child: SvgPicture.asset(
                      ImageAssets.groupImage,
                      height: 190,
                      width: 116,
                    ),
                  ),
                  SizedBox(height: size.s16),
                ],
              ),
      ],
    );
  }
}

class CommentItemWidget extends StatelessWidget with AppTheme {
  final CommentEntity data;
  const CommentItemWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: size.s4),
      decoration: BoxDecoration(
        color: clr.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SvgPicture.asset(ImageAssets.icProfile),
              SizedBox(width: size.s8),
              Text(
                "${data.createdBy.firstName} ${data.createdBy.lastName}",
                style: TextStyle(
                    color: clr.textColorGrey2,
                    fontSize: size.textXSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins"),
              ),
              SizedBox(width: size.s8),
              Icon(
                Icons.circle,
                size: size.s4,
                color: clr.circleDotColor,
              ),
              SizedBox(width: size.s8),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.s8, vertical: size.s2),
                decoration: BoxDecoration(
                  color: clr.commentBgColor,
                  borderRadius: BorderRadius.circular(size.s4),
                ),
                child: Text(
                  "${data.startTime} - ${data.endTime}",
                  style: TextStyle(
                      color: clr.profileCardTextColor,
                      fontSize: size.textXXSmall,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins"),
                ),
              ),
              SizedBox(width: size.s8),
              SvgPicture.asset(
                ImageAssets.chat,
                color: clr.improveText,
              )
            ],
          ),
          SizedBox(height: size.s8),
          Container(
            width: double.infinity,
            padding:
                EdgeInsets.symmetric(horizontal: size.s16, vertical: size.s12),
            decoration: BoxDecoration(
              color: data.feedbackType.choice == "good"
                  ? clr.bgImprove
                  : clr.bgGood,
              borderRadius: BorderRadius.circular(size.s8),
              border: Border.all(
                  color: data.feedbackType.choice == "good"
                      ? clr.improveText
                      : clr.blueText,
                  width: size.s1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.feedbackCategory.name,
                  style: TextStyle(
                      color: clr.profileCardTextColor,
                      fontSize: size.textXSmall,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins"),
                ),
                SizedBox(height: size.s8),
                Text(
                  data.feedbackType.name,
                  style: TextStyle(
                      color: clr.improveText,
                      fontSize: size.textXSmall,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScoreItemSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  final VoidCallback? onTapViewAll;
  const ScoreItemSectionWidget({
    super.key,
    required this.items,
    required this.buildItem,
    this.onTapViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return items.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.s16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Feedback Score",
                      style: TextStyle(
                          color: clr.textColorBlack1,
                          fontSize: size.textSmall,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins"),
                    ),
                    if (items.length > 1)
                      GestureDetector(
                        onTap: onTapViewAll,
                        child: Container(
                          color: Colors.white,
                          child: Text(
                            "View all (${items.length})",
                            style: TextStyle(
                                color: clr.textColorGrey2,
                                fontSize: size.textXXSmall,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins"),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: size.s8),
              ListView.separated(
                itemCount: items.length > 1 ? 1 : items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: size.s16),
                itemBuilder: (context, index) {
                  return buildItem(context, index, items[index]);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: size.s12);
                },
              ),
            ],
          )
        : const Offstage();
  }
}
