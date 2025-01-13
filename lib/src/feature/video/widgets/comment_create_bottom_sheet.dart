import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/constants/app_theme.dart';
import '../../../common/widgets/action_button.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_toasty.dart';
import '../../bookmark/models/feedback.dart';
import '../../bookmark/models/form_category.dart';
import '../../bookmark/models/form_category_type.dart';
import '../models/comment_entity.dart';
import '../screens/video_details_screen.dart';
import '../services/video_details_screen_service.dart';

/*class CommentCreateBottomSheet extends StatefulWidget {
  final bool isGood;
  final List<FormCategory> formCategory;
  const CommentCreateBottomSheet(
      {super.key, required this.isGood, required this.formCategory});

  @override
  State<CommentCreateBottomSheet> createState() =>
      _CommentCreateBottomSheetState();
}

class _CommentCreateBottomSheetState extends State<CommentCreateBottomSheet>
    with AppTheme {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            // padding:
            //     EdgeInsets.symmetric(horizontal: size.s16, vertical: size.s12),
            decoration: BoxDecoration(
              color: clr.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.s12),
                topRight: Radius.circular(size.s12),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BottomSheetCommentItemSectionWidget(
                      items: widget.formCategory,
                      buildItem: (BuildContext context, int index, item) =>
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${index + 1}. ${item.category.name}",
                                style: TextStyle(
                                    color: clr.profileCardTextColor,
                                    fontSize: size.textXSmall,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins"),
                              ),
                              SizedBox(height: size.s8),
                              AspectRatio(
                                aspectRatio: 8,
                                child: ListView.separated(
                                  itemCount: widget.isGood
                                      ? item.formCategoryTypes
                                          .where((category) =>
                                              category.type.choice == "good")
                                          .length
                                      : item.formCategoryTypes
                                          .where((category) =>
                                              category.type.choice ==
                                              "improvement")
                                          .length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index2) {
                                    var filteredItem = widget.isGood
                                        ? item.formCategoryTypes
                                            .where((category) =>
                                                category.type.choice == "good")
                                            .toList()[index2]
                                        : item.formCategoryTypes
                                            .where((category) =>
                                                category.type.choice ==
                                                "improvement")
                                            .toList()[index2];
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.s16,
                                          vertical: size.s12),
                                      decoration: BoxDecoration(
                                        color: clr.greyBorder,
                                        borderRadius:
                                            BorderRadius.circular(size.s8),
                                      ),
                                      child: Text(
                                        filteredItem.type.name,
                                        style: TextStyle(
                                            color: clr.textColorBlack1,
                                            fontSize: size.textXXSmall,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Poppins"),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(width: size.s28);
                                  },
                                ),
                              )
                            ],
                          )),
                  SizedBox(height: size.s64),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}*/

class CommentCreateBottomSheet extends StatefulWidget {
  final bool isGood;
  final String videoId;
  final String feedbackId;
  final List<FormCategory> formCategory;

  const CommentCreateBottomSheet({
    super.key,
    required this.isGood,
    required this.videoId,
    required this.feedbackId,
    required this.formCategory,
  });

  @override
  State<CommentCreateBottomSheet> createState() =>
      _CommentCreateBottomSheetState();
}

class _CommentCreateBottomSheetState extends State<CommentCreateBottomSheet>
    with VideoDetailsScreenService, AppTheme {
  // Helper method to filter form category types based on choice
  List<FormCategoryType> _filterFormCategoryTypes(FormCategory item) {
    return item.formCategoryTypes
        .where((category) =>
            category.type.choice == (widget.isGood ? "good" : "improvement"))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: BoxDecoration(
              color: clr.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.s12),
                topRight: Radius.circular(size.s12),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BottomSheetCommentItemSectionWidget(
                    items: widget.formCategory,
                    buildItem: (BuildContext context, int index, item) {
                      final filteredItems = _filterFormCategoryTypes(item);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category Header
                          Text(
                            "${index + 1}. ${item.category.name}",
                            style: TextStyle(
                              color: clr.profileCardTextColor,
                              fontSize: size.textXSmall,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                            ),
                          ),
                          SizedBox(height: size.s8),
                          // Horizontal ListView for filtered items
                          Wrap(
                            children:
                                List.generate(filteredItems.length, (index2) {
                              var filteredItem = filteredItems[index2];
                              bool isSelected =
                                  selectedTypeId == filteredItem.type.id;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      selectedTypeId = 0;
                                      selectedCategoryId = 0;
                                    } else {
                                      selectedTypeId = filteredItem.type.id;
                                      selectedCategoryId = item.category.id;
                                    }
                                  });
                                  // print('_CommentCreateBottomSheetState.build$selectedTypeId');
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: size.s28, bottom: size.s8),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.s16, vertical: size.s12),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? widget.isGood
                                            ? clr.bgImprove
                                            : clr.bgGood
                                        : clr.greyBorder,
                                    border: Border.all(
                                        color: isSelected
                                            ? widget.isGood
                                                ? clr.improveText
                                                : clr.blueText
                                            : Colors.transparent,
                                        width: size.s1),
                                    borderRadius:
                                        BorderRadius.circular(size.s8),
                                  ),
                                  child: Text(
                                    filteredItem.type.name,
                                    style: TextStyle(
                                      color: clr.textColorBlack1,
                                      fontSize: size.textXXSmall,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          // AspectRatio(
                          //   aspectRatio: 8,
                          //   child: ListView.separated(
                          //     itemCount: filteredItems.length,
                          //     shrinkWrap: true,
                          //     scrollDirection: Axis.horizontal,
                          //     itemBuilder: (context, index2) {
                          //       var filteredItem = filteredItems[index2];
                          //       return Container(
                          //         padding: EdgeInsets.symmetric(
                          //             horizontal: size.s16, vertical: size.s12),
                          //         decoration: BoxDecoration(
                          //           color: clr.greyBorder,
                          //           borderRadius:
                          //               BorderRadius.circular(size.s8),
                          //         ),
                          //         child: Text(
                          //           filteredItem.type.name,
                          //           style: TextStyle(
                          //             color: clr.textColorBlack1,
                          //             fontSize: size.textXXSmall,
                          //             fontWeight: FontWeight.w500,
                          //             fontFamily: "Poppins",
                          //           ),
                          //         ),
                          //       );
                          //     },
                          //     separatorBuilder: (context, index) {
                          //       return SizedBox(width: size.s28);
                          //     },
                          //   ),
                          // ),
                        ],
                      );
                    },
                  ),
                  Divider(color: clr.hintTextColor, height: size.s1),
                  SizedBox(height: size.s8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.s16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              height: 44.w,
                              width: double.infinity,
                              padding: EdgeInsets.all(size.s4),
                              decoration: BoxDecoration(
                                color: clr.iconColorGrey,
                                borderRadius: BorderRadius.circular(size.s8),
                              ),
                              child: Center(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontSize: size.textXSmall,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: size.s16),
                        Expanded(
                          child: ActionButton(
                            buttonColor: clr.appPrimaryColor,
                            title: "Save",
                            radius: size.s8,
                            tapAction: () => doComment(
                              widget.feedbackId,
                              selectedCategoryId,
                              selectedTypeId,
                              widget.videoId,
                              "00:05:50",
                              "00:06:10",
                            ),
                            onCheck: () {
                              if (selectedTypeId == 0) {
                                Toasty.of(context)
                                    .showWarning("Please Select First");
                                return false;
                              } else {
                                return true;
                              }
                            },
                            onSuccess: (x) {
                              Navigator.pop(context, x);
                              if (mounted) {
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.s28),
                ],
              ),
            ),
          ),
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
    Toasty.of(context).showSuccess(message);
  }

  @override
  void showWarning(String message) {
    Toasty.of(context).showWarning(message);
  }

  @override
  void navigateToFeedbackScoreDetailsScreen(
      String videoId, String feedbackScoreId) {
    // TODO: implement navigateToFeedbackScoreDetailsScreen
  }

  @override
  void navigateToFeedbackScoreListScreen(String videoId) {
    // TODO: implement navigateToFeedbackScoreListScreen
  }

  @override
  void navigateToGiveFeedbackScoreScreen(
      String videoId, FeedbackEntity feedback) {
    // TODO: implement navigateToGiveFeedbackScoreScreen
  }
}

class BottomSheetCommentItemSectionWidget<T> extends StatelessWidget
    with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const BottomSheetCommentItemSectionWidget({
    super.key,
    required this.items,
    required this.buildItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
    );
  }
}
