import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/constants/app_theme.dart';
import '../../../common/widgets/app_stream.dart';
import '../../../common/widgets/circular_loader.dart';
import '../../../common/widgets/empty_widget.dart';
import '../../../common/widgets/paginated_list_view.dart';
import '../../../common/widgets/search_box_widget.dart';
import '../widgets/course_search_scaffold.dart';
import '../services/search_screen_service.dart';
import '../../video/models/video_entity.dart';


class VideoSearchScreen extends StatefulWidget {
  const VideoSearchScreen({super.key});

  @override
  State<VideoSearchScreen> createState() => _VideoSearchScreenState();
}

class _VideoSearchScreenState extends State<VideoSearchScreen>
    with VideoSearchScreenService, AppTheme {
  @override
  Widget build(BuildContext context) {
    return SearchAppBarScaffold(
        title: "",
        searchChild: Row(
          children: [
            Expanded(
              child: SearchBoxWidget(
                hintText: "Search..",
                onSearchTermChange: onSearchTermChanged,
                serviceState: serviceState,
              ),
            ),
          /*  CategoryFilterMenu(
              serviceState: serviceState,
              onLoadData: onLoadCategoryList,
              onCategorySelected: onCategorySelected,
            ),*/
          ],
        ),
        child: Column(
          children: [

            Expanded(
              child: Container(
                color: clr.whiteColor,
                child:
                AppStreamBuilder<PaginatedListViewController<VideoEntity>>(
                  stream: videoDataStreamController.stream,
                  loadingBuilder: (context) {
                    return const Center(
                      child: CircularLoader(),
                    );
                  },
                  dataBuilder: (context, data) {
                    return PaginatedListView<VideoEntity>(
                      controller: paginationController,
                      padding:  EdgeInsets.symmetric(vertical: 0.0,horizontal: size.s16),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, item, index) {
                        return  SearchVideoItemWidget(data: item, onTap: (){});
                      },
                      separatorBuilder: (context) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: size.s16,vertical: size.s12),
                          height: 1.w,
                          width: double.infinity,
                          color: clr.greyColor.withOpacity(.3),
                        );
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
                    return EmptyWidget(
                      message: message,
                      icon: icon,
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }

  @override
  void showWarning(String message) {
    // TODO: implement showWarning
  }

}
class SearchVideoItemWidget extends StatelessWidget with AppTheme {
  final VideoEntity data;
  final VoidCallback onTap;
  const SearchVideoItemWidget({super.key, required this.data, required this.onTap});

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
                  imageUrl:
                  data.thumbnailUrl,
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
