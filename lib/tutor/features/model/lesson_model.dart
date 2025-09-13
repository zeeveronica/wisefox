import 'package:equatable/equatable.dart';

class ClientLessonModel extends Equatable {
  final int id;
  final String lessonType;
  final int tutor;
  final String lessonStatus;
  final dynamic studentInfo;
  final String date;
  final String time;
  final String endTime;
  final int lessonDuration;
  final bool isTutorJoined;
  final bool isStudentsJoined;
  final String subject;
  final String tutorName;
  final String day;
  final List<ClientInfo> clientInfo;
  final dynamic clientRate;
  final String examBoard;
  final String boardName;
  final String merithubclassId;
  final String hostLink;
  final List<MerithubClassUser> merithubclassUsers;
  final String recording;
  final bool isBillable;
  final bool isPayable;

  const ClientLessonModel({
    required this.id,
    required this.lessonType,
    required this.tutor,
    required this.lessonStatus,
    required this.studentInfo,
    required this.date,
    required this.time,
    required this.endTime,
    required this.lessonDuration,
    required this.isTutorJoined,
    required this.isStudentsJoined,
    required this.subject,
    required this.tutorName,
    required this.day,
    required this.clientInfo,
    required this.clientRate,
    required this.examBoard,
    required this.boardName,
    required this.merithubclassId,
    required this.hostLink,
    required this.merithubclassUsers,
    required this.recording,
    required this.isBillable,
    required this.isPayable,
  });

  factory ClientLessonModel.fromJson(Map<String, dynamic> json) {
    return ClientLessonModel(
      id: json['id'],
      lessonType: json['lesson_type'] ?? '',
      tutor: json['tutor'],
      lessonStatus: json['lesson_status'] ?? '',
      studentInfo: (json['student_info'] as List)
          .map((item) => StudentInfo.fromJson(item))
          .toList(),
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      endTime: json['end_time'] ?? '',
      lessonDuration: json['lesson_duration'] ?? 0,
      isTutorJoined: json['is_tutor_joined'] ?? false,
      isStudentsJoined: json['is_students_joined'] ?? false,
      subject: json['subject'] ?? '',
      tutorName: json['tutor_name'] ?? '',
      day: json['day'] ?? '',
      clientInfo: (json['client_info'] as List)
          .map((item) => ClientInfo.fromJson(item))
          .toList(),
      clientRate: (json['client_rate'] is num)
          ? (json['client_rate'] as num).toDouble()
          : double.tryParse(json['client_rate']) ?? 0.0,
      examBoard: json['exam_board'] ?? '',
      boardName: json['board_name'] ?? '',
      merithubclassId: json['merithubclass_id'] ?? '',
      hostLink: json['hostlink'] ?? '',
      merithubclassUsers: (json['merithubclass_users'] as List)
          .map((item) => MerithubClassUser.fromJson(item))
          .toList(),
      recording: json['recording'] ?? '',
      isBillable: json['is_billable'] ?? false,
      isPayable: json['is_payable'] ?? false,
    );
  }

  @override
  List<Object?> get props => [
        id,
        lessonType,
        tutor,
        lessonStatus,
        studentInfo,
        date,
        time,
        endTime,
        lessonDuration,
        isTutorJoined,
        isStudentsJoined,
        subject,
        tutorName,
        day,
        clientInfo,
        clientRate,
        examBoard,
        boardName,
        merithubclassId,
        hostLink,
        merithubclassUsers,
        recording,
        isBillable,
        isPayable,
      ];
}

class StudentInfo extends Equatable {
  final int id;
  final String name;

  const StudentInfo({
    required this.id,
    required this.name,
  });

  factory StudentInfo.fromJson(Map<String, dynamic> json) {
    return StudentInfo(
      id: json['id'],
      name: json['name'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name];
}

class ClientInfo extends Equatable {
  final int id;
  final String name;

  const ClientInfo({
    required this.id,
    required this.name,
  });

  factory ClientInfo.fromJson(Map<String, dynamic> json) {
    return ClientInfo(
      id: json['id'],
      name: json['name'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name];
}

class MerithubClassUser extends Equatable {
  final String userid;
  final String userlink;
  final String user;
  final String usertype;

  const MerithubClassUser({
    required this.userid,
    required this.userlink,
    required this.user,
    required this.usertype,
  });

  factory MerithubClassUser.fromJson(Map<String, dynamic> json) {
    return MerithubClassUser(
      userid: json['userid'] ?? '',
      userlink: json['userlink'] ?? '',
      user: json['user'] ?? '',
      usertype: json['usertype'] ?? '',
    );
  }

  @override
  List<Object?> get props => [userid, userlink, user, usertype];
}
