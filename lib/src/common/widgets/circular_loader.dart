import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class CircularLoader extends StatelessWidget with AppTheme {
  final double? loaderSize;
  const CircularLoader({super.key, this.loaderSize});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: loaderSize??size.s32,width: loaderSize??size.s32,child: CircularProgressIndicator(
      color: clr.appPrimaryColor,
      strokeWidth: 2.w,
    ));
  }
}
