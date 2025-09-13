class Urls {
  // Base URL for the API
  static const String BASE_URL = "https://api.wisefox.uk/api";
  static const String my_tutor = "$BASE_URL/client/tutor/list-tutor";
  static const String tutor_count = "$BASE_URL/settings/skill/skill-drodown";
  static const String subject_list =
      "$BASE_URL/settings/subject/subject-dropdown";
  static const String mycount = "$BASE_URL/client/tutor/tutor-overview-count";
  static const String studentcount =
      "$BASE_URL/clientmanagemnet/Mystudents/client-dashboard-count";
  static const String clients =
      "$BASE_URL/clientmanagemnet/Profile/profile-list";

  static const String lessons =
      "$BASE_URL/client/Client/client-scheduledlesson";
  static const String clientoverviewcount =
      "$BASE_URL/clientmanagemnet/Allocation/allocation-list";
  static const String studentoverviewcount =
      "$BASE_URL/client/Student/student-profile-count";
  static const String sharefile =
      ('$BASE_URL/communication/FileShare/send-file');
  static const String recievedfile =
      ('$BASE_URL/communication/FileShare/file-recieved-list');
  static const String sendfiles =
      ('$BASE_URL/communication/FileShare/file-send-list');
  static const String demoLessons =
      "$BASE_URL/client/demolessons/list-demolesson";
  static const String studentlist =
      "$BASE_URL/client/Client/client-student-list";
  static const String lessonDetails =
      "$BASE_URL/lessons/lessons/lesson-details";
  static const String dashboardData =
      "$BASE_URL/clientmanagemnet/Client/client-overview";
  static const String exam_board_list =
      "$BASE_URL/settings/exam-board/exam-board-drodown";
  static const String students = "$BASE_URL/client/Student/detail-list-Student";
  static const String studentlesson = "$BASE_URL/client/Student/student-lesson";
  static const String country_list =
      "$BASE_URL/settings/Country/country-dropdown";
  static const String tutordropdown = "$BASE_URL/client/tutor/tutor-drop-down";

  //post
  static const String filesharepost =
      "$BASE_URL/communication/FileShare/send-file";
  static const String cancellesson = "$BASE_URL/lessons/lessons/cancel-lesson";
  static const String studentAdmissionPost =
      "$BASE_URL/client/Student/create-or-update-student";
  static const String logout = "$BASE_URL/auth/logout";
  static const String isActive =
      "$BASE_URL/clientmanagemnet/Mystudents/student-active-inactive";

  //delete
  static const String deletefile =
      "$BASE_URL/communication/FileShare/file-share-delete";
}
