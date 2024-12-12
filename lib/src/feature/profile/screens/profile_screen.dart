import 'package:cached_network_image/cached_network_image.dart';
import 'package:co_learning_mobile_app/src/common/constants/common_imports.dart';
import 'package:co_learning_mobile_app/src/common/utility/app_label.dart';
import 'package:co_learning_mobile_app/src/feature/profile/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../common/config/app.dart';
import '../../../common/routes/app_route.dart';
import '../widgets/toggle_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AppTheme, Language {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: clr.whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            label(e: en.myProfileText, b: bn.myProfileText),
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: size.textXMedium,
                color: clr.blackColor),
          ),
          /*  actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),  // Added padding for spacing
            child: AnimatedToggle(
              values: ['English', 'Khmer'],
              onToggleCallback: (value) {
                App.setAppLanguage(value).then((value) {
                  if (mounted) {
                    setState(() {});
                  }
                 */ /* AppEventsNotifier.notify(EventAction.bottomNavAllScreen);
                  AppEventsNotifier.notify(EventAction.bottomNavBar);
                  AppEventsNotifier.notify(EventAction.graphChart);*/ /*
                });
              },
              buttonColor:clr.selectedToggleColor,
              backgroundColor: clr.inactiveToggleColor,
              textColor: const Color(0xFFFFFFFF),
            ),
          ),
        ],*/
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight:
                    MediaQuery.of(context).size.height), // Set the min height
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(size.s20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(size.s28),
                      bottomRight: Radius.circular(size.s28),
                    ),
                    image: DecorationImage(
                      image: AssetImage(ImageAssets.imgHomeBG),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://www.treasury.gov.ph/wp-content/uploads/2022/01/male-placeholder-image.jpeg",
                                    fit: BoxFit.cover,
                                    height: size.s20 * 4,
                                    width: size.s20 * 4,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      // Add your logic here
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(size.s4),
                                      decoration: BoxDecoration(
                                        color: clr.appPrimaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.add_a_photo_rounded,
                                        size: size.s16,
                                        color: clr.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: size.s10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Username Username ",
                                    style: TextStyle(
                                      color: clr.whiteColor,
                                      fontSize: size.textSmall,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins",
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: size.s4),
                                  Text(
                                    "Username@email.com",
                                    style: TextStyle(
                                      color: clr.whiteColor,
                                      fontSize: size.textXXSmall,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  size.s8.kHeight,
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.s10,
                                        vertical: size.s2),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(size.s4),
                                      color: clr.appPrimaryColor,
                                    ),
                                    child: Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: size.textXXXSmall,
                                          color: clr.whiteColor),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      size.s8.kHeight,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.s8),
                        child: Text(
                          "Teacher",
                          style: TextStyle(
                              fontSize: size.textMedium,
                              fontWeight: FontWeight.w600,
                              color: clr.whiteColor),
                        ),
                      ),
                      size.s4.kHeight,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.s8),
                        child: Row(
                          children: [
                            SvgPicture.asset(ImageAssets.shield),
                            size.s8.kWidth,
                            Text(
                              "Assistant Professor",
                              style: TextStyle(
                                  fontSize: size.textXXSmall,
                                  fontWeight: FontWeight.w600,
                                  color: clr.whiteColor),
                            ),
                          ],
                        ),
                      ),
                      size.s8.kHeight,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.s8),
                        child: Row(
                          children: [
                            SvgPicture.asset(ImageAssets.organistaion),
                            size.s8.kWidth,
                            Text(
                              "School name/ Organization name",
                              style: TextStyle(
                                  fontSize: size.textXXSmall,
                                  fontWeight: FontWeight.w600,
                                  color: clr.whiteColor),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                size.s16.kHeight,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.s16),
                  child: Container(
                    padding: EdgeInsets.all(size.s16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.s12),
                        border: Border.all(color: clr.greyBorder)),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          CountCard(onTap: () {}, title: "Videos", count: 10),
                          Expanded(
                              child: VerticalDivider(
                            color: clr.greyBorder,
                          )),
                          CountCard(
                              onTap: () {}, title: "Bookmarks", count: 20),
                          Expanded(
                              child: VerticalDivider(
                            color: clr.greyBorder,
                          )),
                          CountCard(
                              onTap: () {}, title: "Feedbacks", count: 100),
                        ],
                      ),
                    ),
                  ),
                ),
                size.s20.kHeight,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.s16),
                  child: Container(
                      padding: EdgeInsets.all(size.s16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(size.s12),
                          border: Border.all(color: clr.greyBorder)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileCard(
                              onTap: () {},
                              iconName: ImageAssets.accountDetails,
                              title: label(
                                  e: en.accountDetails, b: bn.accountDetails)),
                          ProfileCard(
                              onTap: () {},
                              iconName: ImageAssets.myVideos,
                              title: label(e: en.myVideos, b: bn.myVideos)),
                          ProfileCard(
                              onTap: () {},
                              iconName: ImageAssets.myActivity,
                              title: label(e: en.myActivity, b: bn.myActivity)),
                          ProfileCard(
                              onTap: () {},
                              iconName: ImageAssets.changeLanguage,
                              title: label(
                                  e: en.changeLanguage, b: bn.changeLanguage)),
                          ProfileCard(
                              onTap: () {},
                              iconName: ImageAssets.changePassword,
                              isLast: true,
                              title: label(
                                  e: en.changePassword, b: bn.changePassword)),
                        ],
                      )),
                ),
                size.s16.kHeight,
                GestureDetector(
                  onTap: () => App.logOut().then(
                      (value) => Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoute.signInScreen,
                            (Route<dynamic> route) => false,
                          )),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: size.s16),
                    padding: EdgeInsets.symmetric(vertical: size.s10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.s8),
                        color: clr.inactiveToggleColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.login_outlined,
                          color: clr.iconColorGray,
                        ),
                        size.s4.kWidth,
                        Text(
                          "Logout",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.textXSmall,
                              color: clr.iconColorGray),
                        )
                      ],
                    ),
                  ),
                ),
                size.s64.kHeight,
              ],
            ),
          ),
        ));
  }
}

class CountCard extends StatelessWidget with AppTheme {
  final VoidCallback onTap;
  final String title;
  final int count;
  const CountCard(
      {super.key,
      required this.onTap,
      required this.title,
      required this.count});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              count.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: size.textLarge,
                  color: clr.profileCardTextColor),
            ),
            size.s4.kHeight,
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: size.textXXXSmall,
                  color: clr.lightGray),
            ),
            size.s4.kHeight,
            Text(
              "Details",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: size.textXXXSmall,
                  color: clr.appPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
