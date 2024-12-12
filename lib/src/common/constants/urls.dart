class ApiCredential {
  const ApiCredential._();

  static String baseUrl = "http://103.209.40.89:7777"; // Development Server
  static String mediaBaseUrl =
      "https://api.edupackbd.com/uploads/"; // Development Server

  static String registerUser = "auth/mobile/user-registration/";
  static String verifyOTP = "otp/verification/verify/";
  static String loginWithMobile = "auth/mobile/password-login/";
  static String verifyPassword = "verify-password";
  static String forgotPassword = "forgot-password-by-mobile";
  static String resetPassword = "reset-password";
  static String changePassword = "change-password";

  static String homeContent = "analytics/dashboard/";
}
