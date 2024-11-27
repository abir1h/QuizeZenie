class ImageAssets {
  const ImageAssets._();

  //:::::::::::::::::: IMAGE SETS ::::::::::::::::::
  static String get icOnBoarding1 => 'onboarding_1'.svg;
  static String get icOnBoarding2 => 'onboarding_2'.svg;
  static String get icOnBoarding3 => 'onboarding_3'.svg;

  static String get imgHomeBG => 'home_bg'.png;

  static String get icHome => 'Home'.svg;
  static String get icHomeFilled => 'Home-1'.svg;
  static String get icBookmark => 'bookmark-1'.svg;
  static String get icBookmarkFilled => 'bookmark'.svg;
  static String get icRecord => 'screen_record'.svg;
  static String get icRecordFilled => 'screen_record-1'.svg;
  static String get icProfile => 'profile-1'.svg;
  static String get icProfileFilled => 'profile'.svg;

/* static String get emptyProfile => 'img'.png;
  static String get animEmpty => 'Animation - 1706009676891'.json;
  static String get emptyAnimation => 'empty'.json;
  static String get passwordAnimation => 'password'.json;*/
}

extension on String {
  String get png => 'assets/images/$this.png';
  String get jpg => 'assets/images/$this.jpg';
  String get svg => 'assets/images/$this.svg';
  String get json => 'assets/images/$this.json';
}
