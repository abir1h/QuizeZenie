import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/models/user_entity.dart';
import '../../../../common/routes/app_route.dart';
import '../../../../common/routes/app_route_args.dart';
import '../../../../common/widgets/action_button.dart';
import '../../../../common/widgets/text_field_widget.dart';
import '../../../../common/constants/common_imports.dart';
import '../../../../common/utility/app_label.dart';
import '../../../../common/widgets/app_scaffold.dart';
import '../../../../common/widgets/app_scroll_view.dart';
import '../services/authentication_screen_service.dart';
import '../../../../common/widgets/custom_toasty.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with AppTheme, Language, UserAuthenticationService {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "",
      bgColor: clr.whiteColor,
      hasAppBar: false,
      resizeToAvoidBottomInset: true,
      child: AppScrollView(
          padding: EdgeInsets.symmetric(horizontal: size.s20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              size.s64.kHeight,
              Center(child: Image.asset(ImageAssets.signUpIcon)),
              size.s28.kHeight,
              Center(
                child: Text(
                  label(e: en.signUpTitleText, b: bn.signUpTitleText),
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
                  hintText: label(e: en.nameText, b: bn.nameText),
                  controller: userNameController),
              size.s16.kHeight,
              AppTextField(
                  outlined: true,
                  fillColor: clr.textFieldFilllor,
                  prefixIconHorizontalPadding: size.s8,
                  prefixIconVerticalPadding: size.s10,
                  hintText: label(e: en.nameOrEmailText, b: bn.nameOrEmailText),
                  controller: phoneOrEmailController),
              size.s16.kHeight,
              AppTextField(
                  outlined: true,
                  fillColor: clr.textFieldFilllor,
                  prefixIconHorizontalPadding: size.s8,
                  prefixIconVerticalPadding: size.s10,
                  obscureText: true,
                  hintText: label(e: en.passwordText, b: bn.passwordText),
                  controller: passwordController),
              size.s8.kHeight,
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
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.all(size.s16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.s12),
                        color: clr.textFieldFilllor),
                    child: Row(
                      children: [
                        SvgPicture.asset(ImageAssets.icGoogle),
                        size.s16.kWidth,
                        Text(
                          "Google",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: size.textSmall,
                              color: clr.textGray),
                        )
                      ],
                    ),
                  )),
                  size.s16.kWidth,
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.all(size.s16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.s12),
                        color: clr.textFieldFilllor),
                    child: Row(
                      children: [
                        SvgPicture.asset(ImageAssets.icFacebook),
                        size.s16.kWidth,
                        Text(
                          "Facebook",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: size.textSmall,
                              color: clr.textGray),
                        )
                      ],
                    ),
                  )),
                ],
              ),
              size.s20.kHeight,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                    ),
                  ),
                  size.s16.kWidth,
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "I agree to the ",
                            style: TextStyle(
                              color: clr.textColorBlack,
                              fontSize: size.textXSmall,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: "terms and conditions",
                            style: TextStyle(
                              color: clr.appPrimaryColor,
                              fontSize: size.textXSmall,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            ),
                            // recognizer: TapGestureRecognizer()
                            //   ..onTap = _openTermsAndConditions, // Redirect on tap
                          ),
                          TextSpan(
                            text: " and ",
                            style: TextStyle(
                              color: clr.textColorBlack,
                              fontSize: size.textXSmall,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: "privacy policy",
                            style: TextStyle(
                              color: clr.appPrimaryColor,
                              fontSize: size.textXSmall,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            ),
                            // recognizer: TapGestureRecognizer()
                            //   ..onTap = _openPrivacyPolicy, // Redirect on tap
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              size.s20.kHeight,
              ActionButton<UserSession>(
                title: label(e: en.signUpText, b: bn.signUpText),
                radius: size.s8,
                textColor: clr.whiteColor,
                onCheck: () => validateRegisterData(
                    userNameController.text.trim(),
                    phoneOrEmailController.text.trim(),
                    passwordController.text.trim(),
                    isChecked),
                tapAction: () => registerUser(
                    userNameController.text.trim(),
                    phoneOrEmailController.text.trim(),
                    passwordController.text.trim()),
                onSuccess: (success) => Navigator.of(context).pushNamed(
                    AppRoute.verifyOtpScreen,
                    arguments: VerifyOtpScreenArgs(authDataModel: success)),
              ),
              size.s16.kHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Already have an account?",
                        style: TextStyle(
                            color: clr.textDarkGrey,
                            fontSize: size.textXSmall,
                            fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text: " Sign In",
                            style: TextStyle(
                                color: clr.appPrimaryColor,
                                fontSize: size.textXSmall,
                                fontWeight: FontWeight.w400),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.pushNamed(
                                  context, AppRoute.signInScreen),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              size.s64.kHeight,
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
