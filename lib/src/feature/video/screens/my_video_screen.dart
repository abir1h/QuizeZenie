import 'package:cached_network_image/cached_network_image.dart';
import 'package:co_learning_mobile_app/src/feature/video/widgets/video_tab_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/constants/app_theme.dart';
import '../../../common/widgets/app_scaffold.dart';
import '../../../common/widgets/circular_loader.dart';

class MyVideoScreen extends StatefulWidget {
  const MyVideoScreen({super.key});

  @override
  State<MyVideoScreen> createState() => _MyVideoScreenState();
}

class _MyVideoScreenState extends State<MyVideoScreen> with AppTheme {
  final GlobalKey _bodyKey = GlobalKey();

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
              ///Instruction
              case 0:
                return Expanded(
                  child: VideoItemSectionWidget(
                    items: const ["", "", "", ""],
                    buildItem: (BuildContext context, int index, item) =>
                        VideoItemWidget(),
                  ),
                );

              ///StudentWork
              case 1:
                 return Expanded(
                   child: VideoItemSectionWidget(
                    items: const ["", "", "", ""],
                    buildItem: (BuildContext context, int index, item) =>
                        VideoItemWidget(),
                                   ),
                 );
              case 2:
                return Expanded(
                  child: VideoItemSectionWidget(
                    items: const ["", "", "", ""],
                    buildItem: (BuildContext context, int index, item) =>
                        VideoItemWidget(),
                  ),
                );

              ///Loading state
              default:
                return SectionLoadingWidget(constraints: constraints);
            }
          },
        );
      }),
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
      padding:  EdgeInsets.only(top: size.s12),
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
  const VideoItemWidget({super.key});

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
                imageUrl:
                    "https://plus.unsplash.com/premium_photo-1676478746990-4ef5c8ef234a?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Zmxvd2VyfGVufDB8fDB8fHww",
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
                "Video Name  ",
                style: TextStyle(
                  color: clr.videoTitleColor,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: size.s8),
              Text(
                "Chapter name",
                style: TextStyle(
                  color: clr.textGrayColor,
                  fontSize: size.textXSmall,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.more_vert,
          size: size.s20,
          color: clr.videoTitleColor,
        )
      ],
    );
  }
}
