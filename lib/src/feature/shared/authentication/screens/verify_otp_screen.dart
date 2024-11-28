import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../common/widgets/action_button.dart';
import '../../../../common/widgets/custom_toasty.dart';
import '../../../../common/constants/common_imports.dart';
import '../../../../common/utility/app_label.dart';
import '../../../../common/widgets/app_scaffold.dart';
import '../../../../common/widgets/app_scroll_view.dart';
import '../services/authentication_screen_service.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen>
    with AppTheme, Language, UserAuthenticationService {
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }
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
              Center(child: Image.asset(ImageAssets.forgotPasswordIcon)),
              size.s28.kHeight,
              Center(
                child: Text(
                  label(
                      e: en.otpTitleText,
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
                      e: en.otpSubTitleText,
                      b: bn.otpSubTitleText),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: size.textXXSmall,
                      color: clr.textGray),
                ),
              ),
              size.s20.kHeight,
              Form(
                key: formKey,
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 25.w),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 4,
                    obscureText: false,
                    // obscuringCharacter: '*',
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 52.h,
                        fieldWidth: 52.w,
                        activeFillColor: Colors.white,
                        inactiveColor: clr.greyColor,
                        inactiveFillColor: clr.whiteColor,
                        selectedFillColor: clr.whiteColor,
                        selectedColor: clr.appPrimaryColor,
                        activeColor: clr.appPrimaryColor),
                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    autoDisposeControllers: false,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
                      /*setState(() {
                        isVerifyButtonEnabled = v.length == 4;
                      }),
                      onChanged: (value) => setState(() {
                      isVerifyButtonEnabled = value.length == 4;
                      })*/
                    },
                    beforeTextPaste: (text) => true,
                    pastedTextStyle: TextStyle(
                        fontSize: size.textSmall,
                        color: clr.appPrimaryColor),
                  ),
                ),
              ),size.s16.kHeight,
              size.s16.kHeight,
              size.s16.kHeight,
              ActionButton<dynamic>(
                title: label(e: en.continueText, b: bn.continueText),
                onCheck: () => validateLoginWithPhoneOrEmailData(
                    phoneOrEmailController.text.trim()),
                radius: size.s8,
                textColor: clr.whiteColor,
                tapAction: () => throw UnimplementedError(),
                onSuccess: (success) {},
              ),
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
