class ApiCredential {
  const ApiCredential._();

  static String baseUrl = "http://118.179.7.90:7777"; // Development Server
  // static String baseUrl = "http://103.209.40.89:7778"; // Development Server
  static String mediaBaseUrl =
      "https://api.edupackbd.com/uploads/"; // Development Server

  static String registerUser = "auth/mobile/user-registration/";
  static String verifyOTP = "otp/verification/verify/";
  static String loginWithMobile = "auth/mobile/password-login/";
  static String verifyPassword = "verify-password";
  static String forgotPassword = "auth/mobile/forgot-password-request/";
  static String resetPassword = "auth/mobile/forgot-password-verify/";
  static String changePassword = "user-profile/change-password/";
  static String bookmarkList = "user-bookmarks/user/bookmarks/";
  static String categoryWiseVideo = "file/folder/";
  static String userProfile = "user-profile/current/";
  static String updateProfile = "user-profile/";
  static String getFeedBackList = "feedback-forms/mobile/list/";
  static String getFolderList = "folder/";

  static String homeContent = "analytics/dashboard/";
  static String videoDetails = "file/";
  static String videoComments = "comments/video-comments/";
  static String fileUpload = "file/";
  static String doComment = "comments/";
  static String feedbackScore = "feedback-scorings/";
  static String createChapter = "chapters/";
}
