import 'package:flutter/material.dart';

import '../../../common/constants/common_imports.dart';
import '../../../common/utility/app_label.dart';
import '../../../common/widgets/action_button.dart';
import '../../../common/widgets/app_scaffold.dart';
import '../../../common/widgets/custom_toasty.dart';
import '../services/profile_screen_service.dart';
import 'account_details.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    with Language, AppTheme, ProfileScreenService {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        bgColor: clr.backgroundColor1,
        title: label(e: "Change Password", b: "ផ្លាស់ប្តូរពាក្យសម្ងាត់"),
        child: Stack(
          children: [
            Container(height: double.infinity,
                padding: EdgeInsets.all(size.s16),
                margin: EdgeInsets.only(top: size.s2),
                decoration: BoxDecoration(color: clr.whiteColor),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label(e: "Change Password:", b: "ផ្លាស់ប្តូរពាក្យសម្ងាត់៖"),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: size.textSmall,
                            color: clr.textColorGrey2),
                      ),
                      size.s12.kHeight,
                      ProfileTextField(
                        controller: currentPasswordController,
                        hint: label(
                            e: "Current Password", b: "ពាក្យសម្ងាត់បច្ចុប្បន្ន"),
                        label: label(
                            e: "Current Password", b: "ពាក្យសម្ងាត់បច្ចុប្បន្ន"),
                        obscureText: true,
                      ),
                      ProfileTextField(
                        controller: newPasswordController,
                        hint: label(
                            e: "New Password", b: "ពាក្យសម្ងាត់ថ្មី។"),
                        label: label(
                            e: "New Password", b: "ពាក្យសម្ងាត់ថ្មី"),
                        obscureText: true,
                      ), ProfileTextField(
                        controller: confirmPasswordController,
                        hint: label(
                            e: "Confirm Password", b: "បញ្ជាក់ពាក្យសម្ងាត់។"),
                        label: label(
                            e: "Confirm Password", b: "បញ្ជាក់ពាក្យសម្ងាត់។"),
                        obscureText: true,
                      ),
                      size.s64.kHeight,
                      size.s64.kHeight
                    ],
                  ),
                )),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.s16, vertical: size.s12),
                  decoration: BoxDecoration(color: clr.whiteColor, boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: size.s4,
                        spreadRadius: 0,
                        color: clr.blackColor.withOpacity(.2))
                  ]),
                  child: ActionButton<dynamic>(
                    title: label(e: en.updateText, b: bn.updateText),
                    radius: size.s8,
                    textColor: clr.whiteColor,
                    tapAction: () => throw UnimplementedError(),
                    onSuccess: (success) {},
                  ),
                ))



          ],
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
  void showBottomSheetForImagePicker() {
    // TODO: implement showBottomSheetForImagePicker
  }

  @override
  void showImageCropper(String path) {
    // TODO: implement showImageCropper
  }
  @override
  void lockUI() {
    Toasty.of(context).lockUI(blockBackPress: true);
  }

  @override
  void releaseUI() {
    Toasty.of(context).releaseUI();
  }

}