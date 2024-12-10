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
  String onboardingTitleText1 = "Improve Learning at your own pace";
  String onboardingTitleText2 = "Evaluate Your Teaching Skills";
  String onboardingTitleText3 = "Share Community Experience";
  String onboardingSubTitleText1 = "Welcome to the e Learning app! This is your one-stop platform for share your learning experiences.";
  String onboardingSubTitleText2 = "Welcome to the company app! This is your one-stop shop for all company news, announcements";
  String onboardingSubTitleText3 = "Welcome to the company app! This is your one-stop shop for all company news, announcements";
  String skipText = "Skip";
  String signInTitleText = "Sign In";
  String signInSubTitleText = "Please login to share your feedbacks and evaluate your teaching skills";
  String nameText = "Name";
  String nameOrEmailText = "Email/Phone Number";
  String passwordText = "Password";
  String confirmPasswordText = "Confirm Password";
  String forgetPasswordText = "Forget Password?";
  String loginText = "Log In";
  String signUpTitleText = "Sign Up";
  String signUpSubTitleText = "Want to evaluate your skills and share your learning feedbacks with everyone? Signup.";
  String signUpText = "Create Account";
  String forgotPasswordTitleText = "Forget Password";
  String forgotPasswordSubTitleText = "Please enter your email address or mobile number to reset your password.";
  String continueText = "Continue";
  String otpTitleText = "Enter OTP";
  String otpSubTitleText = "Enter the OTP code we just sent you on your registered Email/Phone number";
  String resetPasswordTitleText = "Reset Password";

  String resetPasswordSubTitleText = "It was popularised in the 1960s with the release of Letraset sheetscontaining Lorem Ipsum.";


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
  String splashScreenText = "អ៊ី - ការអប់រំ";
  String onboardingTitleText1 = "កែលម្អការរៀនសូត្រតាមល្បឿនផ្ទាល់ខ្លួនរបស់អ្នក។";
  String onboardingTitleText2 = "វាយតម្លៃជំនាញបង្រៀនរបស់អ្នក។";
  String onboardingTitleText3 = "ចែករំលែកបទពិសោធន៍សហគមន៍";
  String onboardingSubTitleText1 = "សូមស្វាគមន៍មកកាន់កម្មវិធី e Learning! នេះគឺជាវេទិកាតែមួយគត់របស់អ្នកសម្រាប់ចែករំលែកបទពិសោធន៍សិក្សារបស់អ្នក។";
  String onboardingSubTitleText2 = "សូមស្វាគមន៍មកកាន់កម្មវិធីរបស់ក្រុមហ៊ុន! នេះ​ជា​ហាង​តែ​មួយ​របស់​អ្នក​សម្រាប់​ដំណឹង​ក្រុមហ៊ុន​ទាំង​អស់​ការ​ប្រកាស​";
  String onboardingSubTitleText3 = "សូមស្វាគមន៍មកកាន់កម្មវិធីរបស់ក្រុមហ៊ុន! នេះ​ជា​ហាង​តែ​មួយ​របស់​អ្នក​សម្រាប់​ដំណឹង​ក្រុមហ៊ុន​ទាំង​អស់​ការ​ប្រកាស";
  String skipText = "រំលង";
  String signInTitleText = "ចូល";
  String signInSubTitleText = "សូមចូលដើម្បីចែករំលែកមតិកែលម្អរបស់អ្នក និងវាយតម្លៃជំនាញបង្រៀនរបស់អ្នក។";
  String nameText = "ឈ្មោះ";
  String nameOrEmailText = "អ៊ីមែល/លេខទូរស័ព្ទ";
  String passwordText = "ពាក្យសម្ងាត់";
  String forgetPasswordText = "ភ្លេចលេខសម្ងាត់?";
  String loginText = "ចូល";
  String signUpTitleText = "ចុះឈ្មោះ";
  String signUpSubTitleText = "ចង់វាយតម្លៃជំនាញរបស់អ្នក និងចែករំលែកមតិកែលម្អការរៀនសូត្ររបស់អ្នកជាមួយអ្នករាល់គ្នា? ចុះឈ្មោះ។";
  String signUpText = "បង្កើតគណនី";
  String forgotPasswordTitleText = "បញ្ចប់ពាក្យសម្ងាត់";
  String forgotPasswordSubTitleText = "សូមបញ្ចូលអាសយដ្ឋានអ៊ីមែលរបស់អ្នកឬលេខទូរស័ព្ទដើម្បីកំណត់ពាក្យសម្ងាត់របស់អ្នកឡើងវិញ។";
  String continueText = "បន្ត";
  String otpTitleText = "បញ្ចូល OTP";
  String otpSubTitleText = "បញ្ចូលកូដ OTP ដែលយើងបានផ្ញើទៅអ៊ីមែល/លេខទូរស័ព្ទដែលបានចុះបញ្ជីរបស់អ្នក";
  String resetPasswordTitleText = "ប្តូរកូដសម្ងាត់";
  String resetPasswordSubTitleText = "វាត្រូវបានពេញនិយមនៅក្នុងទសវត្សរពីរ ១៩៦០ នៅពេលបញ្ចេញសន្លឹក Letraset ដែលមាន Lorem Ipsum។";
  String confirmPasswordText = "បញ្ជាក់កូដសម្ងាត់ ";


}
