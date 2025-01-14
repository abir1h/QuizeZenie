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
  static String get forgotPasswordIcon => 'forgotPasswordIcon'.png;
  static String get resetPasswordIcon => 'restePasswordIcon'.png;
  static String get groupImage => 'group'.svg;

  static String get imgHomeBG => 'home_bg'.png;

  static String get icHome => 'Home'.svg;
  static String get icHomeFilled => 'Home-1'.svg;
  static String get icBookmark => 'bookmark-1'.svg;
  static String get icBookmarkFilled => 'bookmark'.svg;
  static String get icRecord => 'upload'.svg;
  // static String get icRecord => 'screen_record'.svg;
  static String get icRecordFilled => 'screen_record-1'.svg;
  static String get icProfile => 'profile-1'.svg;
  static String get icProfileFilled => 'profile'.svg;
  static String get icShare=> 'share'.svg;

  static String get icReel => 'FilmReel'.svg;
  static String get icBook => 'BookOpenUser'.svg;
  static String get icBank => 'Bank'.svg;
  static String get changePassword => 'changePassword'.svg;
  static String get myActivity => 'myActivity'.svg;
  static String get myVideos => 'myVideos'.svg;
  static String get accountDetails => 'accountDetails'.svg;
  static String get organistaion => 'organistaion'.svg;
  static String get shield => 'shield'.svg;
  static String get changeLanguage => 'changeLanguage'.svg;
  static String get icDropdown => 'dropdown'.svg;
  static String get icPersons => 'persons'.svg;
  static String get assignment_turned_in => 'assignment_turned_in'.svg;
  static String get folder => 'folder'.svg;
  static String get upload => 'upload'.svg;
  static String get upload_filled => 'upload_filled'.svg;
  static String get chat => 'chat'.svg;
  static String get bookmarkAnim => 'bookmark'.json;
  static String get pageInfo => 'page_info'.svg;
  static String get videoIcon => 'videoIcon'.svg;
  static String get book => 'book'.svg;
  static String get delete => 'delete'.svg;
  static String get placeholder => 'placeholder'.png;

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
