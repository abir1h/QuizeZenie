import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../common/constants/common_imports.dart';
import '../../../common/utility/app_label.dart';
import '../../../common/widgets/app_stream.dart';
import '../../../common/widgets/circular_loader.dart';
import '../../../common/widgets/custom_toasty.dart';
import '../models/home_entity.dart';
import '../services/home_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AppTheme, HomeService {
  final CarouselSliderController carouselController =
      CarouselSliderController();
  // final PageController _pageController = PageController();
  int currentIndex = 0;

  final List<String> imgList = [
    'https://via.placeholder.com/600x300.png?text=Image+1',
    'https://via.placeholder.com/600x300.png?text=Image+2',
    'https://via.placeholder.com/600x300.png?text=Image+3',
    'https://via.placeholder.com/600x300.png?text=Image+4',
  ];

  double expandedHeight = 1.sw * 1.05;
  // double collapsedHeight = 1.sw * .2;
  bool isContentVisible = true;

  void onScroll(double scrollPosition, double appBarHeight) {
    if (scrollPosition != 0) {
      setState(() {
        isContentVisible = false;
      });
    } else {
      setState(() {
        isContentVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<HomeEntity>(
      stream: homeStreamController.stream,
      loadingBuilder: (context) {
        return const Center(
          child: CircularLoader(),
        );
      },
      dataBuilder: (context, data) {
        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification) {
              if (scrollNotification.metrics.axis == Axis.vertical) {
                double scrollPosition = scrollNotification.metrics.pixels;
                double appBarHeight = expandedHeight;
                onScroll(scrollPosition, appBarHeight);
              }
            }
            return false;
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: MediaQuery.of(context).size.height * .52,
                collapsedHeight: MediaQuery.of(context).size.height * .15,
                floating: false,
                pinned: true,
                backgroundColor: clr.backgroundColor,
                title: Padding(
                  padding: EdgeInsets.only(top: size.s8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label(e: "Welcome to", b: "Welcome to"),
                        style: TextStyle(
                            color: clr.whiteColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: StringData.fontFamilyPoppins,
                            fontSize: size.textXXSmall),
                      ),
                      Text(
                        label(e: "e Learning Project", b: "e Learning Project"),
                        style: TextStyle(
                            color: clr.whiteColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: StringData.fontFamilyPoppins,
                            fontSize: size.textSmall),
                      ),
                    ],
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(top: size.s8, right: size.s8),
                    child: InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.notifications_outlined,
                        size: size.s32,
                        color: clr.whiteColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: size.s8, right: size.s20),
                    decoration: BoxDecoration(
                      color: clr.iconGrey,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          color: clr.iconBorderColor, width: size.s2),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          height: size.s32,
                          width: size.s32,
                          fit: BoxFit.fill,
                          imageUrl:
                              "https://images.unsplash.com/photo-1532264523420-881a47db012d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9",
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )),
                  )
                ],
                flexibleSpace: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(size.s20),
                          bottomRight: Radius.circular(size.s20)),
                      child: Image.asset(
                        ImageAssets.imgHomeBG,
                        height: MediaQuery.of(context).size.height * .5,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top +
                                kToolbarHeight +
                                size.s10,
                            right: size.s16,
                            left: size.s16),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: size.s20 * 2,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.s12, vertical: size.s12),
                                decoration: BoxDecoration(
                                    color: clr.bgColorWhite,
                                    borderRadius:
                                        BorderRadius.circular(size.s8),
                                    border: Border.all(
                                        color: clr.cardStrokeColor,
                                        width: size.s1)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.search,
                                      size: size.s16,
                                      color: clr.iconColorGrey,
                                    ),
                                    SizedBox(width: size.s8),
                                    Expanded(
                                      child: Text(
                                        "Search Here",
                                        style: TextStyle(
                                          color: clr.textColorGrey,
                                          fontSize: size.textXXSmall,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.pages,
                                      size: size.s16,
                                      color: clr.iconColorGrey,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: size.s16),
                              AnimatedOpacity(
                                opacity: isContentVisible ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 250),
                                child: ImageSliderWidget(
                                  imgList: imgList,
                                  initialIndex: 0,
                                ),
                              ),
                              SizedBox(height: size.s16),
                              AnimatedOpacity(
                                opacity: isContentVisible ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 250),
                                child: Container(
                                  width: double.infinity,
                                  // height: 80,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.s20, vertical: size.s16),
                                  decoration: BoxDecoration(
                                    color: clr.whiteColor,
                                    borderRadius:
                                        BorderRadius.circular(size.s20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        spreadRadius: 5,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconWithTitleWidget(
                                        svgIcon: ImageAssets.icReel,
                                        text: "${data.totalVideos} Videos",
                                      ),
                                      IconWithTitleWidget(
                                        svgIcon: ImageAssets.icBook,
                                        text: "${data.totalChapters} Chapters",
                                      ),
                                      IconWithTitleWidget(
                                        svgIcon: ImageAssets.icBank,
                                        text: "${data.totalSchools} Schools",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: size.s20),
                    ListView.separated(
                      itemCount: data.categories.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ItemSectionWidget(
                          title: data.categories[index].name,
                          items: data.categories[index].videos,
                          buildItem: (BuildContext context, int index, item) =>
                              FeaturedItemWidget(
                            data: item,
                            onTap: () {},
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return size.s20.kHeight;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      emptyBuilder: (context, message, icon) {
        return const Offstage();
      },
    );
    // return NotificationListener<ScrollNotification>(
    //   onNotification: (scrollNotification) {
    //     if (scrollNotification is ScrollUpdateNotification) {
    //       if (scrollNotification.metrics.axis == Axis.vertical) {
    //         double scrollPosition = scrollNotification.metrics.pixels;
    //         double appBarHeight = expandedHeight;
    //         onScroll(scrollPosition, appBarHeight);
    //       }
    //     }
    //     return false;
    //   },
    //   child: CustomScrollView(
    //     slivers: [
    //       SliverAppBar(
    //         automaticallyImplyLeading: false,
    //         expandedHeight: expandedHeight,
    //         collapsedHeight: collapsedHeight,
    //         floating: false,
    //         pinned: true,
    //         backgroundColor: clr.backgroundColor,
    //         title: Padding(
    //           padding: EdgeInsets.only(top: size.s8),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 label(e: "Welcome to", b: "Welcome to"),
    //                 style: TextStyle(
    //                     color: clr.whiteColor,
    //                     fontWeight: FontWeight.w500,
    //                     fontFamily: StringData.fontFamilyPoppins,
    //                     fontSize: size.textXXSmall),
    //               ),
    //               Text(
    //                 label(e: "e Learning Project", b: "e Learning Project"),
    //                 style: TextStyle(
    //                     color: clr.whiteColor,
    //                     fontWeight: FontWeight.w600,
    //                     fontFamily: StringData.fontFamilyPoppins,
    //                     fontSize: size.textSmall),
    //               ),
    //             ],
    //           ),
    //         ),
    //         actions: [
    //           Padding(
    //             padding: EdgeInsets.only(top: size.s8, right: size.s8),
    //             child: InkWell(
    //               onTap: () {},
    //               child: Icon(
    //                 Icons.notifications_outlined,
    //                 size: size.s32,
    //                 color: clr.whiteColor,
    //               ),
    //             ),
    //           ),
    //           Container(
    //             margin: EdgeInsets.only(top: size.s8, right: size.s20),
    //             decoration: BoxDecoration(
    //               color: clr.iconGrey,
    //               borderRadius: BorderRadius.circular(100),
    //               border:
    //                   Border.all(color: clr.iconBorderColor, width: size.s2),
    //             ),
    //             child: ClipRRect(
    //                 borderRadius: BorderRadius.circular(100),
    //                 child: CachedNetworkImage(
    //                   height: size.s32,
    //                   width: size.s32,
    //                   fit: BoxFit.fill,
    //                   imageUrl:
    //                       "https://images.unsplash.com/photo-1532264523420-881a47db012d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9",
    //                   placeholder: (context, url) =>
    //                       const Center(child: CircularProgressIndicator()),
    //                   errorWidget: (context, url, error) =>
    //                       const Icon(Icons.error),
    //                 )),
    //           )
    //         ],
    //         flexibleSpace: Stack(
    //           children: [
    //             ClipRRect(
    //               borderRadius: BorderRadius.only(
    //                   bottomLeft: Radius.circular(size.s20),
    //                   bottomRight: Radius.circular(size.s20)),
    //               child: Image.asset(
    //                 ImageAssets.imgHomeBG,
    //                 // height: 1.sw,
    //                 width: double.infinity,
    //                 fit: BoxFit.fill,
    //               ),
    //             ),
    //             Align(
    //               alignment: Alignment.topCenter,
    //               child: Padding(
    //                 padding: EdgeInsets.only(
    //                     top: MediaQuery.of(context).padding.top +
    //                         kToolbarHeight,
    //                     right: size.s16,
    //                     left: size.s16),
    //                 child: SingleChildScrollView(
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       Container(
    //                         height: size.s20 * 2,
    //                         width: double.infinity,
    //                         padding: EdgeInsets.symmetric(
    //                             horizontal: size.s12, vertical: size.s12),
    //                         decoration: BoxDecoration(
    //                             color: clr.bgColorWhite,
    //                             borderRadius: BorderRadius.circular(size.s8),
    //                             border: Border.all(
    //                                 color: clr.cardStrokeColor,
    //                                 width: size.s1)),
    //                         child: Row(
    //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                           mainAxisSize: MainAxisSize.max,
    //                           children: [
    //                             Icon(
    //                               Icons.search,
    //                               size: size.s16,
    //                               color: clr.iconColorGrey,
    //                             ),
    //                             SizedBox(width: size.s8),
    //                             Expanded(
    //                               child: Text(
    //                                 "Search Here",
    //                                 style: TextStyle(
    //                                   color: clr.textColorGrey,
    //                                   fontSize: size.textXXSmall,
    //                                   fontWeight: FontWeight.w500,
    //                                 ),
    //                               ),
    //                             ),
    //                             Icon(
    //                               Icons.pages,
    //                               size: size.s16,
    //                               color: clr.iconColorGrey,
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                       SizedBox(height: size.s16),
    //                       AnimatedOpacity(
    //                         opacity: isContentVisible ? 1.0 : 0.0,
    //                         duration: const Duration(milliseconds: 250),
    //                         child: ImageSliderWidget(
    //                           imgList: imgList,
    //                           initialIndex: 0,
    //                         ),
    //                       ),
    //                       SizedBox(height: size.s16),
    //                       AnimatedOpacity(
    //                         opacity: isContentVisible ? 1.0 : 0.0,
    //                         duration: const Duration(milliseconds: 250),
    //                         child: Container(
    //                           width: double.infinity,
    //                           // height: 80,
    //                           padding: EdgeInsets.symmetric(
    //                               horizontal: size.s20, vertical: size.s16),
    //                           decoration: BoxDecoration(
    //                             color: clr.whiteColor,
    //                             borderRadius: BorderRadius.circular(size.s20),
    //                             boxShadow: [
    //                               BoxShadow(
    //                                 color: Colors.black.withOpacity(0.1),
    //                                 blurRadius: 10,
    //                                 spreadRadius: 5,
    //                                 offset: const Offset(0, 5),
    //                               ),
    //                             ],
    //                           ),
    //                           child: Row(
    //                             mainAxisAlignment:
    //                                 MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               IconWithTitleWidget(
    //                                 svgIcon: ImageAssets.icReel,
    //                                 text: "500+ Videos",
    //                               ),
    //                               IconWithTitleWidget(
    //                                 svgIcon: ImageAssets.icBook,
    //                                 text: "200+ Chapters",
    //                               ),
    //                               IconWithTitleWidget(
    //                                 svgIcon: ImageAssets.icBank,
    //                                 text: "7 Schools",
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       SliverList(
    //         delegate: SliverChildListDelegate(
    //           [
    //             SizedBox(height: size.s8),
    //             ItemSectionWidget(
    //               title: "School name",
    //               items: const ["", "", "", "", "", ""],
    //               buildItem: (BuildContext context, int index, item) =>
    //                   FeaturedItemWidget(
    //                 onTap: () {},
    //               ),
    //             ),
    //             SizedBox(height: size.s20),
    //             ItemSectionWidget(
    //               title: "School name",
    //               items: const ["", "", "", "", "", ""],
    //               buildItem: (BuildContext context, int index, item) =>
    //                   FeaturedItemWidget(
    //                 onTap: () {},
    //               ),
    //             ),
    //             SizedBox(height: size.s20),
    //             ItemSectionWidget(
    //               title: "School name",
    //               items: const ["", "", "", "", "", ""],
    //               buildItem: (BuildContext context, int index, item) =>
    //                   FeaturedItemWidget(
    //                 onTap: () {},
    //               ),
    //             ),
    //             SizedBox(height: size.s20),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  @override
  void navigateToTaskDetailsScreen(int taskId) {
    // TODO: implement navigateToTaskDetailsScreen
  }

  @override
  void showSuccess(String message) {
    Toasty.of(context).showSuccess(message);
  }

  @override
  void showWarning(String message) {
    Toasty.of(context).showWarning(message);
  }
}

class ImageSliderWidget extends StatefulWidget {
  final List<String> imgList;
  final int initialIndex;

  const ImageSliderWidget(
      {super.key, required this.imgList, required this.initialIndex});

  @override
  State<ImageSliderWidget> createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> with AppTheme {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CarouselSlider.builder(
          itemCount: widget.imgList.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return ClipRRect(
              borderRadius:
                  BorderRadius.circular(8.0),
              child: Container(color: Colors.cyan,),
              // You can customize this size
              // child: CachedNetworkImage(
              //   height: double.infinity,
              //   width: double.infinity,
              //   fit: BoxFit.fill,
              //   imageUrl: widget.imgList[index],
              //   placeholder: (context, url) =>
              //       const Center(child: CircularProgressIndicator()),
              //   errorWidget: (context, url, error) =>
              //       const Icon(Icons.error_outline),
              // ),
            );
          },
          options: CarouselOptions(
            aspectRatio: 2,
            autoPlay: true,
            viewportFraction: 1.0,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        Positioned(
          bottom: size.s12,
          child: SmoothPageIndicator(
            controller: PageController(initialPage: currentIndex),
            count: widget.imgList.length,
            effect: WormEffect(
              dotWidth: 10.0,
              dotHeight: 10.0,
              radius: 5.0,
              spacing: 8.0,
              dotColor: clr.dotColor,
              activeDotColor: clr.appPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

class IconWithTitleWidget extends StatelessWidget with AppTheme {
  final String svgIcon;
  final String text;
  const IconWithTitleWidget(
      {super.key, required this.svgIcon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(svgIcon),
        SizedBox(height: size.s8),
        Text(
          text,
          style: TextStyle(
            color: clr.textColorGrey2,
            fontSize: size.textXXSmall,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class ItemSectionWidget<T> extends StatelessWidget with AppTheme {
  final String title;
  final String subTitle;
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  final double aspectRatio;
  const ItemSectionWidget({
    super.key,
    required this.title,
    this.subTitle = "",
    required this.items,
    required this.buildItem,
    this.aspectRatio = 2.9,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Header text
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.s16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: clr.textColorGrey2,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "View All",
                style: TextStyle(
                  color: clr.textColorGrey2,
                  fontSize: size.textXXSmall,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: size.s8),

        ///Items section
        AspectRatio(
          aspectRatio: aspectRatio,
          child: ListView.separated(
            itemCount: items.length < 5 ? items.length : 5,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            padding: EdgeInsets.symmetric(horizontal: size.s16),
            itemBuilder: (context, index) {
              return buildItem(context, index, items[index]);
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: size.s12);
            },
          ),
        )
      ],
    );
  }
}

class FeaturedItemWidget extends StatelessWidget with AppTheme {
  final Video data;
  final double aspectRatio;
  final VoidCallback onTap;
  const FeaturedItemWidget({
    super.key,
    required this.data,
    this.aspectRatio = 1.23,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
          aspectRatio: aspectRatio,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.s10),
                    border: Border.all(
                        color: clr.imgBorderColor.withOpacity(0.35),
                        width: size.s2),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(size.s10),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: data.thumbnailUrl,
                        placeholder: (context, url) => const Center(
                            child:
                                CircularProgressIndicator()), // Placeholder widget
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error), // Error widget
                      )),
                ),
              ),
              SizedBox(height: size.s8),
              Text(
                data.title,
                style: TextStyle(
                  color: clr.textColorHomeBlack,
                  fontSize: size.textXSmall,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              // Text(
              //   "Chapter name",
              //   style: TextStyle(
              //     color: clr.textColorGrey2,
              //     fontSize: size.textXXSmall,
              //     fontWeight: FontWeight.w500,
              //   ),
              //   maxLines: 1,
              //   overflow: TextOverflow.ellipsis,
              // ),
            ],
          )
          // child: Container(
          //   width: double.infinity,
          //   padding: EdgeInsets.all(1),
          //   decoration: BoxDecoration(
          //     color: Get.theme.cardColor,
          //     borderRadius: BorderRadius.circular(size.r8),
          //     border: Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.black.withOpacity(.2),
          //         blurRadius: 8,
          //         offset: const Offset(0.0, 6),
          //       ),
          //     ],
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Container(
          //         decoration: BoxDecoration(
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.black.withOpacity(.2),
          //               blurRadius: 8,
          //               offset: const Offset(0.0, 6),
          //             ),
          //           ],
          //         ),
          //         child: Stack(
          //           children: [
          //             ClipRRect(
          //               borderRadius: BorderRadius.circular(size.r8),
          //               child: CachedNetworkImage(
          //                 width: double.infinity,
          //                 height: 120,
          //                 imageUrl: imageUrl,
          //                 imageBuilder: (context, imageProvider) => Container(
          //                   decoration: BoxDecoration(
          //                     image: DecorationImage(
          //                       image: CachedNetworkImageProvider(imageUrl),
          //                       fit: BoxFit.cover,
          //                       colorFilter: const ColorFilter.mode(
          //                           Colors.black45, BlendMode.darken),
          //                     ),
          //                   ),
          //                 ),
          //                 placeholder: (context, url) => Ui.noImage(),
          //                 errorWidget: (context, url, error) => Ui.noImage(),
          //                 fit: BoxFit.fill,
          //               ),
          //             ),
          //             if (imageUrl.isEmpty)
          //               Container(
          //                 width: double.infinity,
          //                 height: 120,
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(size.r8),
          //                   gradient: LinearGradient(
          //                     begin: Alignment.bottomCenter,
          //                     end: Alignment.topCenter,
          //                     colors: [
          //                       Get.theme.hintColor.withOpacity(0.4),
          //                       Get.theme.hintColor.withOpacity(0.15),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //           ],
          //         ),
          //       ),
          //       SizedBox(height: size.h12),
          //       Padding(
          //         padding:
          //             EdgeInsetsDirectional.only(start: size.w8, bottom: size.h8),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.end,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             CustomTextWidget(
          //               text: title.tr,
          //               textColor: Get.theme.primaryColorDark,
          //               fontSize: size.textXXSmall,
          //               fontWeight: FontWeight.w600,
          //               maxLines: 2,
          //               overflow: TextOverflow.ellipsis,
          //             ),
          //             // SizedBox(height: size.h4),
          //             // CustomTextWidget(
          //             //   text: location.tr,
          //             //   textColor: Get.theme.cardColor,
          //             //   fontSize: size.textXXSmall,
          //             //   fontWeight: FontWeight.w400,
          //             // ),
          //             if (price != "0.0" && price != "0.00")
          //               Padding(
          //                 padding: EdgeInsets.only(top: size.h4),
          //                 child: Row(
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   children: [
          //                     CustomTextWidget(
          //                       text: "Starts from".tr,
          //                       textColor: Get.theme.primaryColorDark,
          //                       fontSize: size.textXXSmall,
          //                       fontWeight: FontWeight.w500,
          //                     ),
          //                     SizedBox(width: size.w4),
          //                     CustomTextWidget(
          //                       text: "৳$price".tr,
          //                       textColor: Get.theme.primaryColorDark,
          //                       fontSize: size.textXXSmall,
          //                       fontWeight: FontWeight.w500,
          //                       decoration: specialPrice != "0.0" &&
          //                               specialPrice != "0.00"
          //                           ? TextDecoration.lineThrough
          //                           : TextDecoration.none,
          //                     ),
          //                     SizedBox(width: size.w4),
          //                     CustomTextWidget(
          //                       text: "/$shift".tr,
          //                       textColor: Get.theme.primaryColorDark,
          //                       fontSize: size.textXXXSmall,
          //                       fontWeight: FontWeight.w400,
          //                       decoration: specialPrice != "0.0" &&
          //                               specialPrice != "0.00"
          //                           ? TextDecoration.lineThrough
          //                           : TextDecoration.none,
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             if (specialPrice != "0.0" && specialPrice != "0.00")
          //               Padding(
          //                 padding: EdgeInsets.only(top: size.h4),
          //                 child: Row(
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   children: [
          //                     CustomTextWidget(
          //                       text: "৳$specialPrice".tr,
          //                       textColor: Get.theme.primaryColorDark,
          //                       fontSize: size.textXSmall,
          //                     ),
          //                     SizedBox(width: size.w4),
          //                     CustomTextWidget(
          //                       text: "/$shift".tr,
          //                       textColor: Get.theme.primaryColorDark,
          //                       fontSize: size.textXXXSmall,
          //                       fontWeight: FontWeight.w400,
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //           ],
          //         ),
          //       ),
          //       if (price != "0.0" &&
          //           price != "0.00" &&
          //           specialPrice != "0.0" &&
          //           specialPrice != "0.00")
          //         Container(
          //           margin:
          //               EdgeInsetsDirectional.only(end: size.w8, top: size.h8),
          //           padding: EdgeInsets.symmetric(
          //               horizontal: size.w8, vertical: size.h6),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(size.r4),
          //             color: Get.theme.secondaryHeaderColor,
          //             boxShadow: [
          //               BoxShadow(
          //                   offset: const Offset(0, 2),
          //                   blurRadius: 4,
          //                   spreadRadius: 0,
          //                   color: Colors.black.withOpacity(.15))
          //             ],
          //           ),
          //           child: CustomTextWidget(
          //             text:
          //                 "${(((double.parse(price) - double.parse(specialPrice)) / double.parse(price)) * 100).round()}% OFF"
          //                     .tr
          //                     .tr,
          //             textColor: Get.theme.primaryColorDark,
          //             fontSize: size.textXXXSmall,
          //             fontWeight: FontWeight.w400,
          //           ),
          //         ),
          //     ],
          //   ),
          // ),
          ),
    );
  }
}
