import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/constants/app_theme.dart';
import '../../../common/service/notifier/app_events_notifier.dart';
import '../../../common/utility/app_label.dart';

class MoreBottomSheet extends StatefulWidget {
  final BuildContext context;
  const MoreBottomSheet({super.key, required this.context});

  @override
  MoreBottomSheetState createState() =>
      MoreBottomSheetState();
}

class MoreBottomSheetState extends State<MoreBottomSheet> with AppTheme {
  AppLanguage _selectedLanguage = AppLabel.currentAppLanguage; // Default language

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  _loadSelectedLanguage() async {
    setState(() {
      _selectedLanguage = AppLabel.currentAppLanguage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            color: clr.whiteColor,
          ),
          width: 1.sw,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.s16, vertical: size.s4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        label(e: "More", b: "ច្រើនទៀត"),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: size.textSmall,
                          color: clr.textColorBlack,
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: ()=>Navigator.pop(context),
                        child: Icon(Icons.clear)),
                  ],
                ),
              ),
              Divider(height: size.s2, color: clr.greyBorder),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: size.s16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,

                      title: Text(
                        label(e: "Edit Video", b: "កែសម្រួលវីដេអូ"),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading:Icon(Icons.border_color_outlined,color: clr.appPrimaryColor,size: size.s24,)
                    ),
                    kDash,
                    ListTile(
                        contentPadding: EdgeInsets.zero,

                        title: Text(
                          label(e: "Delete video", b: "លុបវីដេអូ"),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        leading:Icon(Icons.delete_outline_rounded,color: clr.deleteColor,size: size.s24,)
                    ),
                  ],
                ),
              ),
              size.s12.kHeight,
            ],
          ),
        ),
      ),
    );
  }
}
