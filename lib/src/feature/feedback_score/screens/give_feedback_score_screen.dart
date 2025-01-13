import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/constants/app_theme.dart';
import '../../../common/constants/common_imports.dart';
import '../../../common/routes/app_route_args.dart';
import '../../../common/utility/app_label.dart';
import '../../../common/widgets/action_button.dart';
import '../../../common/widgets/app_scaffold.dart';
import '../../bookmark/models/form_category_type.dart';
import '../services/give_feedback_score_service.dart';
import '../widgets/give_score_category_widget.dart';
import '../widgets/score_category_widget.dart';
import '../../../common/widgets/custom_toasty.dart';

class GiveFeedbackScoreScreen extends StatefulWidget {
  final Object? arguments;
  const GiveFeedbackScoreScreen({super.key, this.arguments})
      : assert(arguments != null && arguments is GiveScoreScreenArgs);

  @override
  State<GiveFeedbackScoreScreen> createState() =>
      _GiveFeedbackScoreScreenState();
}

class _GiveFeedbackScoreScreenState extends State<GiveFeedbackScoreScreen>
    with AppTheme, GiveFeedbackScoreService {
  @override
  void initState() {
    screenArgs = widget.arguments as GiveScoreScreenArgs;
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   loadInitialData(screenArgs.videoId);
    //   loadCommentData(screenArgs.videoId);
    // });
    super.initState();
  }

  int totalSelectedScore = 0;

  void updateTotalScore(int previousScore, int newScore) {
    setState(() {
      // Only update the total if the previous score wasn't -1 (it was selected previously)
      if (previousScore != -1) {
        totalSelectedScore -= previousScore; // Subtract the old score
      }

      // If the new score isn't -1, add it to the total
      if (newScore != -1) {
        totalSelectedScore += newScore;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bgColor: clr.backgroundColor1,
      title: label(e: "Give score", b: "Give score"),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: size.s16, vertical: size.s8),
            decoration: BoxDecoration(
              color: clr.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // Shadow color
                  offset: const Offset(0, -10), // Move shadow upwards
                  blurRadius: 10, // Softness of the shadow
                  spreadRadius: 5, // Spread the shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: size.s16, vertical: size.s8),
                  decoration: BoxDecoration(
                    color: clr.scoreCardColor2,
                    borderRadius: BorderRadius.circular(size.s8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total score:",
                        style: TextStyle(
                            color: clr.toggleIconColorColor,
                            fontSize: size.textSmall,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins"),
                      ),
                      Text(
                        totalSelectedScore.toString(),
                        style: TextStyle(
                            color: clr.appPrimaryColor,
                            fontSize: size.textMedium,
                            fontWeight: FontWeight.w800,
                            fontFamily: "Poppins"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.s12),
                ActionButton(
                  buttonColor: clr.appPrimaryColor,
                  title: "Save",
                  radius: size.s8,
                  tapAction: () =>
                      giveScore(screenArgs.videoId, screenArgs.feedback),
                  onSuccess: (x) {
                    Navigator.pop(context, x);
                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: size.s16, vertical: size.s12),
        decoration: BoxDecoration(
            color: clr.whiteColor,
            border: Border(
                top: BorderSide(color: clr.textFieldStrokeColor, width: 1.w))),
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
                            color: clr.scoreCardBorderColor, width: size.s4))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.assignment_turned_in_outlined,
                      color: clr.scoreIconColor,
                      size: size.s42 - size.s2,
                    ),
                    SizedBox(width: size.s12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Feedback criteria:",
                            style: TextStyle(
                                color: clr.toggleIconColorColor,
                                fontSize: size.textSmall,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins"),
                          ),
                          SizedBox(height: size.s4),
                          Text(
                            screenArgs.feedback.name,
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
              ListView.separated(
                itemCount: screenArgs.feedback.formCategories.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final item = screenArgs.feedback.formCategories[index];

                  return GiveScoreCategoryWidget(
                    categoryTitle: item.category.name,
                    index: index + 1,
                    items: item.formCategoryTypes,
                    onScoreSelected:
                        (int score, FormCategoryType selectedItem) {
                      int previousScore = selectedItem.type.score;

                      // Update the total score based on the new selection
                      updateTotalScore(previousScore, score);
                      setState(() {
                        selectedItem.type.score = score;
                      });
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: size.s16);
                },
              ),
            ],
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
}
