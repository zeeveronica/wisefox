class Urls {
  // Base URL for the API
  static const String BASE_URL = "https://api.wisefox.uk/api";
  static const String my_tutor =
      "$BASE_URL/client/Student/student-allocated-tutors";
  static const String tutor_count = "$BASE_URL/client/tutor/tutor-drop-down";
  static const String mycount = "$BASE_URL/client/Student/student-tutor-count";
  static const String students = "$BASE_URL/client/Student/detail-list-Student";
  static const String lessons = "$BASE_URL/client/Student/student-lesson";
  static const String overviewcount =
      "$BASE_URL/client/Student/student-profile-count";
  static const String filesharing =
      "$BASE_URL/communication/FileShare/file-recieved-list";
  static const String demoLessons =
      "$BASE_URL/client/demolessons/list-demolesson";
  static const String sentedfiles =
      "$BASE_URL/communication/FileShare/file-send-list";
  static const String lessonDetails =
      "$BASE_URL/lessons/lessons/lesson-details";

  //post
  static const String filesharepost =
      "$BASE_URL/communication/FileShare/send-file";
  static const String cancellesson = "$BASE_URL/lessons/lessons/cancel-lesson";

  //delete
  static const String deletefile =
      "$BASE_URL/communication/FileShare/file-share-delete";
}
