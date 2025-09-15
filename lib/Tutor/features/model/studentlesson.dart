class StudentLessonModel {
  final int id;
  final String lessonType;
  final int tutor;
  final String lessonStatus;
  final List<dynamic> studentInfo;
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
  final double clientRate; // Fix here
  final String examBoard;
  final String boardName;
  final String merithubclassId;
  final String hostLink;
  final List<MerithubClassUsers> merithubclassUsers;
  final String recording;
  final bool isBillable;
  final bool isPayable;

  StudentLessonModel({
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
    required this.clientRate, // Fix here
    required this.examBoard,
    required this.boardName,
    required this.merithubclassId,
    required this.hostLink,
    required this.merithubclassUsers,
    required this.recording,
    required this.isBillable,
    required this.isPayable,
  });

  factory StudentLessonModel.fromJson(Map<String, dynamic> json) {
    return StudentLessonModel(
      id: json['id'],
      lessonType: json['lesson_type'],
      tutor: json['tutor'],
      lessonStatus: json['lesson_status'],
      studentInfo: json['student_info'],
      date: json['date'],
      time: json['time'],
      endTime: json['end_time'],
      lessonDuration: json['lesson_duration'],
      isTutorJoined: json['is_tutor_joined'],
      isStudentsJoined: json['is_students_joined'],
      subject: json['subject'],
      tutorName: json['tutor_name'],
      day: json['day'],
      clientInfo: (json['client_info'] as List<dynamic>)
          .map((e) => ClientInfo.fromJson(e))
          .toList(),
      clientRate: (json['client_rate'] != null && json['client_rate'] != "")
          ? double.tryParse(json['client_rate'].toString()) ?? 0.0
          : 0.0, // Fixed handling of empty string
      examBoard: json['exam_board'] ?? '',
      boardName: json['board_name'] ?? '',
      merithubclassId: json['merithubclass_id'],
      hostLink: json['hostlink'],
      merithubclassUsers: (json['merithubclass_users'] as List<dynamic>)
          .map((e) => MerithubClassUsers.fromJson(e))
          .toList(),
      recording: json['recording'],
      isBillable: json['is_billable'],
      isPayable: json['is_payable'],
    );
  }
}

class ClientInfo {
  final int id;
  final String name;

  ClientInfo({
    required this.id,
    required this.name,
  });

  factory ClientInfo.fromJson(Map<String, dynamic> json) {
    return ClientInfo(
      id: json['id'],
      name: json['name'],
    );
  }
}

class MerithubClassUsers {
  final String userId;
  final String userLink;
  final String user;
  final String userType;

  MerithubClassUsers({
    required this.userId,
    required this.userLink,
    required this.user,
    required this.userType,
  });

  factory MerithubClassUsers.fromJson(Map<String, dynamic> json) {
    return MerithubClassUsers(
      userId: json['userid'],
      userLink: json['userlink'],
      user: json['user'],
      userType: json['usertype'],
    );
  }
}
