import 'package:flutter/material.dart';

import '../../../common/routes/app_route.dart';
import '../../../common/widgets/custom_toasty.dart';
import '../../../common/constants/common_imports.dart';
import '../../../common/utility/app_label.dart';
import '../../../common/widgets/app_scaffold.dart';
import '../../../common/widgets/app_scroll_view.dart';
import '../../../common/widgets/custom_button.dart';
import '../services/video_upload_info_screen_service.dart';

class VideoUploadInfoScreen extends StatefulWidget {
  const VideoUploadInfoScreen({super.key});

  @override
  State<VideoUploadInfoScreen> createState() => _VideoUploadInfoScreenState();
}

class _VideoUploadInfoScreenState extends State<VideoUploadInfoScreen>
    with AppTheme, Language, VideoUploadInfoScreenService {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: label(e: "Upload video", b: "បង្ហោះវីដេអូ"),
      bgColor: clr.whiteColor,
      hasAppBar: true,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: clr.textFieldStrokeColor,
                width: 1.0,
              ),
            ),
          ),
          child: AppScrollView(
            padding: EdgeInsets.symmetric(horizontal: size.s20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                size.s32.kHeight,
                Center(child: Image.asset(ImageAssets.imgVideoObject)),
                size.s28.kHeight,
                Center(
                  child: Text(
                    label(e: "Upload video", b: "បង្ហោះវីដេអូ"),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: size.textSmall,
                        color: clr.textColorBlack),
                  ),
                ),
                size.s12.kHeight,
                Center(
                  child: Text(
                    label(
                        e: "You can record the video and upload or you can also upload the pre recorded video from your device gallery.",
                        b: "អ្នក​អាច​ថត​វីដេអូ​និង​ផ្ទុក​ឡើង​ឬអ្នកក៏អាចបង្ហោះវីដេអូដែលបានថតទុកមុនពីវិចិត្រសាលឧបករណ៍របស់អ្នកផងដែរ។"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: size.textXSmall,
                        color: clr.textGray),
                  ),
                ),
                size.s16.kHeight,
                Center(
                  child: Text(
                    label(
                        e: "Supported file type: mp4, avi or others",
                        b: "ប្រភេទឯកសារដែលគាំទ្រ៖ mp4, avi ឬផ្សេងទៀត។"),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: size.textXXSmall,
                        color: clr.textGray),
                  ),
                ),
                size.s24.kHeight,
                CustomButton(
                  onTap: () => pickVideoFile(),
                  title: label(
                      e: " Upload From Gallery", b: " ផ្ទុកឡើងពីវិចិត្រសាល"),
                  textSize: size.textXSmall,
                  radius: size.s8,
                  icon: Icons.add_photo_alternate,
                ),
                size.s16.kHeight,
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                      height: size.s1,
                      color: clr.dividerColor,
                    )),
                    size.s10.kWidth,
                    Text(label(e: "Or", b: "ឬ")),
                    size.s10.kWidth,
                    Expanded(
                        child: Divider(
                      height: size.s1,
                      color: clr.dividerColor,
                    )),
                  ],
                ),
                size.s16.kHeight,
                CustomButton(
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoute.videoRecordScreen),
                  title:
                      label(e: " Open Camera & Record", b: " បើកកាមេរ៉ា និងថត"),
                  textSize: size.textXSmall,
                  radius: size.s8,
                  textColor: clr.appPrimaryColor,
                  borderColor: clr.appPrimaryColor,
                  bgColor: clr.whiteColor,
                  icon: Icons.add_a_photo,
                  iconColor: clr.appPrimaryColor,
                ),
                size.s64.kHeight,
              ],
            ),
          ),
        ),
      ),
    );
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
