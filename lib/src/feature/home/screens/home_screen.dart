import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/constants/app_theme.dart';
import '../../../common/constants/common_imports.dart';
import '../../../common/utility/app_label.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AppTheme {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            expandedHeight: 1.sw,
            // collapsedHeight: 200,
            floating: true,
            pinned: true,
            snap: true,
            backgroundColor: clr.appPrimaryColor,
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
                  border:
                      Border.all(color: clr.iconBorderColor, width: size.s2),
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
                Align(
                  alignment: Alignment.topCenter,
                  child: AnimatedOpacity(
                    opacity: innerBoxIsScrolled ? 0.7 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      height: 1.sw * .9,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          // colorFilter: const ColorFilter.mode(
                          //     Colors.black54, BlendMode.darken),
                          image: AssetImage(ImageAssets.imgHomeBG),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedOpacity(
                        opacity: innerBoxIsScrolled ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(size.s8),
                                    border: Border.all(
                                        color: clr.cardStrokeColor, width: size.s1)),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ];
      },
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(),
          ],
        ),
      ),
    );
  }
}
