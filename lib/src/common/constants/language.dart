mixin Language {
  LanguageEn get en => LanguageEn.instance;
  LanguageBn get bn => LanguageBn.instance;
}

class LanguageEn {
  LanguageEn._();
  static LanguageEn? _instance;
  static LanguageEn get instance => _instance ?? (_instance = LanguageEn._());

  String splashScreenText = "E-Education";
  String homeText = "Home";
  String bookmarkText = "Bookmark";
  String captureText = "Capture";
  String recordText = "Record";
  String profileText = "Profile";
}

class LanguageBn {
  LanguageBn._();
  static LanguageBn? _instance;
  static LanguageBn get instance => _instance ?? (_instance = LanguageBn._());

  String splashScreenText = "ই-লার্নিং";
  String homeText = "ទំព័រដើម";
  String bookmarkText = "បញ្ជីសញ្ញាសម្គាល់";
  String captureText = "ចាប់រូបភាព";
  String recordText = "កំណត់ត្រា";
  String profileText = "ប្រវត្តិរូប";
}
