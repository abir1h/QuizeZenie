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

  Color get iconicBlue => HexColor("006BFF");
  Color get lightPurpleColor => HexColor("F0EFFF");
  Color get backgroundColor => HexColor("EEF3F6");
  Color get scaffoldBackgroundColor2 => HexColor("ECFBF7");
  Color get secondaryBackgroundColor => HexColor("FFFEFE");
  Color get strokeColorBlue => HexColor("7CB1E2");
  Color get darkGreen => HexColor("004D43");
  Color get bottomBarColor => HexColor("F0F8FF");
  Color get bgColor => HexColor("EEF3F6");
  Color get textGrey => HexColor("4a4b65");
  Color get dottedBorderColor => HexColor("E8E8E8");
  Color get inactiveGray => HexColor("4D4D4D");
  Color get iconGrey => HexColor("D9D9D9");
  Color get iconGrayDeepColor => HexColor("9D9CA4");
  Color get textFieldStrokeColor => HexColor("E8E8E8");
  Color get textFieldFilllor => HexColor("F1F1F1");
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
  Color get textColorGrey => HexColor("535252");
  Color get dividerColorBlue => HexColor("5897D2");
  Color get shadowColor => HexColor("3C404326");
  Color get secondaryBackgroundLight => const Color(0xFFD8D8ED);
  Color get dividerColorGrey => HexColor("7E7E7E");
  Color get borderColor => HexColor("C4D8EC");
  Color get textColorGrey2 => HexColor("535252");
  Color get timeLineCircleColor => HexColor("E7FFF0");
  Color get checkColor => HexColor("42996F");
  Color get progressColorGreen => HexColor("67E573");
  Color get commentColor => HexColor("FFF4E2");
  Color get greyIconMentor => HexColor("656565");
  Color get upComing => HexColor("FFE6A7");
  Color get onCompleted => HexColor("347928");
  Color get bgAmberLight => HexColor("F4D1BD");
  Color get dividerColor => HexColor("BAC6D1");

  Color get grad1 => HexColor("C0F2C6");
  Color get grad2 => HexColor("FFF2BD");
  Color get grad3 => HexColor("C8FBDC");
  Color get grad4 => HexColor("E2F2FF");
  Color get grad5 => HexColor("E1EBFF");
  Color get grad6 => HexColor("FFEEE0");
  Color get grad7 => HexColor("F99D68");
  Color get grad8 => HexColor("DDA88A");
  Color get whiteColor => HexColor("FFFFFF");
  Color get shadeWhiteColor => HexColor("FDFDFD");
  Color get shadeWhiteColor2 => HexColor("FEFFFF");
  Color get textColor54 => HexColor("555454");
  Color get blackColor => HexColor("000000");
  Color get whiteShade => HexColor("FAFAFA");
  Color get greyColor => HexColor("B6B6B6");
  Color get textGreyDark => HexColor("595959");
  Color get greyBorderColor => HexColor("DFDFDF");
  Color get selectedRoleBgColor => HexColor("F5FAFF");
  Color get controlBlackHint => const Color(0xFFA6A6A6);
  Color get iconColorBlack => HexColor("1C1B1F");
  Color get controlBgRed => const Color(0xFFF86868);
  Color get purpleQuizContainer => const Color(0xff6845F6);
  Color get primaryTextColor => HexColor("202020");
  Color get secondaryTextColor => HexColor("3D3D3D");
  Color get textColorAppleBlack => HexColor("1D1D1F");
  Color get textColorBlack => HexColor("202020");
  Color get textColorGray => HexColor("757575");
  Color get placeHolderTextColorGray => HexColor("9F9F9F");
  Color get blackText => HexColor("222222");
  Color get warningRedText => HexColor("FE7878");
  Color get errorRedText => HexColor("85050F");
  Color get iconsBgColor => HexColor("FEEAE9");
  Color get iconsBgColor2 => HexColor("4B8CCA");
  Color get shadowColorGrey => HexColor("00000029");
  Color get verticalDividerColor => HexColor("10375C");
  Color get gradDetails1 => HexColor("10375C");
  Color get gradDetails2 => HexColor("001B35");
  Color get timeRedColor => HexColor("FF6A7E");
  Color get containerTopBorderColor => HexColor("93BDE4");
  Color get answerBackgroundColor => HexColor("E8F4FF");
  Color get attachmentBackgroundColor => HexColor("F8FBFF");
  Color get attachmentBorderColor => HexColor("5E9FDC");
  Color get blueContainerBackground => HexColor("FAFCFF");
  Color get greenContainerBackground => HexColor("DFFFEC");
  Color get redContainerBackground => HexColor("FFDAD9");
  Color get chipBackground => HexColor("F4F6FF");
  Color get chipBorder => HexColor("CCD5FF");
  Color get reviewContainerBackground => HexColor("FFF2DA");
  Color get lightBlueShade => HexColor("F4F6FF");
  Color get lightAmber => HexColor("F0d2c2");
  Color get bgGrey => HexColor("F8F9FF");
  Color get liveClassColor => HexColor("3384F7");
  Color get videoColor => HexColor("F26F6C");
  Color get quizColor => HexColor("F6C754");
  Color get scriptsColor => HexColor("4FB8DA");
  Color get assignmentColor => HexColor("85C658");
  Color get amberBorder => HexColor("F2D5CA");
  Color get textBlackLight => const Color(0xFF545454);

  ///Mentor Colors
  Color get mentorGrad1 => HexColor("FEECE2");
  Color get mentorGrad2 => HexColor("FFBE98");
  Color get mentorGrad3 => HexColor("AAD4D0");
  Color get mentorGrad4 => HexColor("DEFEF6");
  Color get mentorGrad5 => HexColor("DAF4FF");
  Color get mentorGrad6 => HexColor("DAF4FF");
  Color get mentorGrad7 => HexColor("FFEDFF");
  Color get mentorGrad8 => HexColor("FFEDFF");
  Color get mentorGrad9 => HexColor("69D1FF");
  Color get mentorGrad10 => HexColor("F6D2FF");
  Color get mentorTextColorAssignCourse => HexColor("773D00");
  Color get mentorTextColorLiveClass => HexColor("003C43");
  Color get mentorTextColorAssignStudents => HexColor("050C9C");
  Color get mentorTextColorOngoingAssignment => HexColor("6B0484");
  Color get mentorTextGray => HexColor("4D4D4D");
  Color get amberColor => HexColor("EB8317");
  Color get cyanColor => HexColor("003237");
  Color get darkBlue => HexColor("000461");
  Color get statusColorGreen => HexColor("0F6000");
  Color get iconColorBlue => HexColor("006BFF");
  Color get iconColorDeepBlue => HexColor("076DAB");
  Color get marked => HexColor("F5FFF3");
  Color get submitted => HexColor("FFFBF6");
  Color get notSubmitted => HexColor("F8D7DA");
  Color get markBg => HexColor("F4F6FF");
  Color get priceButtonColorBgGreen => HexColor("1AAB54");
  Color get discountPriceTextColor => HexColor("C0C1C5");
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
  double get textX28Large => 28.sp;
  double get textXLarge => 26.sp;
  double get textLarge => 22.sp;
  double get textXMedium => 20.sp;
  double get textMedium => 18.sp;
  double get textSmall => 16.sp;
  double get textXSmall => 14.sp;
  double get textXXSmall => 12.sp;
  double get textXXXSmall => 10.sp;

  double get s1 => 1.w;
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
