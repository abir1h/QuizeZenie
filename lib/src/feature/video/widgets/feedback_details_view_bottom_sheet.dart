import 'package:flutter/material.dart';

import '../../../common/constants/app_theme.dart';
import '../../../common/widgets/app_scroll_view.dart';
import '../../../common/widgets/good_improvment_tab_widget.dart';
import '../../bookmark/models/feedback.dart';

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
                    topLeft: Radius.circular(size.s32),
                    topRight: Radius.circular(size.s32),
                  ),
                ),
                child: Padding(
                    padding: EdgeInsets.only(
                      left: size.s24,
                      right: size.s24,
                      bottom: size.s16,
                    ),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      ///Title
                      Container(
                        margin: EdgeInsets.only(bottom: size.s8, top: size.s8),
                        padding: EdgeInsets.symmetric(
                            vertical: size.s8, horizontal: size.s24),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: clr.blackColor.withOpacity(.4),
                            ),
                          ),
                        ),
                        child: Text(
                          'Preview Evaluation Criteria',
                          style: TextStyle(
                            color: clr.textBlackLight,
                            fontSize: size.textXXSmall,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.s24,
                      ),

                      /// Result Details
                      Flexible(
                        child: AppScrollView(
                          padding: EdgeInsets.only(bottom: size.s16),
                          child: Column(
                            children: [
                              GoodImprovementSectionTab(
                                key: _bodyKey,
                                builder: (context, index) {
                                  switch (index) {
                                    case 0:
                                      return Container(
                                        child: Text("good"),
                                      );

                                    case 1:
                                      return Container(
                                        child: Text("improvment"),
                                      );

                                    ///Loading state
                                    default:
                                      return Container();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ])))));
  }
}
