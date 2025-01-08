import 'package:flutter/material.dart';

import '../../../common/constants/app_theme.dart';
import '../models/comment_entity.dart';
import '../screens/video_details_screen.dart';

class CommentsBottomSheet extends StatefulWidget {
  final List<CommentEntity> commentEntity;
  const CommentsBottomSheet({super.key, required this.commentEntity});

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet>
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.s16, vertical: size.s16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "User Feedbacks",
                          style: TextStyle(
                              color: clr.textColorBlack1,
                              fontSize: size.textSmall,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins"),
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Icon(
                            Icons.close,
                            size: size.s24,
                            color: clr.textColorBlack,
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: size.s1,
                    color: clr.iconGrey,
                  ),
                  SizedBox(height: size.s16),
                  BottomSheetCommentItemSectionWidget(
                      items: widget.commentEntity,
                      buildItem: (BuildContext context, int index, item) =>
                          CommentItemWidget(data: item)),
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
      itemCount: items.length,
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
