import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/constants/app_theme.dart';
import '../../../common/constants/common_imports.dart';
import '../../../common/routes/app_route_args.dart';
import '../../../common/utility/app_label.dart';
import '../../../common/widgets/app_scaffold.dart';
import '../widgets/score_category_widget.dart';

class FeedbackScoreDetailsScreen extends StatefulWidget {
  final Object? arguments;
  const FeedbackScoreDetailsScreen({super.key, this.arguments})
      : assert(arguments != null && arguments is VideoDetailsScreenArgs);

  @override
  State<FeedbackScoreDetailsScreen> createState() =>
      _FeedbackScoreDetailsScreenState();
}

class _FeedbackScoreDetailsScreenState extends State<FeedbackScoreDetailsScreen>
    with AppTheme {
  @override
  void initState() {
    // screenArgs = widget.arguments as VideoDetailsScreenArgs;
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   loadInitialData(screenArgs.videoId);
    //   loadCommentData(screenArgs.videoId);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        bgColor: clr.backgroundColor1,
        title: label(e: "View score details", b: "View score details"),
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          padding:
              EdgeInsets.symmetric(horizontal: size.s16, vertical: size.s12),
          decoration: BoxDecoration(
              color: clr.whiteColor,
              border: Border(
                  top:
                      BorderSide(color: clr.textFieldStrokeColor, width: 1.w))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.s12, vertical: size.s8),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [clr.scoreCardColor, clr.whiteColor]),
                      borderRadius: BorderRadius.circular(size.s8),
                      border: Border(
                          left: BorderSide(
                              color: clr.scoreCardBorderColor,
                              width: size.s4))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(ImageAssets.icProfile),
                      SizedBox(width: size.s8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "User Name",
                              style: TextStyle(
                                  color: clr.toggleIconColorColor,
                                  fontSize: size.textSmall,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins"),
                            ),
                            Text(
                              "Total Score: 20 Points",
                              style: TextStyle(
                                  color: clr.toggleIconColorColor,
                                  fontSize: size.textXXSmall,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.s16),
                // ListView.separated(
                //   itemCount: 5,
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   padding: EdgeInsets.zero,
                //   itemBuilder: (context, index) {
                //     return const ScoreCategoryWidget(
                //         chapterTitle: "1. Preparation and planning.");
                //   },
                //   separatorBuilder: (context, index) {
                //     return SizedBox(height: size.s16);
                //   },
                // ),
              ],
            ),
          ),
        ));
  }
}
