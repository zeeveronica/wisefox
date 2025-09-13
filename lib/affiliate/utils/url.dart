class Url {
  // static const String BASEURL = 'https://api.wisefox.uk/api';
  static const String BASEURL = 'http://192.168.1.2:8000/api';
  static const String MyStudents =
      ("$BASEURL/tutor/my_students/list-my-students");
  static const String login = ("$BASEURL/auth/login");
  static const String Upcomming =
      ("$BASEURL/tutor/lesson-listing/tutor-lesson-list");
  static const String DashboardCount =
      ("$BASEURL/tutor/my_students/dashboard-count-list");
  static const String Upcommings =
      ("$BASEURL/tutor/lesson-listing/tutor-lesson-list");

  static const String Cancell =
      ("$BASEURL/tutor/lesson-listing/tutor-lesson-list?type=cancelled");
  static const String Demolesson =
      ('$BASEURL/tutor/demolesson-listing/tutor-demolesson-list');
  static const String allocationcount =
      ('$BASEURL/tutor/my_students/allocation-count');
  static const String Students = ('$BASEURL/user/users/retrieve-user-info');
  static const String Lessonlist =
      ('$BASEURL/tutor/my_students/allocation-count');
  static const String sharefile =
      ('$BASEURL/communication/FileShare/send-file');
      static const String recievedfile =
      ('$BASEURL/communication/FileShare/file-recieved-list') ;
       static const String Lessondetails =
      ('$BASEURL/lessons/lessons/lesson-details');
      static const String classdetails =
      ('$BASEURL/tutor/lesson-listing/tutor-lesson-details');
            static const String dropdown =
            
      ('$BASEURL/client/Student/student-drop-down');
             static const String sendfiles =
      ('$BASEURL/communication/FileShare/file-send-list');
            static const String delete =
      ('$BASEURL/communication/FileShare/file-share-delete');
       static const String cancellesson =
      ('$BASEURL/lessons/lessons/cancel-lesson');
       static const String logout =
      ('$BASEURL/auth/logout');
        static const String Studentallocation =
      ('$BASEURL/tutor/my_students/tutor-allocation-list');

}

//businness logic model bloc