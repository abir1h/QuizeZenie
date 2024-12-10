import 'package:co_learning_mobile_app/src/common/routes/app_route.dart';
import 'package:co_learning_mobile_app/src/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/action_button.dart';
import '../../../../common/widgets/custom_toasty.dart';
import '../../../../common/widgets/text_field_widget.dart';
import '../../../../common/constants/common_imports.dart';
import '../../../../common/utility/app_label.dart';
import '../../../../common/widgets/app_scaffold.dart';
import '../../../../common/widgets/app_scroll_view.dart';
import '../services/authentication_screen_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with AppTheme, Language, UserAuthenticationService {

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "",
      bgColor: clr.whiteColor,
      child: AppScrollView(
          padding: EdgeInsets.symmetric(horizontal: size.s20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              size.s64.kHeight,
              Center(child: Image.asset(ImageAssets.resetPasswordIcon)),
              size.s28.kHeight,
              Center(
                child: Text(
                  label(
                      e: en.resetPasswordTitleText,
                      b: bn.forgotPasswordTitleText),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: size.text32Large,
                      color: clr.appPrimaryColor),
                ),
              ),
              size.s16.kHeight,
              Center(
                child: Text(
                  label(
                      e: en.resetPasswordSubTitleText,
                      b: bn.forgotPasswordSubTitleText),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: size.textXXSmall,
                      color: clr.textGray),
                ),
              ),
              size.s20.kHeight,
              AppTextField(
                  outlined: true,obscureText: true,
                  fillColor: clr.textFieldFilllor,
                  prefixIconHorizontalPadding: size.s8,
                  prefixIconVerticalPadding: size.s10,
                  hintText: label(e: en.passwordText, b: bn.passwordText),
                  controller: phoneOrEmailController),  size.s20.kHeight,
              AppTextField(
                  outlined: true,obscureText: true,
                  fillColor: clr.textFieldFilllor,
                  prefixIconHorizontalPadding: size.s8,
                  prefixIconVerticalPadding: size.s10,
                  hintText: label(e: en.confirmPasswordText, b: bn.confirmPasswordText),
                  controller: confirmPasswordController),
              size.s16.kHeight,
              size.s16.kHeight,
/*
              ActionButton<dynamic>(
                title: label(e: en.continueText, b: bn.continueText),
                onCheck: () => validateLoginWithPhoneOrEmailData(
                    phoneOrEmailController.text.trim()),
                radius: size.s8,
                textColor: clr.whiteColor,
                tapAction: () => throw UnimplementedError(),
                onSuccess: (success) {},
              ),
*/
              CustomButton(onTap: ()=>Navigator.pushNamed(context,AppRoute.verifyOtpScreen), title: "Continue")
            ],
          )),
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
