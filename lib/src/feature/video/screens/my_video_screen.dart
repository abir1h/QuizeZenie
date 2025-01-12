import 'package:cached_network_image/cached_network_image.dart';
import 'package:co_learning_mobile_app/src/common/widgets/custom_toasty.dart';
import 'package:co_learning_mobile_app/src/feature/video/models/video_entity.dart';
import 'package:co_learning_mobile_app/src/feature/video/widgets/video_tab_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/constants/app_theme.dart';
import '../../../common/constants/common_imports.dart';
import '../../../common/widgets/app_scaffold.dart';
import '../../../common/widgets/app_stream.dart';
import '../../../common/widgets/circular_loader.dart';
import '../../../common/widgets/paginated_list_view.dart';
import '../../bookmark/models/bookmark_entity.dart';
import '../../bookmark/screens/bookmark_screen.dart';
import '../../profile/widgets/select_laguage_bottomshet.dart';
import '../services/my_video_screen_service.dart';
import '../widgets/more_bottomsheet.dart';

class MyVideoScreen extends StatefulWidget {
  const MyVideoScreen({super.key});

  @override
  State<MyVideoScreen> createState() => _MyVideoScreenState();
}

class _MyVideoScreenState extends State<MyVideoScreen>
    with AppTheme, MyVideoListScreenService {
  final GlobalKey _bodyKey = GlobalKey();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadInitialData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "My Video List",
      child: LayoutBuilder(builder: (context, constraints) {
        return VideoSectionTabWidget(
          key: _bodyKey,
          onTabChange: (v) {},
          builder: (context, index) {
            switch (index) {
              ///All
              case 0:
                return videoList((item) => true);
              case 1:
                return videoList((item) => !item.isPublished);
              case 2:
                return videoList((item) => item.isPublished);

              ///Loading state
              default:
                return SectionLoadingWidget(constraints: constraints);
            }
          },
        );
      }),
    );
  }

  @override
  void showWarning(String message) {
    Toasty.of(context).showWarning(message);
  }

  Widget videoList(bool Function(VideoEntity) filterCondition) {
    return Expanded(
      child: AppStreamBuilder<PaginatedListViewController<VideoEntity>>(
        stream: videoStreamController.stream,
        loadingBuilder: (context) => const Center(child: CircularLoader()),
        dataBuilder: (context, data) {
          return PaginatedListView<VideoEntity>(
            controller: paginationController,
            padding:
                EdgeInsets.symmetric(vertical: size.s16, horizontal: size.s12),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, item, index) {
              return filterCondition(item)
                  ? VideoItemWidget(data: item)
                  : Offstage();
            },
            separatorBuilder: (context) => SizedBox(height: size.s12),
            loaderBuilder: (context) => Padding(
              padding: EdgeInsets.all(size.s4),
              child: const Center(child: CircularLoader()),
            ),
          );
        },
        emptyBuilder: (context, message, icon) {
          return EmptyStateWidget(
            message: message,
            icon: ImageAssets.videoIcon,
          );
        },
      ),
    );
  }
}

/*VideoItemSectionWidget(
items: const ["", "", "", ""],
buildItem: (BuildContext context, int index, item) => VideoItemWidget(),
),*/
class SectionLoadingWidget extends StatelessWidget with AppTheme {
  final BoxConstraints constraints;
  final double? offset;
  const SectionLoadingWidget(
      {super.key, required this.constraints, this.offset});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: constraints.maxHeight - (offset ?? 242.w),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.s20),
        child: const Center(
          child: CircularLoader(),
        ),
      ),
    );
  }
}

class VideoItemSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const VideoItemSectionWidget({
    super.key,
    required this.items,
    required this.buildItem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: size.s12),
      child: ListView.separated(
        itemCount: items.length,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: size.s16),
        itemBuilder: (context, index) {
          return buildItem(context, index, items[index]);
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: size.s12);
        },
      ),
    );
  }
}

class VideoItemWidget extends StatelessWidget with AppTheme {
  final VideoEntity data;
  const VideoItemWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
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
        GestureDetector(onTap: (){
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return MoreBottomSheet(
                context: context,
              );
            },
          );
        },
          child: Icon(
            Icons.more_vert,
            size: size.s20,
            color: clr.videoTitleColor,
          ),
        )
      ],
    );
  }
}
