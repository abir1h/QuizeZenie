import 'package:flutter/material.dart';

import '../../../common/constants/app_theme.dart';
import '../../bookmark/models/form_category.dart';
import '../models/comment_entity.dart';
import '../screens/video_details_screen.dart';

class CommentCreateBottomSheet extends StatefulWidget {
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
                                  itemCount: item.formCategoryTypes.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index2) {
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
                                        item.formCategoryTypes[index2].type
                                            .name,
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
