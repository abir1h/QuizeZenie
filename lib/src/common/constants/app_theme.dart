import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utility/color_tools.dart';

mixin AppTheme {
  ThemeColor get clr => ThemeColor.instance;
  ThemeSize get size => ThemeSize.instance;
}

class ThemeColor {
  ThemeColor._();
  static ThemeColor? _instance;
  static ThemeColor get instance => _instance ?? (_instance = ThemeColor._());

  Color get appPrimaryColor => HexColor("175CD3");
  Color get backgroundColor => HexColor("EEF3F6");

  Color get grayColor => HexColor("9DA0A7");
  Color get iconGrey => HexColor("D9D9D9");
  Color get iconBorderColor => HexColor("7CCA52");

  Color get bgColorWhite => HexColor("F2F1F9");
  Color get cardStrokeColor => HexColor("4E4E4E");

  Color get iconColorGrey => HexColor("929292");
  Color get textColorGrey => HexColor("B0B0B0");
  Color get textColorGrey2 => HexColor("5F5F5F");
  Color get textGrayColor => HexColor("757575");
  Color get imgBorderColor => HexColor("9CABC2");
  Color get dotColor => HexColor("D5D7DA");
  Color get disableButtonGray => HexColor("8B919A");

  Color get scaffoldBackgroundColor2 => HexColor("ECFBF7");
  Color get onBoardBgColor1 => HexColor("EA8F6E");
  Color get onBoardBgColor2 => HexColor("E8A635");
  Color get onBoardBgColor3 => HexColor("435FE5");
  Color get textGray => HexColor("61677D");
  Color get greyBorder => HexColor("E9EAEB");
  Color get greyVideoTitle => HexColor("535862");
  Color get removeBgCardColor => HexColor("FEE4E2");
  Color get removeBgCardColorText => HexColor("B42318");

  Color get backgroundColor1 => HexColor("EEF3F6");
  Color get secondaryBackgroundColor => HexColor("FFFEFE");
  Color get inactiveGray => HexColor("4D4D4D");
  Color get iconGrayDeepColor => HexColor("9D9CA4");
  Color get textFieldStrokeColor => HexColor("E8E8E8");
  Color get hintTextColor => HexColor("909090");
  Color get textFieldTextColor => HexColor("14151A");
  Color get buttonDisabledColor => HexColor("6B7380");
  Color get greenColor => HexColor("16AA51");
  Color get dropShadowColor => HexColor("0000001A");
  Color get rippleColor => HexColor("16AA5133");
  Color get greenRipple => HexColor("2DBA65");
  Color get lightBlueColor => HexColor("1670C6");
  Color get darkBlueColor => HexColor("0B365F");
  Color get ratingColor => HexColor("FFA500");
  Color get dividerColorBlue => HexColor("5897D2");
  Color get shadowColor => HexColor("3C404326");
  Color get secondaryBackgroundLight => const Color(0xFFD8D8ED);
  Color get dividerColorGrey => HexColor("7E7E7E");
  Color get borderColor => HexColor("C4D8EC");
  Color get timeLineCircleColor => HexColor("E7FFF0");
  Color get checkColor => HexColor("42996F");
  Color get dividerColor => HexColor("E0E5EC");
  Color get whiteColor => HexColor("FFFFFF");
  Color get shadeWhiteColor2 => HexColor("FEFFFF");
  Color get blackColor => HexColor("000000");
  Color get greyColor => HexColor("B6B6B6");
  Color get iconColorBlack => HexColor("1C1B1F");
  Color get textColorBlack => HexColor("202020");
  Color get placeHolderTextColorGray => HexColor("9F9F9F");
  Color get blackText => HexColor("222222");
  Color get textDarkGrey => HexColor("3B4054");
  Color get textLightGrey => HexColor("7A7E87");
  Color get textBlackLight => const Color(0xFF545454);

  Color get textFieldFilllor => HexColor("F5F9FE");
  Color get forgotPasswordTextColor => HexColor("7C8BA0");
  Color get selectedToggleColor => HexColor("566E9C");
  Color get inactiveToggleColor => HexColor("F5F5F5");
  Color get profileCardTextColor => HexColor("252B37");
  Color get lightGray => HexColor("A4A7AE");
  Color get iconColorGray => HexColor("717680");
  Color get amberColor => HexColor("FFAD3A");
  Color get darkGreyHeaderTextColor => HexColor("717680");
  Color get blueText => HexColor("026AA2");
  Color get bgGood => HexColor("F5FBFF");
  Color get bgImprove => HexColor("FFFCF5");
  Color get improveText => HexColor("FFB901");

}

// final localStorage = Get.find<LocalStorageServiceWithGetX>();
//
// double sizeValue = localStorage.getBooleanValue(StringData.textSizeKey) != null
//     ? localStorage.getBooleanValue(StringData.textSizeKey) == true
//         ? 6.0
//         : 0.0
//     : 0.0;

class ThemeSize {
  ThemeSize._();
  static ThemeSize? _instance;
  static ThemeSize get instance => _instance ?? (_instance = ThemeSize._());
  double get textXXXLarge => 44.sp;
  double get textXXLarge => 36.sp;
  double get text32Large => 32.sp;
  double get textX28Large => 28.sp;
  double get textXLarge => 26.sp;
  double get text24Large => 24.sp;
  double get textLarge => 22.sp;
  double get textXMedium => 20.sp;
  double get textMedium => 18.sp;
  double get textSmall => 16.sp;
  double get textXSmall => 14.sp;
  double get textXXSmall => 12.sp;
  double get textXXXSmall => 10.sp;

  double get s1 => 1.w;
  double get s2 => 2.w;
  double get s4 => 4.w;
  double get s8 => 8.w;
  double get s10 => 10.w;
  double get s12 => 12.w;
  double get s16 => 16.w;
  double get s20 => 20.w;
  double get s24 => 24.w;
  double get s28 => 28.w;
  double get s32 => 32.w;
  double get s42 => 42.w;
  double get s48 => 48.w;
  double get s56 => 56.w;
  double get s64 => 64.w;
}

extension DoubleExtension on double {
  Widget get kHeight => SizedBox(
        height: toDouble(),
      );

  Widget get kWidth => SizedBox(
        width: toDouble(),
      );
}
