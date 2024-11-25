import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visibility_detector/visibility_detector.dart';
export 'package:flutter/services.dart';

class StatusBarTheme extends StatefulWidget {
  final Brightness brightness;
  final Widget child;
  final String uid;
  const StatusBarTheme({super.key,required this.uid, required this.brightness, required this.child});

  @override
  State<StatusBarTheme> createState() => _StatusBarThemeState();
}

class _StatusBarThemeState extends State<StatusBarTheme> {
  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.uid),
      onVisibilityChanged: (visibilityInfo) {
        if(visibilityInfo.visibleFraction == 1){
          if(widget.brightness == Brightness.dark) {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent, statusBarIconBrightness: widget.brightness,));
          }else{
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent, statusBarIconBrightness: widget.brightness,),);
          }
        }
      },
      child: widget.child,
    );
  }
}
