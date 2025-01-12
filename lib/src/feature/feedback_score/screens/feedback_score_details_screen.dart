import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/constants/common_imports.dart';
import '../../../common/routes/app_route_args.dart';
import '../../../common/utility/app_label.dart';
import '../../../common/widgets/app_scaffold.dart';
import '../../../common/widgets/app_stream.dart';
import '../../../common/widgets/circular_loader.dart';
import '../../bookmark/screens/bookmark_screen.dart';
import '../models/feedback_score_details_entity.dart';
import '../models/feedback_score_entity.dart';
import '../services/feedback_score_details_screen_service.dart';
import '../widgets/score_category_widget.dart';

class FeedbackScoreDetailsScreen extends StatefulWidget {
  final Object? arguments;
  const FeedbackScoreDetailsScreen({super.key, this.arguments})
      : assert(arguments != null && arguments is FeedbackScoreArgs);

  @override
  State<FeedbackScoreDetailsScreen> createState() =>
      _FeedbackScoreDetailsScreenState();
}

class _FeedbackScoreDetailsScreenState extends State<FeedbackScoreDetailsScreen>
    with AppTheme, FeedbackScoreDetailsScreenService {
  @override
  void initState() {
    screenArgs = widget.arguments as FeedbackScoreArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadFeedbackScoreData(screenArgs.videoId, screenArgs.scoreId!);
    });
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
          child: AppStreamBuilder<FeedbackScoreDetailsEntity>(
            stream: feedbackScoreStreamController.stream,
            loadingBuilder: (context) {
              return const Center(
                child: CircularLoader(),
              );
            },
            dataBuilder: (context, data) {
              return SingleChildScrollView(
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
                                  "${data.scoredBy.firstName} ${data.scoredBy.lastName}",
                                  style: TextStyle(
                                      color: clr.toggleIconColorColor,
                                      fontSize: size.textSmall,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins"),
                                ),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: label(
                                        e: "Total Score: ", b: "Total Score: "),
                                    style: TextStyle(
                                        color: clr.toggleIconColorColor,
                                        fontSize: size.textXXSmall,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins"),
                                    children: [
                                      TextSpan(
                                        text: label(
                                            e: data.totalScore.toString(),
                                            b: data.totalScore.toString()),
                                        style: TextStyle(
                                            color: clr.toggleIconColorColor,
                                            fontSize: size.textXXSmall,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Poppins"),
                                      ),
                                      TextSpan(
                                        text: label(e: " Points", b: " Points"),
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
                        ],
                      ),
                    ),
                    SizedBox(height: size.s16),
                    ListView.separated(
                      itemCount: data.categories.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final item = data.categories[index];
                        return ScoreCategoryWidget(
                          categoryTitle: item.categoryName,
                          index: index,
                          items: item.types,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: size.s16);
                      },
                    ),
                  ],
                ),
              );
            },
            emptyBuilder: (context, message, icon) {
              return EmptyStateWidget(
                message: message,
                icon: ImageAssets.icBookmarkFilled,
              );
            },
          ),
        ));
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
