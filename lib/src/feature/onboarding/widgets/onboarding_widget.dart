import 'package:co_learning_mobile_app/src/common/constants/app_theme.dart';
import 'package:co_learning_mobile_app/src/common/constants/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingWidget extends StatelessWidget with AppTheme {
  final String image, title, subtitile;
  const OnboardingWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: size.text24Large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          Center(child: SvgPicture.asset(image)),
          size.s20.kHeight,
          Text(
            title,
            style: TextStyle(
                fontSize: size.text32Large,
                color: clr.whiteColor,
                fontWeight: FontWeight.w700,
                fontFamily: StringData.fontFamilyPoppins),
          ),
          size.s20.kHeight,
          Text(
            subtitile,
            style: TextStyle(
                fontSize: size.textXXSmall,
                color: clr.whiteColor,
                fontWeight: FontWeight.w600,
                fontFamily: StringData.fontFamilyPoppins),
          ),        Spacer(),

        ],
      ),
    );
  }
}
