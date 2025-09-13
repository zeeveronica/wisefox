// class LessonDetails {
//   final bool status;
//   final int statusCode;
//   final String message;
//   final LessonData data;
//   final Map<String, dynamic> errors;
//
//   LessonDetails({
//     required this.status,
//     required this.statusCode,
//     required this.message,
//     required this.data,
//     required this.errors,
//   });
//
//   factory LessonDetails.fromJson(Map<String, dynamic> json) {
//     return LessonDetails(
//       status: json['status'],
//       statusCode: json['status_code'],
//       message: json['message'],
//       data: LessonData.fromJson(json['data']),
//       errors: json['errors'],
//     );
//   }
//
//   @override
//   String toString() {
//     return 'LessonDetails(status: $status, statusCode: $statusCode, message: $message, data: $data, errors: $errors)';
//   }
// }
//
// class LessonData {
//   final int id;
//   final String lessonType;
//   final String lessonStatus;
//   final String subject;
//   final String tutorName;
//   final List<StudentName> studentNames;
//   final String date;
//   final String time;
//   final int lessonDuration;
//   final int createdBy;
//   final String tutorJoined;
//   final String tutorSpentTime;
//   final String studentJoined;
//   final String studentSpentTime;
//   final String createdDate;
//   final String modifiedDate;
//   final String day;
//   final String examBoard;
//   final String merithubclass;
//   final String merithubclassUsers;
//   final String scheduledBy;
//   final String tutorRate;
//   final String clientRate;
//   final bool isBillable;
//   final bool isPayable;
//   final String verificationStatus;
//   final String lessonRecording;
//   final String lessonWatch;
//
//   LessonData({
//     required this.id,
//     required this.lessonType,
//     required this.lessonStatus,
//     required this.subject,
//     required this.tutorName,
//     required this.studentNames,
//     required this.date,
//     required this.time,
//     required this.lessonDuration,
//     required this.createdBy,
//     required this.tutorJoined,
//     required this.tutorSpentTime,
//     required this.studentJoined,
//     required this.studentSpentTime,
//     required this.createdDate,
//     required this.modifiedDate,
//     required this.day,
//     required this.examBoard,
//     required this.merithubclass,
//     required this.merithubclassUsers,
//     required this.scheduledBy,
//     required this.tutorRate,
//     required this.clientRate,
//     required this.isBillable,
//     required this.isPayable,
//     required this.verificationStatus,
//     required this.lessonRecording,
//     required this.lessonWatch,
//   });
//
//   factory LessonData.fromJson(Map<String, dynamic> json) {
//     return LessonData(
//       id: json['id'],
//       lessonType: json['lesson_type'],
//       lessonStatus: json['lesson_status'],
//       subject: json['subject'],
//       tutorName: json['tutor_name'],
//       studentNames: (json['student_names'] as List)
//           .map((student) => StudentName.fromJson(student))
//           .toList(),
//       date: json['date'],
//       time: json['time'] ?? '',
//       lessonDuration: json['lesson_duration'],
//       createdBy: json['created_by'],
//       tutorJoined: json['tutor_joined'] ?? '',
//       tutorSpentTime: json['tutor_spent_time'] ?? '',
//       studentJoined: json['student_joined'] ?? '',
//       studentSpentTime: json['student_spent_time'] ?? '',
//       createdDate: json['created_date'],
//       modifiedDate: json['modified_date'],
//       day: json['day'],
//       examBoard: json['exam_board'] ?? '',
//       merithubclass: json['merithubclass'] ?? '',
//       merithubclassUsers: json['merithubclass_users'] ?? '',
//       scheduledBy: json['scheduled_by'],
//       tutorRate: json['tutor_rate'] ?? '',
//       clientRate: json['client_rate'] ?? [],
//       isBillable: json['is_billable'],
//       isPayable: json['is_payable'],
//       verificationStatus: json['verification_status'] ?? '',
//       lessonRecording: json['lesson_recording'] ?? '',
//       lessonWatch: json['lesson_watch'] ?? '',
//     );
//   }
//
//   @override
//   String toString() {
//     return 'LessonData(id: $id, lessonType: $lessonType, lessonStatus: $lessonStatus, subject: $subject, tutorName: $tutorName, studentNames: $studentNames, date: $date, time: $time, lessonDuration: $lessonDuration, createdBy: $createdBy, tutorJoined: $tutorJoined, tutorSpentTime: $tutorSpentTime, studentJoined: $studentJoined, studentSpentTime: $studentSpentTime, createdDate: $createdDate, modifiedDate: $modifiedDate, day: $day, examBoard: $examBoard, merithubclass: $merithubclass, merithubclassUsers: $merithubclassUsers, scheduledBy: $scheduledBy, tutorRate: $tutorRate, clientRate: $clientRate, isBillable: $isBillable, isPayable: $isPayable, verificationStatus: $verificationStatus, lessonRecording: $lessonRecording, lessonWatch: $lessonWatch)';
//   }
// }
//
// class StudentName {
//   final int id;
//   final String username;
//
//   StudentName({
//     required this.id,
//     required this.username,
//   });
//
//   factory StudentName.fromJson(Map<String, dynamic> json) {
//     return StudentName(
//       id: json['id'],
//       username: json['username'],
//     );
//   }
//
//   @override
//   String toString() {
//     return 'StudentName(id: $id, username: $username)';
//   }
// }


class LessonDetails {
  final bool status;
  final int statusCode;
  final String message;
  final LessonData data;
  final Map<String, dynamic> errors;

  LessonDetails({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory LessonDetails.fromJson(Map<String, dynamic> json) {
    return LessonDetails(
      status: json['status'],
      statusCode: json['status_code'],
      message: json['message'],
      data: LessonData.fromJson(json['data']),
      errors: json['errors'],
    );
  }
}

class LessonData {
  final int id;
  final String lessonType;
  final String lessonStatus;
  final String subject;
  final String tutorName;
  final List<StudentName> studentNames;
  final String date;
  final String time;
  final int lessonDuration;
  final int createdBy;
  final String tutorJoined;
  final String tutorSpentTime;
  final String studentJoined;
  final String studentSpentTime;
  final String createdDate;
  final String modifiedDate;
  final String day;
  final String examBoard;
  final String merithubclass;
  final String merithubclassUsers;
  final String scheduledBy;
  final double tutorRate;
  final double clientRate;
  final bool isBillable;
  final bool isPayable;
  final String verificationStatus;
  final String lessonRecording;
  final String lessonWatch;
  final String tutorPhoto;

  LessonData({
    required this.id,
    required this.lessonType,
    required this.lessonStatus,
    required this.subject,
    required this.tutorName,
    required this.studentNames,
    required this.date,
    required this.time,
    required this.lessonDuration,
    required this.createdBy,
    required this.tutorJoined,
    required this.tutorSpentTime,
    required this.studentJoined,
    required this.studentSpentTime,
    required this.createdDate,
    required this.modifiedDate,
    required this.day,
    required this.examBoard,
    required this.merithubclass,
    required this.merithubclassUsers,
    required this.scheduledBy,
    required this.tutorRate,
    required this.clientRate,
    required this.isBillable,
    required this.isPayable,
    required this.verificationStatus,
    required this.lessonRecording,
    required this.lessonWatch,
    required this.tutorPhoto,
  });

  factory LessonData.fromJson(Map<String, dynamic> json) {
    return LessonData(
      id: json['id'],
      lessonType: json['lesson_type'],
      lessonStatus: json['lesson_status'],
      subject: json['subject'],
      tutorName: json['tutor_name'],
      studentNames: (json['student_names'] as List)
          .map((student) => StudentName.fromJson(student))
          .toList(),
      date: json['date'],
      time: json['time'] ?? '',
      lessonDuration: json['lesson_duration'],
      createdBy: json['created_by'],
      tutorJoined: json['tutor_joined'] ?? '',
      tutorSpentTime: json['tutor_spent_time'] ?? '',
      studentJoined: json['student_joined'] ?? '',
      studentSpentTime: json['student_spent_time'] ?? '',
      createdDate: json['created_date'],
      modifiedDate: json['modified_date'],
      day: json['day'],
      examBoard: json['exam_board'] ?? '',
      merithubclass: json['merithubclass'] ?? '',
      merithubclassUsers: json['merithubclass_users'] ?? '',
      scheduledBy: json['scheduled_by'],
      tutorRate: (json['tutor_rate'] as num).toDouble(),
      clientRate: (json['client_rate'] as num).toDouble(),
      isBillable: json['is_billable'],
      isPayable: json['is_payable'],
      verificationStatus: json['verification_status'] ?? '',
      lessonRecording: json['lesson_recording'] ?? '',
      lessonWatch: json['lesson_watch'] ?? '',
      tutorPhoto: json['tutor_photo'] ?? '',
    );
  }
}

class StudentName {
  final int id;
  final String name;
  final String studentPhoto;

  StudentName({
    required this.id,
    required this.name,
    required this.studentPhoto,
  });

  factory StudentName.fromJson(Map<String, dynamic> json) {
    return StudentName(
      id: json['id'],
      name: json['name'],
      studentPhoto: json['student_photo'] ?? '',
    );
  }
}
