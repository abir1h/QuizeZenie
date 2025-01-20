import 'package:co_learning_mobile_app/src/common/routes/app_route_args.dart';
import 'package:co_learning_mobile_app/src/common/widgets/custom_toasty.dart';
import 'package:co_learning_mobile_app/src/feature/profile/models/profile_entity.dart';
import 'package:co_learning_mobile_app/src/feature/profile/services/profile_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import "package:cached_network_image/cached_network_image.dart";
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/config/app.dart';
import '../../../common/routes/app_route.dart';
import '../../../common/constants/common_imports.dart';
import '../../../common/utility/app_label.dart';
import '../../../common/widgets/app_stream.dart';
import '../../../common/widgets/shimmer_loader.dart';
import '../widgets/bottomsheet.dart';
import '../widgets/profile_card.dart';
import '../widgets/select_laguage_bottomshet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AppTheme, Language, ProfileScreenService {
  @override
  void initState() {
    loadInitialData();
    super.initState();
  }

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
          actions: [
            /*  Padding(
            padding: const EdgeInsets.all(10.0),  // Added padding for spacing
            child: AnimatedToggle(
              values: ['English', 'Khmer'],
              onToggleCallback: (value) {
                App.setAppLanguage(value).then((value) {
                  if (mounted) {
                    setState(() {});
                  }
                   AppEventsNotifier.notify(EventAction.bottomNavAllScreen);
                  AppEventsNotifier.notify(EventAction.bottomNavBar);
                  AppEventsNotifier.notify(EventAction.graphChart);
                });
              },
              buttonColor:clr.selectedToggleColor,
              backgroundColor: clr.inactiveToggleColor,
              textColor: const Color(0xFFFFFFFF),
            ),
          ),*/
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height), // Set the min height
              child: AppStreamBuilder<ProfileEntity>(
                stream: profileStreamController.stream,
                loadingBuilder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                dataBuilder: (context, data) {
                  return Column(
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
                                      StreamBuilder<DataState<String>>(
                                          initialData: LoadingState<String>(),
                                          stream: profilePicStreamController.stream,
                                          builder: (context, snapshot) {
                                            var state = snapshot.data!;
                                            if(state is DataLoadedState) {
                                              return ClipRRect(
                                                borderRadius: BorderRadius.circular(50),
                                                child: CachedNetworkImage(
                                                  imageUrl:  data.profileUrl,
                                                  fit: BoxFit.cover,
                                                  height: size.s20 * 4,
                                                  width: size.s20 * 4,
                                                  placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                                  errorWidget: (context, url, error) =>
                                                      Image.asset(ImageAssets.placeholder),
                                                ),
                                              );
                                            }
                                            else{
                                              return ShimmerLoader(
                                                child: Container(
                                                  width: size.s56,
                                                  height: size.s56,
                                                  color: clr.secondaryBackgroundLight,
                                                ),
                                              );
                                            }
                                          }
                                      ),

                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: GestureDetector(
                                          onTap:showBottomSheetForImagePicker,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.userFullName,
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
                                          data.email,
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
                                        GestureDetector(
                                          onTap: () => Navigator.pushNamed(
                                              context,
                                              AppRoute.accountDetailsScreen,
                                              arguments:
                                                  AccountDetailsScreenArgs(
                                                      profileData: data,
                                                      onAddLiveClass: () =>
                                                          loadInitialData())),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: size.s10,
                                                vertical: size.s2),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      size.s4),
                                              color: clr.appPrimaryColor,
                                            ),
                                            child: Text(
                                              "Edit Profile",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: size.textXXXSmall,
                                                  color: clr.whiteColor),
                                            ),
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
                              padding:
                                  EdgeInsets.symmetric(horizontal: size.s8),
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
                              padding:
                                  EdgeInsets.symmetric(horizontal: size.s8),
                              child: Row(
                                children: [
                                  SvgPicture.asset(ImageAssets.shield),
                                  size.s8.kWidth,
                                  Flexible(
                                    child: Text(
                                      data.designation,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: size.textXXSmall,
                                          fontWeight: FontWeight.w600,
                                          color: clr.whiteColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            size.s8.kHeight,
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: size.s8),
                              child: Row(
                                children: [
                                  SvgPicture.asset(ImageAssets.organistaion),
                                  size.s8.kWidth,
                                  Flexible(
                                    child: Text(
                                      data.schoolName.isNotEmpty
                                          ? data.schoolName
                                          : "N/A",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: size.textXXSmall,
                                          fontWeight: FontWeight.w600,
                                          color: clr.whiteColor),
                                    ),
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
                                CountCard(
                                    onTap: () {}, title: "Videos", count: data.totalVideos),
                                Expanded(
                                    child: VerticalDivider(
                                  color: clr.greyBorder,
                                )),
                                CountCard(
                                    onTap: () {},
                                    title: "Bookmarks",
                                    count: data.totalBookmarks),
                                Expanded(
                                    child: VerticalDivider(
                                  color: clr.greyBorder,
                                )),
                                CountCard(
                                    onTap: () {},
                                    title: "Feedbacks",
                                    count: data.totalComments),
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
                                    onTap: () => Navigator.pushNamed(
                                        context, AppRoute.accountDetailsScreen,
                                        arguments: AccountDetailsScreenArgs(
                                            profileData: data,
                                            onAddLiveClass: () =>
                                                loadInitialData())),
                                    iconName: ImageAssets.accountDetails,
                                    title: label(
                                        e: en.accountDetails,
                                        b: bn.accountDetails)),
                                ProfileCard(
                                    onTap: () => Navigator.of(context)
                                        .pushNamed(AppRoute.myVideoScreen),
                                    iconName: ImageAssets.myVideos,
                                    title:
                                        label(e: en.myVideos, b: bn.myVideos)),
                                ProfileCard(
                                    onTap: () {},
                                    iconName: ImageAssets.myActivity,
                                    title: label(
                                        e: en.myActivity, b: bn.myActivity)),
                                ProfileCard(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (BuildContext context) {
                                          return SelectLanguageBottomSheet(
                                            context: context,
                                          );
                                        },
                                      );
                                    },
                                    iconName: ImageAssets.changeLanguage,
                                    title: label(
                                        e: en.changeLanguage,
                                        b: bn.changeLanguage)),
                                ProfileCard(
                                    onTap: () => Navigator.pushNamed(
                                        context, AppRoute.changePasswordScreen),
                                    iconName: ImageAssets.changePassword,
                                    isLast: true,
                                    title: label(
                                        e: en.changePassword,
                                        b: bn.changePassword)),
                              ],
                            )),
                      ),
                      size.s16.kHeight,
                      GestureDetector(
                        onTap: () => App.logOut().then((value) =>showLogoutPromptDialog()),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: size.s16),
                          padding: EdgeInsets.symmetric(vertical: size.s10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(size.s8),
                              color: clr.logoutBColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.login_outlined,
                                color: clr.appPrimaryColor,
                              ),
                              size.s4.kWidth,
                              Text(
                                "Logout",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: size.textXSmall,
                                    color: clr.appPrimaryColor),
                              )
                            ],
                          ),
                        ),
                      ),
                      size.s64.kHeight,
                    ],
                  );
                },
                emptyBuilder: (context, message, icon) => const Offstage(),
              )),
        ));
  }

  @override
  void showSuccess(String message) {
    Toasty.of(context).showSuccess(message);
  }

  @override
  void showWarning(String message) {
    Toasty.of(context).showWarning(message);
  }
  @override
  void lockUI() {
    Toasty.of(context).lockUI(blockBackPress: true);
  }

  @override
  void releaseUI() {
    Toasty.of(context).releaseUI();
  }

  @override
  void showBottomSheetForImagePicker() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return BottomSheetImagePicker(
          onCamera: () => onPickerOptionSelected(ImageSource.camera),
          onGallery: () => onPickerOptionSelected(ImageSource.gallery),
        );
      },
    );

  }

  @override
  void showImageCropper(String path) {
    ImageCropper().cropImage(
      sourcePath: path,

      maxHeight: 150,
      maxWidth: 150,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Adjust image',
          lockAspectRatio: true,
          toolbarColor: clr.appPrimaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          activeControlsWidgetColor: Colors.orange,
        ),
        IOSUiSettings(
          title: "Adjust image",
          minimumAspectRatio: 1.0,
          aspectRatioLockEnabled: true,
        )
      ],
    ).then((imageFile){
      onImageCropped(imageFile);
    }).catchError((e){
      showWarning("Failed to adjust image!"+e.toString());
    });
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
