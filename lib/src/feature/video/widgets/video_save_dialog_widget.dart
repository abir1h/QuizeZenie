import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/config/app.dart';
import '../../../common/widgets/custom_toasty.dart';
import '../../../common/constants/common_imports.dart';
import '../../../common/widgets/text_field.dart';

mixin VideoSaveDialogWidget<T extends StatefulWidget> on State<T> {
  late TextEditingController recordingTextEditingController;

  @override
  void initState() {
    super.initState();
    recordingTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    recordingTextEditingController.dispose();
  }

  Future<String> showVideoSaveDialogWidget({required BuildContext context,required String folderName,required   Function(String ) videoName}) {
    Completer<String> completer = Completer();
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: GestureDetector(
              onTap: () {},
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: ThemeSize.instance.s24,
                      vertical: ThemeSize.instance.s24),
                  padding: EdgeInsets.symmetric(
                      horizontal: ThemeSize.instance.s20,
                      vertical: ThemeSize.instance.s20),
                  decoration: BoxDecoration(
                    color: ThemeColor.instance.secondaryBackgroundColor,
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: ThemeSize.instance.s10),
                      Row(
                        children: [
                          Icon(Icons.check_circle,
                              size: 32.r,
                              color: ThemeColor.instance.greenRipple),
                          SizedBox(width: ThemeSize.instance.s12),
                          Text("Save Video",
                              style: TextStyle(
                                  color: ThemeColor.instance.textColorBlack,
                                  fontSize: ThemeSize.instance.textSmall,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: StringData.fontFamilyPoppins),
                              textAlign: TextAlign.left),
                        ],
                      ),
                      SizedBox(height: ThemeSize.instance.s16),
                      const HeaderTextWidget(title: "Name of the recording"),
                      SizedBox(height: ThemeSize.instance.s8),
                      TextFieldWidget(
                          hintText: "Recording Name",
                          controller: recordingTextEditingController,
                        onChangeValue: (value){
                          videoName.call(value);
                        },
                      ),
                      SizedBox(height: ThemeSize.instance.s16),
                      const HeaderTextWidget(title: "Recorded by:"),
                      SizedBox(height: ThemeSize.instance.s8),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ThemeColor.instance.iconGrey,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: ThemeColor.instance.iconGrey,
                                  width: ThemeSize.instance.s1),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  height: ThemeSize.instance.s32,
                                  width: ThemeSize.instance.s32,
                                  fit: BoxFit.fill,
                                  imageUrl:
                                      "https://us.123rf.com/450wm/pavelstasevich/pavelstasevich1902/pavelstasevich190200120/124934975-no-image-available-icon-vector-flat.jpg?ver=6",
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                )),
                          ),
                          SizedBox(width: ThemeSize.instance.s12),
                          Text(App.currentSession.user.username,
                              style: TextStyle(
                                  color: ThemeColor.instance.textColorBlack,
                                  fontSize: ThemeSize.instance.textXSmall,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: StringData.fontFamilyPoppins),
                              textAlign: TextAlign.left)
                        ],
                      ),
                      SizedBox(height: ThemeSize.instance.s16),
                      const HeaderTextWidget(title: "Folder or Category:"),
                      SizedBox(height: ThemeSize.instance.s8),
                      Row(
                        children: [
                          SvgPicture.asset(ImageAssets.icPersons),
                          SizedBox(width: ThemeSize.instance.s12),
                          Text(folderName,
                              style: TextStyle(
                                  color: ThemeColor.instance.textColorBlack,
                                  fontSize: ThemeSize.instance.textXSmall,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: StringData.fontFamilyPoppins),
                              textAlign: TextAlign.left)
                        ],
                      ),
                      SizedBox(height: ThemeSize.instance.s32),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(""),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 10.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.w),
                                  color: ThemeColor.instance.iconColorGray,
                                  border: Border.all(
                                      color: ThemeColor.instance.iconColorGray,
                                      width: 1.w),
                                ),
                                child: Center(
                                  child: Text(
                                    "Not saved",
                                    style: TextStyle(
                                        color: ThemeColor
                                            .instance.shadeWhiteColor2,
                                        fontSize: ThemeSize.instance.textSmall,
                                        fontWeight: FontWeight.w500,
                                        fontFamily:
                                            StringData.fontFamilyPoppins),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (recordingTextEditingController
                                    .text.isNotEmpty) {
                                  Navigator.of(context)
                                      .pop(recordingTextEditingController.text);
                                } else {
                                  Toasty.of(context).showWarning(
                                      "Please enter recording name!");
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 10.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.w),
                                  color: ThemeColor.instance.appPrimaryColor,
                                  border: Border.all(
                                      color:
                                          ThemeColor.instance.appPrimaryColor,
                                      width: 1.w),
                                ),
                                child: Center(
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                        color: ThemeColor.instance.whiteColor,
                                        fontSize: ThemeSize.instance.textSmall,
                                        fontWeight: FontWeight.w500,
                                        fontFamily:
                                            StringData.fontFamilyPoppins),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ).then((x) {
      if (x != null && x.isNotEmpty) {
        completer.complete(recordingTextEditingController.text);
      } else {
        completer.complete("");
      }
    });
    return completer.future;
  }
}

class HeaderTextWidget extends StatelessWidget {
  final String title;
  const HeaderTextWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(
            color: ThemeColor.instance.textColorBlack,
            fontSize: ThemeSize.instance.textXXSmall,
            fontWeight: FontWeight.w500,
            fontFamily: StringData.fontFamilyPoppins),
        textAlign: TextAlign.left);
  }
}
