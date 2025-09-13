import 'package:equatable/equatable.dart';

class LessonModel extends Equatable {
  final int id;
  final String lessonType;
  final String lessonStatus;
  final String date;
  final String time;
  final int lessonDuration;
  final String subject;
  final String tutorName;
  final String studentName;
  final String day;
  final int client;
  final String clientName;
  final dynamic examBoard; // Changed to dynamic to handle both int and String
  final String boardName;
  final String? tutorPhoto;

  const LessonModel({
    required this.id,
    required this.lessonType,
    required this.lessonStatus,
    required this.date,
    required this.time,
    required this.lessonDuration,
    required this.subject,
    required this.tutorName,
    required this.studentName,
    required this.day,
    required this.client,
    required this.clientName,
    required this.examBoard,
    required this.boardName,
    this.tutorPhoto,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'],
      lessonType: json['lesson_type'] ?? '',
      lessonStatus: json['lesson_status'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      lessonDuration: json['lesson_duration'] ?? 0,
      subject: json['subject'] ?? '',
      tutorName: json['tutor_name'] ?? '',
      studentName: (json['student_info'] as List).isNotEmpty
          ? json['student_info'][0]['name']
          : '', // Handling student_info array
      day: json['day'] ?? '',
      client: json['client'] ?? 0,
      clientName: json['client_name'] ?? '',
      examBoard: json['exam_board']?.toString() ?? '', // Convert to String
      boardName: json['board_name'] ?? '',
      tutorPhoto: json['tutor_photo'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        id,
        lessonType,
        lessonStatus,
        date,
        time,
        lessonDuration,
        subject,
        tutorName,
        studentName,
        day,
        client,
        clientName,
        examBoard,
        boardName,
      tutorPhoto,
      ];
}
