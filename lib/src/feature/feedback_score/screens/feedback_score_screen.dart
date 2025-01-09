import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/constants/app_theme.dart';
import '../../../common/constants/common_imports.dart';
import '../../../common/routes/app_route_args.dart';
import '../../../common/utility/app_label.dart';
import '../../../common/widgets/app_scaffold.dart';

class FeedbackScoreScreen extends StatefulWidget {
  final Object? arguments;
  const FeedbackScoreScreen({super.key, this.arguments})
      : assert(arguments != null && arguments is VideoDetailsScreenArgs);

  @override
  State<FeedbackScoreScreen> createState() => _FeedbackScoreScreenState();
}

class _FeedbackScoreScreenState extends State<FeedbackScoreScreen>
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
          child: FeedbackScoreItemSectionWidget(
              items: ["", "", "", "", "", ""],
              buildItem: (BuildContext context, int index, item) =>
                  ScoreItemWidget(
                    onTap: () {},
                  )),
        ));
  }
}

class FeedbackScoreItemSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const FeedbackScoreItemSectionWidget({
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

class ScoreItemWidget extends StatelessWidget with AppTheme {
  // final CommentEntity data;
  final VoidCallback onTap;
  const ScoreItemWidget({
    super.key,
    // required this.data,
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
