mixin Language {
  LanguageEn get en => LanguageEn.instance;
  LanguageBn get bn => LanguageBn.instance;
}

class LanguageEn {
  LanguageEn._();
  static LanguageEn? _instance;
  static LanguageEn get instance => _instance ?? (_instance = LanguageEn._());



  String splashScreenText = "E-Education";

}

class LanguageBn {
  LanguageBn._();
  static LanguageBn? _instance;
  static LanguageBn get instance => _instance ?? (_instance = LanguageBn._());

  String splashScreenText = "ই-লার্নিং";


}
