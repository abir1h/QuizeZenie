import 'package:co_learning_mobile_app/src/feature/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/constants/common_imports.dart';
import '../../../common/routes/app_route.dart';
import '../../../common/service/notifier/app_events_notifier.dart';
import '../../../common/utility/app_label.dart';
import '../../bookmark/screens/bookmark_screen.dart';
import '../../home/screens/home_screen.dart';
import '../../video/screens/video_upload_info_screen.dart';
import '../services/landing_screen_services.dart';

class LandingScreen extends StatefulWidget {
  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with AppTheme, Language, LandingScreenService, AppEventsNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;

  List<Widget> pages = [
    const HomeScreen(),
    BookmarkListScreen(),
    VideoUploadInfoScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: clr.backgroundColor,
      resizeToAvoidBottomInset: false,
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(size.s56),
      //   child: Text("AppABr"),
      // ),

      body: pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: onTapVideoRecordButton,
        backgroundColor: clr.appPrimaryColor,
        shape: const CircleBorder(),
        child: Icon(
          Icons.video_call,
          size: size.s24,
          color: clr.whiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: clr.whiteColor,
        shape: const CircularNotchedRectangle(),
        height: size.s64,
        notchMargin: 5,
        shadowColor: clr.grayColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NavBarItemWidget(
                  svgIcon: _selectedIndex == 0
                      ? ImageAssets.icHomeFilled
                      : ImageAssets.icHome,
                  title: label(e: en.homeText, b: bn.homeText),
                  color:
                      _selectedIndex == 0 ? clr.appPrimaryColor : clr.grayColor,
                  onTap: () => _onNavItemTapped(0),
                ),
                NavBarItemWidget(
                  svgIcon: _selectedIndex == 1
                      ? ImageAssets.icBookmarkFilled
                      : ImageAssets.icBookmark,
                  title: label(e: en.bookmarkText, b: bn.bookmarkText),
                  color:
                      _selectedIndex == 1 ? clr.appPrimaryColor : clr.grayColor,
                  onTap: () => _onNavItemTapped(1),
                ),
              ],
            ),
        /*    Text(
              label(e: en.captureText, b: bn.captureText),
              style: TextStyle(
                  color: clr.grayColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: StringData.fontFamilyRoboto,
                  fontSize: size.textXXSmall),
            ),*/
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NavBarItemWidget(
                  svgIcon: _selectedIndex == 2
                      ? ImageAssets.upload_filled
                      : ImageAssets.upload,
                  title: label(e: en.recordText, b: bn.recordText),
                  color:
                      _selectedIndex == 2 ? clr.appPrimaryColor : clr.grayColor,
                  onTap: () => _onNavItemTapped(2),
                ),
                NavBarItemWidget(
                  svgIcon: _selectedIndex == 3
                      ? ImageAssets.icProfileFilled
                      : ImageAssets.icProfile,
                  title: label(e: en.profileText, b: bn.profileText),
                  color:
                      _selectedIndex == 3 ? clr.appPrimaryColor : clr.grayColor,
                  onTap: () => _onNavItemTapped(3),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void navigateBookMarkScreen() {
    // TODO: implement navigateBookMarkScreen
  }

  @override
  void navigateToCategoryScreen() {
    // TODO: implement navigateToCategoryScreen
  }

  @override
  void navigateToHomeScreen() {
    // TODO: implement navigateToHomeScreen
  }

  @override
  void navigateToProfileScreen() {
    // TODO: implement navigateToProfileScreen
  }

  @override
  void onEventReceived(EventAction action) {
    if (action == EventAction.bottomNavBar) {
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void navigateToRecordScreen() {
    Navigator.pushNamed(context, AppRoute.videoRecordScreen);
  }
}

class NavBarItemWidget extends StatelessWidget with AppTheme {
  final String svgIcon;
  final String title;
  final Color color;
  final VoidCallback onTap;
  const NavBarItemWidget({
    super.key,
    required this.svgIcon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 25,
      onPressed: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgIcon,
            width: size.s20,
          ),
          Text(
            title,
            style: TextStyle(
                color: color,
                fontWeight: FontWeight.w500,
                fontFamily: StringData.fontFamilyRoboto,
                fontSize: size.textXXSmall),
          ),
        ],
      ),
    );
  }
}
