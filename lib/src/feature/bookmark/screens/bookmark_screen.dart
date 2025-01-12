import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../common/widgets/paginated_list_view.dart';
import '../../../common/constants/common_imports.dart';
import '../../../common/widgets/app_stream.dart';
import '../../../common/widgets/circular_loader.dart';
import '../../../common/widgets/empty_widget.dart';
import '../../category_list/screens/category_wise_video_list.dart';
import '../services/bookmark_screen_service.dart';
import '../../../common/utility/app_label.dart';
import '../models/bookmark_entity.dart';

class BookmarkListScreen extends StatefulWidget {
  const BookmarkListScreen({super.key});

  @override
  State<BookmarkListScreen> createState() => _BookmarkListScreenState();
}

class _BookmarkListScreenState extends State<BookmarkListScreen>
    with AppTheme, BookmarkListScreenService, Language {
  @override
  void initState() {
    ///Load initial data
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadInitialData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: clr.scaffoldBackgroundColor2,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            label(e: "My Bookmarked videos", b: "វីដេអូដែលបានចំណាំរបស់ខ្ញុំ"),
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: size.textSmall,
                color: clr.textGrayColor),
          ),
        ),
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
              color: clr.whiteColor,
              border: Border(
                  top: BorderSide(
                color: clr.backgroundColor1,
                width: 8.w,
              ))),
          child: AppStreamBuilder<PaginatedListViewController<BookmarkEntity>>(
            stream: bookmarkStreamController.stream,
            loadingBuilder: (context) {
              return const Center(
                child: CircularLoader(),
              );
            },
            dataBuilder: (context, data) {
              return PaginatedListView<BookmarkEntity>(
                controller: paginationController,
                padding: EdgeInsets.symmetric(
                    vertical: size.s8, horizontal: size.s12),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, item, index) {
                  return BookmarkVideoItemWidget(
                    key: ObjectKey(item.id),
                    onTap: () {},
                    data: item,
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
  void showWarning(String message) {
    // TODO: implement showWarning
  }
}

class BookmarkVideoItemWidget extends StatelessWidget with AppTheme {
  final BookmarkEntity data;
  final VoidCallback onTap;
  const BookmarkVideoItemWidget(
      {super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(size.s10),
                child: CachedNetworkImage(
                  height: size.s20 * 4,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: data.bookmarkedContent.thumbnailUrl,
                  placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator()), // Placeholder widget
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error), // Error widget
                )),
          ),
          SizedBox(width: size.s12),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.bookmarkedContent.title,
                  style: TextStyle(
                    color: clr.videoTitleColor,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: size.s8),
                Text(
                  data.bookmarkedContent.chapters.isNotEmpty
                      ? data.bookmarkedContent.chapters
                          .map((chapter) => chapter.title)
                          .join(', ')
                      : "No chapter",
                  style: TextStyle(
                    color: clr.textGrayColor,
                    fontSize: size.textXSmall,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyStateWidget extends StatelessWidget with AppTheme {
  final String message, icon;
  const EmptyStateWidget(
      {super.key, required this.message, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
            child: SvgPicture.asset(
          icon,
          height: 200,
        )),
        size.s16.kHeight,
        Center(
          child: Text(
            message,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: size.textSmall,
                color: clr.blackColor),
          ),
        ),
        size.s20.kHeight,
      ],
    );
  }
}

/*class CourseSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const CourseSectionWidget(
      {super.key, required this.items, required this.buildItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          itemCount: items.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return buildItem(context, index, items[index]);
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: clr.greyColor,
            );
          },
        ),
      ],
    );
  }
}

class CourseItemWidget extends StatelessWidget with AppTheme {
  final CourseEntity data;
  final void Function(CourseEntity course) onSelect;
  const CourseItemWidget(
      {super.key, required this.onSelect, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(data),
      child: AspectRatio(
        aspectRatio: 3.1,
        child: Container(
            decoration: BoxDecoration(
              color: clr.whiteColor,
            ),
            child: Row(
              children: [
                Expanded(
                    flex: 60,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: size.s10,
                          top: size.s10,
                          bottom: size.s10,
                          right: size.s4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.title,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: size.textSmall,
                                color: clr.textGreyDark),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: size.s4,
                          ),
                          Text(
                              data.mentors.isNotEmpty
                                  ? "${data.mentors[0].name}  +${data.mentors.length - 1}"
                                  : "",
                              maxLines: 1,
                              style: TextStyle(
                                color: clr.blackText,
                                fontSize: size.textXSmall,
                                fontWeight: FontWeight.w500,
                              )),
                          SizedBox(
                            height: size.s4,
                          ),
                          data.salePrice < data.regularPrice
                              ? Text(
                              "৳${data.salePrice.toString()} ৳${data.regularPrice.toString()}",
                              maxLines: 1,
                              style: TextStyle(
                                color: clr.blackText,
                                fontSize: size.textXSmall,
                                fontWeight: FontWeight.w500,
                              ))
                              : Text("৳${data.salePrice.toString()}",
                              maxLines: 1,
                              style: TextStyle(
                                color: clr.blackText,
                                fontSize: size.textXSmall,
                                fontWeight: FontWeight.w500,
                              ))
                        ],
                      ),
                    )),
                Expanded(
                    flex: 40,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: size.s10, top: size.s10, bottom: size.s10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(size.s8),
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl:
                            // "https://api.edupackbd.com/uploads/thumbnail/bb_1728289023.png",
                            AppConstant.getCourseThumbnailUrl(
                                data.thumbnail),
                            fit: BoxFit.fill,
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.image),
                          ),
                        ),
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}*/
