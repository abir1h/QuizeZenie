class ApiCredential {
  const ApiCredential._();

  static String baseUrl = "https://api.edupackbd.com"; // Development Server
  static String mediaBaseUrl =
      "https://api.edupackbd.com/uploads/"; // Development Server

  static String organizationList = "/organizations";
  static String loginWithMobile = "login-with-mobile";
  static String verifyOTP = "verify-otp";
  static String verifyPassword = "verify-password";
  static String registerUser = "register-user";
  static String forgotPassword = "forgot-password-by-mobile";
  static String resetPassword = "reset-password";
  static String changePassword = "change-password";
  static String getStudentProfile = "student-profile";
  static String updateProfile = "update-profile";
  static String getPaymentList = "my-payment-list";
  static String getPurchaseList = "my-purchase-list";
  static String getClassSchedules = "class-schedules";
  static String getLoginDevices = "get-login-devices";
  static String logoutByDevice = "logout-by-device";
  static String getContentDetails = "get-content-details";
  static String getRatingList = "rating-list";
  static String startQuiz = "start-quiz";
  static String submitQuiz = "submit-quiz";
  static String submitWrittenQuiz = "submit-written-answer";
  static String getAssignmentDetails = "assignment-details";
  static String submitAssignment = "submit-assignment";
  static String getDashboardData = "student-dashboard";
  static String getDashboardChartData = "learning-graph";
  static String getDashboardLearningActivityData = "learning-activities";
  static String markScriptCompleted = "mark-script-completed";
  static String certificateList = "certificates";
  static String generateCertificate = "generate-certificates";
  static String studentAssignmentList = "student-assignment-list";
  static String studentLiveClassList = "live-class-list";
  static String coursePayment = "purchase-course";

  ////Mentor
  static String mentorDashboardDetails = "mentor/dashboard";
  static String mentorActivities = "mentor/activities?days=7";
  static String mentorCourseList = "mentor/course-list";
  static String liveClassList = "mentor/live-class-list";
  static String studentList = "mentor/student-list";
  static String assignmentStudentList = "mentor/all-students-assignment";
  static String createLiveClass = "mentor/create-live-class-schedule";
  static String liveClassDetails = "mentor/live-class-details";
  static String editLiveClass = "mentor/update-live-class-schedule";
  static String startLiveClass = "mentor/start-live-class";
  static String mentorAssignmentList = "mentor/assignment-list";
  static String mentorCurriculumList = "mentor/course-outlines?course_id=";
  static String mentorCurriculumContentDetails =
      "mentor/contents-details?content_id=";
  static String mentorCurriculumQuizDetails = "mentor/quiz-details?content_id=";
  static String getMentorProfile = "mentor/my-profile";
  static String mentorUpdateProfile = "mentor/update-profile";
  static String createAssignment = "mentor/create-assignment";
  static String editAssignment = "mentor/update-assignment";
  static String courseFilter = "mentor/course-list-for-filter";
  static String getAssingedStudents = "mentor/my-student-list";
  static String getMentorAssignmentDetails = "mentor/assignments-details";
  static String getStudentWorkAssignmentDetails = "mentor/submission-details";
  static String markSubmit = "mentor/mark-assignment";
}
