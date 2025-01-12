import 'package:flutter/material.dart';

import '../../../common/constants/common_imports.dart';
import '../../../common/widgets/custom_toasty.dart';
import '../../bookmark/models/form_category_type.dart';

class GiveScoreCategoryWidget<T> extends StatefulWidget {
  final String categoryTitle;
  final int index;
  final List<FormCategoryType> items;
  // final int status;
  // final List<CourseOutlineContentEntity> items;
  // final Outline data;
  // final ValueChanged<int> onTapQuizItem, onTapScriptItem, onTapVideoItem;
  const GiveScoreCategoryWidget({
    super.key,
    required this.categoryTitle,
    required this.index,
    required this.items,
    // required this.data,
    // required this.onTapQuizItem,
    // required this.onTapScriptItem,
    // required this.onTapVideoItem,
  });

  @override
  State<GiveScoreCategoryWidget<T>> createState() => _GiveScoreCategoryWidgetState<T>();
}

class _GiveScoreCategoryWidgetState<T> extends State<GiveScoreCategoryWidget<T>>
    with AppTheme {
  bool _isExpanded = false;

  _toggle() {
    if (mounted) {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.s12, vertical: size.s12),
      decoration: BoxDecoration(
        color: clr.whiteColor,
        borderRadius: BorderRadius.circular(size.s8),
        border: Border.all(
            color: _isExpanded
                ? clr.scoreExpandedCardColor
                : clr.scoreDetailsCardColor,
            width: size.s1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              // if (widget.items.isNotEmpty) {
              _toggle();
              // } else {
              //   showWarning("No items found!");
              // }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "${widget.index}. ${widget.categoryTitle}",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: size.textXSmall,
                        color: clr.toggleIconColorColor),
                  ),
                ),
                SizedBox(width: size.s8),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: clr.toggleIconColorColor,
                  size: size.s20,
                ),
              ],
            ),
          ),
          if (_isExpanded)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.s12),
                  child: Divider(
                      color: clr.scoreDetailsCardColor, height: size.s1),
                ),
                ListView.separated(
                  itemCount: widget.items.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final item = widget.items[index];
                    return Container(
                      padding: EdgeInsets.all(size.s8),
                      decoration: BoxDecoration(
                        color: clr.scoreExpandedCardItemColor,
                        borderRadius: BorderRadius.circular(size.s8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            item.type.name,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: size.textXSmall,
                                color: clr.scoreExpandedCardTextColor),
                          ),
                          SizedBox(height: size.s12),
                          Divider(
                              color: clr.scoreDetailsCardColor,
                              height: size.s1),
                          SizedBox(height: size.s12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  padding:
                                      EdgeInsets.symmetric(vertical: size.s8),
                                  decoration: BoxDecoration(
                                      color: clr.whiteColor,
                                      borderRadius:
                                          BorderRadius.circular(size.s4),
                                      border: Border.all(
                                          color: clr.scoreDetailsCardColor,
                                          width: size.s1)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.circle_outlined,
                                        size: size.s16,
                                        color: clr.toggleIconColorColor,
                                      ),
                                      SizedBox(width: size.s4),
                                      Text(
                                        "(2 Points)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: size.textXXSmall,
                                            color: clr.toggleIconColorColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: size.s8),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  padding:
                                      EdgeInsets.symmetric(vertical: size.s8),
                                  decoration: BoxDecoration(
                                      color: clr.whiteColor,
                                      borderRadius:
                                          BorderRadius.circular(size.s4),
                                      border: Border.all(
                                          color: clr.scoreDetailsCardColor,
                                          width: size.s1)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.change_history,
                                        size: size.s16,
                                        color: clr.toggleIconColorColor,
                                      ),
                                      SizedBox(width: size.s4),
                                      Text(
                                        "(1 Points)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: size.textXXSmall,
                                            color: clr.toggleIconColorColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: size.s8),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  padding:
                                      EdgeInsets.symmetric(vertical: size.s8),
                                  decoration: BoxDecoration(
                                      color: clr.whiteColor,
                                      borderRadius:
                                          BorderRadius.circular(size.s4),
                                      border: Border.all(
                                          color: clr.scoreDetailsCardColor,
                                          width: size.s1)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.close,
                                        size: size.s16,
                                        color: clr.toggleIconColorColor,
                                      ),
                                      SizedBox(width: size.s4),
                                      Text(
                                        "(0 Points)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: size.textXXSmall,
                                            color: clr.toggleIconColorColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: size.s16);
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }

  void showWarning(String message) {
    Toasty.of(context).showWarning(message);
  }
}
