import 'dart:io';

import 'package:co_learning_mobile_app/src/common/widgets/app_scaffold.dart';
import 'package:co_learning_mobile_app/src/common/widgets/custom_button.dart';
import 'package:co_learning_mobile_app/src/feature/video_upload/video_player_widget.dart';
import 'package:co_learning_mobile_app/src/feature/video_upload/video_upload_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/constants/common_imports.dart';
import '../video/widgets/feed_back_widget.dart';

class VideoUploadScreen extends StatefulWidget {
  final File videoAssets;
  const VideoUploadScreen({super.key, required this.videoAssets});

  @override
  State<VideoUploadScreen> createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoUploadScreen>
    with VideoDetailsScreenService, AppTheme {
  @override
  void initState() {
    ///Initially load course details
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadInitialData(widget.videoAssets.path);
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
              SingleChildScrollView(
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
                        style:
                            TextStyle(color: Color(0xff7A7E87), fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: size.s32,
                    ),
                    SvgPicture.asset(ImageAssets.groupImage,
                    height: 57,
                      width: 95,
                    ),
                    SizedBox(
                      height: size.s64 * 5,
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.s16, vertical: size.s10),
                    decoration: BoxDecoration(
                      color: clr.whiteColor,
                      boxShadow: [
                        BoxShadow(
                            offset:const Offset(0, -2),
                            blurRadius: size.s4,
                            spreadRadius: 0,
                            color: clr.blackColor.withOpacity(.1))
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            FeedBackWidget(
                              title: "Good",
                              image: ImageAssets.chat,
                              bgColor: clr.bgGood,
                              textColor: clr.blueText,
                            ),
                            size.s16.kWidth,
                            FeedBackWidget(
                              title: "Improve",
                              image: ImageAssets.chat,
                              bgColor: clr.bgImprove,
                              textColor: clr.improveText,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.s10,
                        ),
                        CustomButton(onTap: () {}, title: "Continue")
                      ],
                    ),
                  )
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
    // TODO: implement showSuccess
  }

  @override
  void showWarning(String message) {
    // TODO: implement showWarning
  }
}
