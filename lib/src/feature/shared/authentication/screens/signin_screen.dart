import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/widgets/action_button.dart';
import '../../../../common/widgets/custom_toasty.dart';
import '../../../../common/widgets/text_field_widget.dart';
import '../../../../common/constants/common_imports.dart';
import '../../../../common/utility/app_label.dart';
import '../../../../common/widgets/app_scaffold.dart';
import '../../../../common/widgets/app_scroll_view.dart';
import '../services/sign_up_screen_service.dart';
import '../../../../common/routes/app_route.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with AppTheme, Language,UserAuthenticationService   {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "",
      bgColor: clr.whiteColor,
      hasAppBar: false,
      child: AppScrollView(
          padding: EdgeInsets.symmetric(horizontal: size.s20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              size.s64.kHeight,
              Center(child: Image.asset(ImageAssets.signInIcon)),
              size.s28.kHeight,
              Center(
                child: Text(
                  label(e: en.signInTitleText, b: bn.signInTitleText),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: size.text32Large,
                      color: clr.appPrimaryColor),
                ),
              ),
              size.s16.kHeight,
              Center(
                child: Text(
                  label(e: en.signInSubTitleText, b: bn.signInSubTitleText),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: size.textXXSmall,
                      color: clr.textGray),
                ),
              ),
              size.s20.kHeight,
              AppTextField(
                  outlined: true,
                  fillColor: clr.textFieldFilllor,
                  prefixIconHorizontalPadding: size.s8,
                  prefixIconVerticalPadding: size.s10,
                  hintText: label(e: en.nameOrEmailText, b: bn.nameOrEmailText),
                  controller: TextEditingController()),
              size.s16.kHeight,
              AppTextField(
                  outlined: true,
                  fillColor: clr.textFieldFilllor,
                  prefixIconHorizontalPadding: size.s8,
                  prefixIconVerticalPadding: size.s10,
                  obscureText: true,
                  hintText: label(e: en.passwordText, b: bn.passwordText),
                  controller: TextEditingController()),
              size.s8.kHeight,
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  label(e: en.forgetPasswordText, b: bn.forgetPasswordText),
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: size.textXXSmall,
                      color: clr.forgotPasswordTextColor),
                ),
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
              Row(
                children: [
                  Expanded(child: Container(
                    padding: EdgeInsets.all(size.s16),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.s12),
                      color: clr.textFieldFilllor
                    ),child: Row(
                    children: [
                      SvgPicture.asset(ImageAssets.icGoogle),
                      size.s16.kWidth,
                      Text("Google",style: TextStyle(fontWeight: FontWeight.w500,fontSize: size.textSmall,color: clr.textGray),)

                    ],
                  ),
                  )),
                  size.s16.kWidth,
                  Expanded(child: Container(
                    padding: EdgeInsets.all(size.s16),

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.s12),
                        color: clr.textFieldFilllor
                    ),child: Row(
                    children: [
                      SvgPicture.asset(ImageAssets.icFacebook),
                      size.s16.kWidth,
                      Text("Facebook",style: TextStyle(fontWeight: FontWeight.w500,fontSize: size.textSmall,color: clr.textGray),)

                    ],
                  ),
                  )),

                ],
              ),
              size.s32.kHeight,
              ActionButton<dynamic>(
                title: label(e: en.loginText, b: bn.loginText),

                radius: size.s8,

                textColor: clr.whiteColor,
                tapAction: () =>throw UnimplementedError(),
                onSuccess: (success) {

                },
              ),
              size.s16.kHeight,
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Don’t have an account? ",
                        style:  TextStyle(color: clr.textDarkGrey, fontSize: size.textXSmall,fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style:  TextStyle(color: clr.appPrimaryColor, fontSize: size.textXSmall,fontWeight: FontWeight.w400),

                            recognizer: TapGestureRecognizer()
                              ..onTap = () =>Navigator.pushNamed(context,AppRoute.signUpScreen),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),      size.s64.kHeight,
              size.s64.kHeight,



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
