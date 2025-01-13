import 'package:co_learning_mobile_app/src/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/constants/app_theme.dart';
import '../../../common/widgets/app_scroll_view.dart';
import '../../../common/widgets/good_improvment_tab_widget.dart';
import '../../bookmark/models/feedback.dart';
import '../../bookmark/models/form_category.dart';

class FeedBackDetailsBottomSheet extends StatefulWidget {
  final FeedbackEntity data;
  const FeedBackDetailsBottomSheet({super.key, required this.data});

  @override
  _ExamInstructionBottomSheetState createState() =>
      _ExamInstructionBottomSheetState();
}

class _ExamInstructionBottomSheetState extends State<FeedBackDetailsBottomSheet>
    with AppTheme {
  final GlobalKey _bodyKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Material(
            color: Colors.transparent,
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: clr.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size.s20),
                    topRight: Radius.circular(size.s20 ),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///Title
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.s16, vertical: size.s10),
                          child: Text(
                            'Preview Evaluation Criteria',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: clr.iconColorGray,
                              fontWeight: FontWeight.w500,
                              fontSize: size.textXSmall,
                            ),
                          ),
                        ),
                        Divider(
                          color: clr.dividerColorGray,
                        ),
                        SizedBox(
                          height: size.s16,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.s16,
                          ),
                          child: Text(
                            widget.data.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: size.textSmall,
                                color: clr.profileCardTextColor),
                          ),
                        ),
                        SizedBox(
                          height: size.s16,
                        ),

                        /// Result Details
                        GoodImprovementSectionTab(
                          key: _bodyKey,
                          builder: (context, index) {
                            switch (index) {
                              case 0:
                                return feedbackListWidget(
                                  widget.data.formCategories,
                                  "good",
                                );

                              case 1:
                                return feedbackListWidget(
                                  widget.data.formCategories,
                                  "improvement",
                                );

                              ///Loading state
                              default:
                                return Container();
                            }
                          },
                        ),
                       /* Divider(
                          color: clr.dividerColorGray,
                        ),
                        CustomButton(onTap: ()=>Navigator.pop(context)  , title: "Ok")*/

                      ]),
                ))));
  }

  Widget feedbackListWidget(
      List<FormCategory> formCategories, String filterChoice) {
    return AspectRatio(
      aspectRatio: 1, // Define the height for the ListView area
      child: ListView.builder(
        itemCount: formCategories.length,
        padding: EdgeInsets.symmetric(horizontal: size.s16, vertical: size.s10),
        itemBuilder: (BuildContext context, int index) {
          final category = formCategories[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${index + 1}. ${category.category.name}",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: size.textXSmall,
                    color: clr.textColorBlack),
              ),
              SizedBox(height: size.s10),
              Wrap(
                spacing: size.s10,
                runSpacing: size.s10,
                children: category.formCategoryTypes
                    .where((i) => i.type.choice?.toLowerCase() == filterChoice)
                    .map((i) => Container(
                  width: 160.w,
                  padding: EdgeInsets.symmetric(
                    vertical: size.s12,
                    horizontal: size.s16,
                  ),
                  decoration: BoxDecoration(
                    color: clr.greyBorder,
                    borderRadius: BorderRadius.circular(size.s8),
                  ),
                  child: Center(
                    child: Text(
                      i.type.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: size.textXXSmall,
                        color: clr.textColorBlack1,
                      ),
                    ),
                  ),
                ))
                    .toList(),
              ),
              SizedBox(height: size.s10),
            ],
          );
        },
      ),
    );
  }

}

