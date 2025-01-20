import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/constants/common_imports.dart';
import '../../../common/routes/app_route.dart';
import '../../../common/routes/app_route_args.dart';
import '../../../common/widgets/app_stream.dart';
import '../../../common/widgets/circular_loader.dart';
import '../services/category_wise_video_list_screen_service.dart';
import '../../../common/widgets/app_scaffold.dart';
import '../../../common/widgets/paginated_list_view.dart';
import '../models/category_entity.dart';

class CategoryWiseVideoListScreen extends StatefulWidget {
  final Object? arguments;
  const CategoryWiseVideoListScreen({super.key, this.arguments})
      : assert(
            arguments != null && arguments is CategoryWiseVideoListScreenArgs);
  @override
  State<CategoryWiseVideoListScreen> createState() =>
      _CategoryWiseVideoListScreenState();
}

class _CategoryWiseVideoListScreenState
    extends State<CategoryWiseVideoListScreen>
    with AppTheme, CategoryWiseVideoListScreenService, Language {
  @override
  void initState() {
    screenArgs = widget.arguments as CategoryWiseVideoListScreenArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadInitialData(screenArgs.categoryId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: screenArgs.categoryName,
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
              color: clr.whiteColor,
              border: Border(
                  top: BorderSide(
                color: clr.backgroundColor1,
                width: 8.w,
              ))),
          child: AppStreamBuilder<PaginatedListViewController<CategoryEntity>>(
            stream: videoListStreamController.stream,
            loadingBuilder: (context) {
              return const Center(
                child: CircularLoader(),
              );
            },
            dataBuilder: (context, data) {
              return PaginatedListView<CategoryEntity>(
                controller: paginationController,
                padding: EdgeInsets.symmetric(
                    vertical: size.s8, horizontal: size.s12),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, item, index) {
                  return CategoryWiseVideoItemWidget(
                    key: ObjectKey(item.id),
                    onTap: () => Navigator.of(context).pushNamed(
                        AppRoute.videoDetailsScreen,
                        arguments: VideoDetailsScreenArgs(videoId: item.id)),
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

class CategoryWiseVideoItemWidget extends StatelessWidget with AppTheme {
  final CategoryEntity data;
  final VoidCallback onTap;
  const CategoryWiseVideoItemWidget(
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
                  imageUrl: data.thumbnailUrl,
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
                  data.title,
                  style: TextStyle(
                    color: clr.videoTitleColor,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: size.s8),
                Text(
                  data.chapters.isNotEmpty
                      ? data.chapters.map((chapter) => chapter.title).join(', ')
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
