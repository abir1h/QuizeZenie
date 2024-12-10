import 'package:co_learning_mobile_app/src/common/constants/app_theme.dart';
import 'package:co_learning_mobile_app/src/common/constants/common_imports.dart';
import 'package:co_learning_mobile_app/src/common/utility/app_label.dart';
import 'package:flutter/material.dart';
import '../widgets/toggle_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AppTheme, Language {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          label(e: en.myProfileText, b: bn.myProfileText),
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: size.textXMedium, color: clr.blackColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),  // Added padding for spacing
            child: AnimatedToggle(
              values: ['English', 'Khmer'],
              onToggleCallback: (value) {
                App.setAppLanguage(value).then((value) {
                  if (mounted) {
                    setState(() {});
                  }
                 /* AppEventsNotifier.notify(EventAction.bottomNavAllScreen);
                  AppEventsNotifier.notify(EventAction.bottomNavBar);
                  AppEventsNotifier.notify(EventAction.graphChart);*/
                });
              },
              buttonColor:clr.selectedToggleColor,
              backgroundColor: clr.inactiveToggleColor,
              textColor: const Color(0xFFFFFFFF),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Your profile content goes here
            Text('Profile Content', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

