import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/constants/common_imports.dart';
import '../services/video_details_screen_service.dart';
import '../widgets/feed_back_widget.dart';
import '../../../common/widgets/app_scaffold.dart';
import '../../../common/widgets/custom_button.dart';
import '../../video_upload/video_player_widget.dart';

class VideoDetailsScreen extends StatefulWidget {
  const VideoDetailsScreen({super.key});

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen>
    with VideoDetailsScreenService, AppTheme {
  @override
  void initState() {
    ///Initially load course details
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadInitialData(
          "https://colearning.s3.ap-southeast-1.amazonaws.com/videos%2F20241230_044004_BigBuckBunny.mp4");
    });
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        // title: "Video Upload",
        body: SingleChildScrollView(
          child: Column(
            children: [
              PreviewPlayerWidget(
                playerStream: playerStreamController.stream,
                playbackStream: playbackPausePlayStreamController.stream,
                onProgressChanged: onPlaybackProgressChanged,
                interceptSeekTo: onInterceptPlaybackSeekToPosition,
                // overlay: GestureDetector(
                //   onTap: onGoBack,
                //   child: const BackButtonWidget(),
                // ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(color: Color(0xffF5F5F5)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
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
                    Column(
                      children: [
                        Icon(Icons.menu_book_outlined,
                            color: Color(
                              0xff717680,
                            ),
                            size: 20),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Score Sheet Entry",
                          style: TextStyle(
                              color: Color(
                                0xff717680,
                              ),
                              fontSize: 14),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.s16, vertical: size.s20),
                child: const Text(
                  "If you have feedback on an individual scene, it will be displayed here.",
                  style: TextStyle(color: Color(0xff7A7E87), fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: size.s32,
              ),
              SvgPicture.asset(
                ImageAssets.groupImage,
                height: 57,
                width: 95,
              ),
              SizedBox(
                height: size.s64 * 5,
              )
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FeedBackWidget(
                    title: "Good",
                    image: ImageAssets.chat,
                    bgColor: clr.bgImprove,
                    textColor: clr.improveText,
                  ),
                  size.s16.kWidth,
                  FeedBackWidget(
                    title: "Improvement",
                    image: ImageAssets.chat,
                    bgColor: clr.bgGood,
                    textColor: clr.blueText,
                  ),
                ],
              ),
            ),
          ],
        ),
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
    // TODO: implement showSuccess
  }

  @override
  void showWarning(String message) {
    // TODO: implement showWarning
  }
}
