
import 'package:co_learning_mobile_app/src/common/service/notifier/app_events_notifier.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/common_imports.dart';
import '../../../common/utility/app_label.dart';
import '../../../common/widgets/action_button.dart';
import '../../../common/widgets/app_scaffold.dart';
import '../../../common/widgets/custom_dropdown_widget.dart';
import '../../../common/widgets/custom_toasty.dart';
import '../services/profile_screen_service.dart';
import '../../../common/routes/app_route_args.dart';

class AccountDetailsScreen extends StatefulWidget {
  final Object? arguments;
  const AccountDetailsScreen({super.key, this.arguments})
      : assert(arguments != null && arguments is AccountDetailsScreenArgs);
  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen>
    with Language, AppTheme, ProfileScreenService, AppEventsNotifier {
  @override
  void initState() {
    screenArgs = widget.arguments as AccountDetailsScreenArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadTextField(widget.arguments as AccountDetailsScreenArgs);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        bgColor: clr.backgroundColor1,
        title: label(e: "Account Details", b: "ព័ត៌មានលម្អិតគណនី"),
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.all(size.s16),
                margin: EdgeInsets.only(top: size.s2),
                decoration: BoxDecoration(color: clr.whiteColor),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label(e: "Account Details", b: "ព័ត៌មានលម្អិតគណនី"),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: size.textSmall,
                            color: clr.textColorGrey2),
                      ),
                      size.s12.kHeight,
                      ProfileTextField(
                        controller: fullNameController,
                        hint: label(
                            e: "User full name", b: "ឈ្មោះពេញអ្នកប្រើប្រាស់"),
                        label: label(e: "Full name", b: "ឈ្មោះពេញ"),
                      ),
                      ProfileTextField(
                        controller: designationController,
                        hint: label(e: "Designation", b: "ការកំណត់"),
                        label: label(e: "Designation", b: "ការកំណត់"),
                      ),
                      ProfileTextField(
                        controller: phoneController,
                        hint: label(e: "Contact Number", b: "លេខទំនាក់ទំនង"),
                        label: label(e: "Contact Number", b: "លេខទំនាក់ទំនង"),
                      ),
                      ProfileTextField(
                        controller: emailController,
                        hint: label(e: "Email Address", b: "អាសយដ្ឋានអ៊ីមែល"),
                        label: label(e: "Email Address", b: "អាសយដ្ឋានអ៊ីមែល"),
                      ),
                      CustomDropDown(
                          onLoadData: loadFeedBack,
                          onSelected: (status) {},
                          hintText: label(
                              e: "School or Collage name",
                              b: "ឈ្មោះសាលា ឬ Collage"),
                          onGenerateTitle: (x) => x!.title),
                      size.s20.kHeight,
                      CustomDropDown(
                          onLoadData: loadFeedBack,
                          onSelected: (status) {},
                          hintText:
                              label(e: "Select Country", b: "ជ្រើសរើសប្រទេស"),
                          onGenerateTitle: (x) => x!.title),
                      size.s20.kHeight,
                      CustomDropDown(
                          onLoadData: loadFeedBack,
                          onSelected: (status) {},
                          hintText: label(e: "Select State", b: "ជ្រើសរើសរដ្ឋ"),
                          onGenerateTitle: (x) => x!.title),
                      size.s20.kHeight,
                      CustomDropDown(
                          onLoadData: loadFeedBack,
                          onSelected: (status) {},
                          hintText:
                              label(e: "Select City", b: "ជ្រើសរើសទីក្រុង"),
                          onGenerateTitle: (x) => x!.title),
                      size.s20.kHeight,
                      ProfileTextField(
                        controller: postalCodeController,
                        hint: label(e: "Postal Code", b: "លេខកូដប្រៃសណីយ៍"),
                        label: label(e: "Postal Code", b: "លេខកូដប្រៃសណីយ៍"),
                      ),
                      ProfileTextField(
                        controller: permanentAddressController,
                        maxLines: 3,
                        hint: label(
                            e: "Present Address", b: "អាសយដ្ឋានបច្ចុប្បន្ន"),
                        label: label(
                            e: "Present Address", b: "អាសយដ្ឋានបច្ចុប្បន្ន"),
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
                    tapAction: () => updateProfile(),
                    onSuccess: (success) {
                      screenArgs!.onAddLiveClass.call();
                      Navigator.pop(context);
                    },
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
  void onEventReceived(EventAction action) {
    if (action == EventAction.profileScreen) {
      if (mounted) {
        setState(() {});
      }
    }
  }
}

class ProfileTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint, label;
  final int? maxLines;
  final bool? obscureText;

  const ProfileTextField(
      {super.key,
      required this.controller,
      required this.hint,
      required this.label,
      this.maxLines = 1,
      this.obscureText});

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField>
    with AppTheme, Language {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText ?? false;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: size.s20),
      child: TextField(
        controller: widget.controller,
        maxLines: widget.maxLines,
        obscureText: _obscureText,
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: size.textXSmall,
            color: clr.blackColor),
        decoration: InputDecoration(
            label: Text(widget.label,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: size.textXXSmall,
                    color: clr.iconColorGray)),
            hintText: widget.label,
            suffixIcon: widget.obscureText == true
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: clr.placeHolderTextColorGray,
                    ),
                    onPressed: _toggleObscureText,
                  )
                : null,
            hintStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: size.textXSmall,
                color: clr.blackColor),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.s4),
                borderSide: BorderSide(color: clr.greyBorder)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.s4),
                borderSide: BorderSide(color: clr.greyBorder)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.s4),
                borderSide: BorderSide(color: clr.greyBorder))),
      ),
    );
  }
}
