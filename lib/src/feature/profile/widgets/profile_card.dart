import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/constants/app_theme.dart';

class ProfileCard extends StatelessWidget with AppTheme {
  final VoidCallback onTap;
  final String iconName, title;
  final bool? isLast;
  const ProfileCard(
      {super.key,
      required this.onTap,
      required this.iconName,
      required this.title,
      this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            color: clr.whiteColor,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: Row(
              children: [
                Flexible(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        iconName,
                        height: size.s32,
                        width: size.s28,
                      ),
                      size.s8.kWidth,
                      Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: size.textXSmall,
                            color: clr.profileCardTextColor),
                      )
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: clr.iconColorGray,
                )
              ],
            ),
          ),
        ),
        if (!isLast!)
          Divider(
            height: 1,
            color: clr.greyBorder,
          )
      ],
    );
  }
}
