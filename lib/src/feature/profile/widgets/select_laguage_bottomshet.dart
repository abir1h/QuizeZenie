import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/constants/app_theme.dart';
import '../../../common/service/notifier/app_events_notifier.dart';
import '../../../common/utility/app_label.dart';

class SelectLanguageBottomSheet extends StatefulWidget {
  final BuildContext context;
  const SelectLanguageBottomSheet({super.key, required this.context});

  @override
  SelectLanguageBottomSheetState createState() =>
      SelectLanguageBottomSheetState();
}

class SelectLanguageBottomSheetState extends State<SelectLanguageBottomSheet> with AppTheme {
  AppLanguage _selectedLanguage = AppLabel.currentAppLanguage; // Default language

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  // Load the selected language from AppLabel
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
                padding: EdgeInsets.symmetric(horizontal: size.s16, vertical: size.s12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        label(e: "Change Language", b: "ផ្លាស់ប្តូរភាសា"),
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
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'English',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    leading: Radio<String>(
                      value: 'English',
                      groupValue: _selectedLanguage == AppLanguage.english ? 'English' : 'ខ្មែរ (Khmer)',
                      onChanged: (String? value) {
                        if (value == 'English') {
                          AppLabel.setAppLanguage(1).then((_) {
                            setState(() {
                              _selectedLanguage = AppLanguage.english;
                            });
                            AppEventsNotifier.notify(EventAction.bottomNavAllScreen);
                            AppEventsNotifier.notify(EventAction.bottomNavBar);
                            AppEventsNotifier.notify(EventAction.graphChart);
                          });
                        }
                      },
                    ),
                  ),
                  Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'ខ្មែរ (Khmer)',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    leading: Radio<String>(
                      value: 'ខ្មែរ (Khmer)',
                      groupValue: _selectedLanguage == AppLanguage.bangla ? 'ខ្មែរ (Khmer)' : 'English', // Fix comparison here
                      onChanged: (String? value) {
                        if (value == 'ខ្មែរ (Khmer)') {
                          AppLabel.setAppLanguage(0).then((_) {
                            setState(() {
                              _selectedLanguage = AppLanguage.bangla;
                            });
                            // Notify app-wide events after language change
                            AppEventsNotifier.notify(EventAction.bottomNavAllScreen);
                            AppEventsNotifier.notify(EventAction.bottomNavBar);
                            AppEventsNotifier.notify(EventAction.graphChart);
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              size.s12.kHeight,
            ],
          ),
        ),
      ),
    );
  }
}
