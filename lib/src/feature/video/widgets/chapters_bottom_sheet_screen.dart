import 'package:cached_network_image/cached_network_image.dart';
import 'package:co_learning_mobile_app/src/feature/bookmark/models/chapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/constants/app_theme.dart';
import '../../../common/constants/common_imports.dart';
import '../../../common/widgets/app_scroll_view.dart';

class ChaptersBottomSheet extends StatefulWidget {
  final List<ChapterEntity> chapterList;
  final ValueChanged<ChapterEntity> onSelectChapter;
  const ChaptersBottomSheet({
    super.key,
    required this.chapterList,
    required this.onSelectChapter,
  });

  @override
  _ExamInstructionBottomSheetState createState() =>
      _ExamInstructionBottomSheetState();
}

class _ExamInstructionBottomSheetState extends State<ChaptersBottomSheet>
    with AppTheme {
  @override
  Widget build(BuildContext context) {
    return AppScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ViewChapterItemSectionWidget<ChapterEntity>(
            items: widget.chapterList,
            buildItem: (context, index, item) {
              return GestureDetector(
                onTap: () {
                  widget.onSelectChapter.call(item);
                },
                child: ViewChapterItemWidget(
                  key: ObjectKey(item),
                  // onTapEdit: () {
                  //
                  //   showCupertinoModalPopup(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return CreateChapterBottomSheet(
                  //         videoId: videoId,
                  //         totalDuration: totalVideoDuration!,
                  //         userPosition: userPlayedPosition!,
                  //         title: item.title,
                  //         chapterTime:  Duration(seconds:  item.startTimeSeconds.round()),
                  //         chapterId: item.id,
                  //
                  //         chapterList: (value) {
                  //           onLoadChapterList(value);
                  //         },
                  //       );
                  //     },
                  //   );
                  // },
                  data: item, onTap: () {},
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ViewChapterItemSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const ViewChapterItemSectionWidget({
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

class ViewChapterItemWidget extends StatelessWidget with AppTheme {
  final ChapterEntity data;
  final VoidCallback onTap;
  final ChapterEntity? selectedChapter;
  const ViewChapterItemWidget(
      {super.key, required this.data, required this.onTap, this.selectedChapter});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.s16, vertical: size.s12),
        decoration: BoxDecoration(
          color: selectedChapter?.id!=data.id?clr.whiteColor:clr.grayColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(size.s8),
          // border: Border.all(color: clr.borderGray, width: size.s1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(size.s8), // Rounded image
                    child: AspectRatio(
                      aspectRatio: 120 / 72,
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(color: const Color(0xff51A4FF),width: 2.w)),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,

                          imageUrl: data.thumbnailUrl,
                          // placeholder: (context, url) =>
                          //     const CircularProgressIndicator(), // Placeholder widget
                          errorWidget: (context, url, error) => Image.network(
                            "https://archive.org/download/placeholder-image/placeholder-image.jpg",
                            height: 60.h,
                            width: 60.w,
                            fit: BoxFit.cover,
                            color: clr.borderGray,
                          ), // Error widget
                        ),
                      ),
                    ),
                  ),
                ),
                size.s12.kWidth,
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: size.textXSmall,
                          color: clr.textColorGrey2,
                        ),
                      ),
                      size.s20.kHeight,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.s2, vertical: size.s2),
                            decoration: BoxDecoration(
                              color: clr.scoreExpandedCardItemColor,
                              borderRadius: BorderRadius.circular(size.s4),
                            ),
                            child: Text(
                              formatDuration(data.startTimeSeconds),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: size.textXXSmall,
                                color: clr.blackColor,
                              ),
                            ),
                          ),
                          Expanded(child: size.s8.kWidth),
                        ],
                      )
                    ],
                  ),
                ),
                size.s12.kWidth,
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatDuration(int totalSeconds) {
    Duration duration = Duration(seconds: totalSeconds);

    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }
  }
}
