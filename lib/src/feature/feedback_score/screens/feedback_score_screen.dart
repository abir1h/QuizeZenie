import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/constants/common_imports.dart';
import '../../../common/routes/app_route.dart';
import '../../../common/routes/app_route_args.dart';
import '../../../common/utility/app_label.dart';
import '../../../common/widgets/app_scaffold.dart';
import '../../../common/widgets/app_stream.dart';
import '../../../common/widgets/circular_loader.dart';
import '../../../common/widgets/paginated_list_view.dart';
import '../../bookmark/screens/bookmark_screen.dart';
import '../models/feedback_score_entity.dart';
import '../services/feedback_score_screen_service.dart';

class FeedbackScoreScreen extends StatefulWidget {
  final Object? arguments;
  const FeedbackScoreScreen({super.key, this.arguments})
      : assert(arguments != null && arguments is FeedbackScoreArgs);

  @override
  State<FeedbackScoreScreen> createState() => _FeedbackScoreScreenState();
}

class _FeedbackScoreScreenState extends State<FeedbackScoreScreen>
    with AppTheme, FeedbackScoreScreenService {
  @override
  void initState() {
    screenArgs = widget.arguments as FeedbackScoreArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadInitialData(screenArgs.videoId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        bgColor: clr.backgroundColor1,
        title: label(e: "View All Scores", b: "View All Scores"),
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
          child: AppStreamBuilder<
              PaginatedListViewController<FeedbackScoreEntity>>(
            stream: feedbackScoreStreamController.stream,
            loadingBuilder: (context) {
              return const Center(
                child: CircularLoader(),
              );
            },
            dataBuilder: (context, data) {
              return PaginatedListView<FeedbackScoreEntity>(
                controller: paginationController,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, item, index) {
                  return ScoreItemWidget(
                    data: item,
                    onTap: () =>
                        onTapScoreDetails(screenArgs.videoId, item.scoredBy.id),
                  );
                },
                separatorBuilder: (context) {
                  return SizedBox(height: size.s12);
                },
                loaderBuilder: (context) => Padding(
                  padding: EdgeInsets.all(size.s4),
                  child: Center(
                    child: CircularLoader(
                      loaderSize: size.s16,
                    ),
                  ),
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

  @override
  void navigateToFeedbackScoreDetailsScreen(
      String videoId, String feedbackScoreId) {
    Navigator.of(context).pushNamed(AppRoute.feedbackScoreDetailsScreen,
        arguments:
            FeedbackScoreArgs(videoId: videoId, scoreId: feedbackScoreId));
  }
}

class ScoreItemWidget extends StatelessWidget with AppTheme {
  final FeedbackScoreEntity data;
  final VoidCallback onTap;
  const ScoreItemWidget({
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
                    "${data.scoredBy.firstName} ${data.scoredBy.lastName}",
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
                  data.userTotalScore.toString(),
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
