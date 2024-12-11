class ImageAssets {
  const ImageAssets._();

  //:::::::::::::::::: IMAGE SETS ::::::::::::::::::
  static String get icOnBoarding1 => 'onboarding_1'.svg;
  static String get icOnBoarding2 => 'onboarding_2'.svg;
  static String get icOnBoarding3 => 'onboarding_3'.svg;
  static String get signInIcon => 'signInIcon'.png;
  static String get icFacebook => '_Facebook'.svg;
  static String get icGoogle => '_Google'.svg;
  static String get signUpIcon => 'signUpIcon'.png;
  static String get imgVideoObject => 'video-object'.png;
  static String get icFlipCamera => 'flip_camera'.svg;


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
