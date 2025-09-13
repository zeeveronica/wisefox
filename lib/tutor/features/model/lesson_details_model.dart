import 'dart:convert';

class LessonDetails {
  final bool status;
  final int statusCode;
  final String message;
  final LessonData data;
  final Map<String, dynamic>? errors;

  LessonDetails({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
    this.errors,
  });

  factory LessonDetails.fromJson(Map<String, dynamic> json) {
    return LessonDetails(
      status: json['status'],
      statusCode: json['status_code'],
      message: json['message'],
      data: LessonData.fromJson(json['data']),
      errors: json['errors'] != null ? json['errors'] : null,
    );
  }

  @override
  String toString() {
    return 'LessonDetails(status: $status, statusCode: $statusCode, message: $message, data: $data, errors: $errors)';
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
  final String? tutorJoined;
  final String? tutorSpentTime;
  final String? studentJoined;
  final String? studentSpentTime;
  final String createdDate;
  final String modifiedDate;
  final String day;
  final String? examBoard;
  final MerithubClass merithubclass;
  final String? merithubclassUsers;
  final String scheduledBy;
  final String? tutorRate;
  final Map<String, dynamic>? clientRate;
  final bool isBillable;
  final bool isPayable;
  final String? verificationStatus;
  final String? lessonRecording;
  final String? lessonWatch;

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
    this.tutorJoined,
    this.tutorSpentTime,
    this.studentJoined,
    this.studentSpentTime,
    required this.createdDate,
    required this.modifiedDate,
    required this.day,
    this.examBoard,
    required this.merithubclass,
    this.merithubclassUsers,
    required this.scheduledBy,
    this.tutorRate,
    this.clientRate,
    required this.isBillable,
    required this.isPayable,
    this.verificationStatus,
    this.lessonRecording,
    this.lessonWatch,
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
      time: json['time']?.toString() ?? '',
      lessonDuration: json['lesson_duration'],
      createdBy: json['created_by'],
      tutorJoined: json['tutor_joined']?.toString() ?? '',
      tutorSpentTime: json['tutor_spent_time']?.toString() ?? '',
      studentJoined: json['student_joined']?.toString() ?? '',
      studentSpentTime: json['student_spent_time']?.toString() ?? '',
      createdDate: json['created_date'],
      modifiedDate: json['modified_date'],
      day: json['day'],
      examBoard: json['exam_board'] ?? '',
      merithubclass: MerithubClass.fromJson(json['merithubclass']),
      merithubclassUsers: json['merithubclass_users'] is List
          ? (json['merithubclass_users'] as List).join(', ')
          : json['merithubclass_users']?.toString() ?? '',
      scheduledBy: json['scheduled_by'] ?? '',
      tutorRate: json['tutor_rate']?.toString() ?? '',
      clientRate: json['client_rate'] is Map<String, dynamic>
          ? json['client_rate']
          : null,
      isBillable: json['is_billable'] ?? false,
      isPayable: json['is_payable'] ?? false,
      verificationStatus: json['verification_status']?.toString() ?? '',
      lessonRecording: json['lesson_recording']?.toString() ?? '',
      lessonWatch: json['lesson_watch']?.toString() ?? '',
    );
  }

  @override
  String toString() {
    return 'LessonData(id: $id, lessonType: $lessonType, lessonStatus: $lessonStatus, subject: $subject, tutorName: $tutorName, studentNames: $studentNames, date: $date, time: $time, lessonDuration: $lessonDuration, createdBy: $createdBy, tutorJoined: $tutorJoined, tutorSpentTime: $tutorSpentTime, studentJoined: $studentJoined, studentSpentTime: $studentSpentTime, createdDate: $createdDate, modifiedDate: $modifiedDate, day: $day, examBoard: $examBoard, merithubclass: $merithubclass, merithubclassUsers: $merithubclassUsers, scheduledBy: $scheduledBy, tutorRate: $tutorRate, clientRate: $clientRate, isBillable: $isBillable, isPayable: $isPayable, verificationStatus: $verificationStatus, lessonRecording: $lessonRecording, lessonWatch: $lessonWatch)';
  }
}

class MerithubClass {
  final String classid;
  final String commonhostlink;
  final String commonmoderatorlink;
  final String commonparticipantlink;
  final String hostlink;

  MerithubClass({
    required this.classid,
    required this.commonhostlink,
    required this.commonmoderatorlink,
    required this.commonparticipantlink,
    required this.hostlink,
  });

  factory MerithubClass.fromJson(Map<String, dynamic> json) {
    return MerithubClass(
      classid: json['classid'],
      commonhostlink: json['commonhostlink'],
      commonmoderatorlink: json['commonmoderatorlink'],
      commonparticipantlink: json['commonparticipantlink'],
      hostlink: json['hostlink'],
    );
  }

  @override
  String toString() {
    return 'MerithubClass(classid: $classid, commonhostlink: $commonhostlink, commonmoderatorlink: $commonmoderatorlink, commonparticipantlink: $commonparticipantlink, hostlink: $hostlink)';
  }
}

class StudentName {
  final int id;
  final String username;

  StudentName({
    required this.id,
    required this.username,
  });

  factory StudentName.fromJson(Map<String, dynamic> json) {
    return StudentName(
      id: json['id'],
      username: json['name'], // Use 'name' field as per your API response
    );
  }

  @override
  String toString() {
    return 'StudentName(id: $id, username: $username)';
  }
}
