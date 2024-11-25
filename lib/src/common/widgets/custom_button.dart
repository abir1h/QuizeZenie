import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_theme.dart';
import '../constants/strings.dart';

class CustomButton extends StatelessWidget with AppTheme {
  final VoidCallback onTap;
  final Color? bgColor, borderColor;
  final IconData? icon;
  final IconData? trailingIcon;
  final Color? iconColor;
  final String title;
  final Color? textColor;
  final double? textSize;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? radius;
  final FontWeight? fontWeight;
  final bool expanded;
  final List<BoxShadow>? boxShadow;
  const CustomButton(
      {super.key,
      required this.onTap,
      this.bgColor,
      this.borderColor,
      this.icon,
      this.iconColor,
      required this.title,
      this.textColor,
      this.textSize,
      this.horizontalPadding,
      this.verticalPadding,
      this.radius,
      this.fontWeight,
      this.boxShadow,
      this.expanded = false,
      this.trailingIcon});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          onTap.call();
        },
        child: Container(
          // height: 44.w,
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding ?? size.s12,
              vertical: verticalPadding ?? size.s12),
          width: expanded ? double.maxFinite : null,
          decoration: BoxDecoration(
              color: bgColor ?? clr.appPrimaryColor,
              borderRadius: BorderRadius.circular(radius ?? size.s12),
              boxShadow: boxShadow ?? [],
              border: Border.all(
                  color: borderColor ?? Colors.transparent, width: 1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Padding(
                  padding: EdgeInsets.only(right: size.s4),
                  child: Icon(
                    icon,
                    color: iconColor ?? clr.shadeWhiteColor2,
                    size: 16.r,
                  ),
                ),
              Text(
                title,
                style: TextStyle(
                    color: textColor ?? clr.shadeWhiteColor2,
                    fontSize: textSize ?? size.textSmall,
                    fontWeight: fontWeight ?? FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
                textAlign: TextAlign.center,
              ),
              size.s8.kWidth,
              if (trailingIcon != null)
                Icon(
                  trailingIcon,
                  color: iconColor ?? clr.shadeWhiteColor2,
                  size: 16.r,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
