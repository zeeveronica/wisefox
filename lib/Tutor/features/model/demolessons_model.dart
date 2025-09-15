class DemoLessonModel {
  final int id;
  final int tutor;
  final int client;
  final String clientName;
  final int student;
  final int subject;
  final String date;
  final String time;
  final String duration;
  final String lessonStatus;
  final String subjectName;
  final String tutorName;
  final String studentName;
  final String day;

  DemoLessonModel({
    required this.id,
    required this.tutor,
    required this.client,
    required this.clientName,
    required this.student,
    required this.subject,
    required this.date,
    required this.time,
    required this.duration,
    required this.lessonStatus,
    required this.subjectName,
    required this.tutorName,
    required this.studentName,
    required this.day,
  });

  // Factory method to parse JSON data
  factory DemoLessonModel.fromJson(Map<String, dynamic> json) {
    return DemoLessonModel(
      id: json['id'] ?? 0,
      tutor: json['tutor'] ?? 0,
      client: json['client'] ?? 0,
      clientName: json['client_name'] ?? '',
      student: json['student'] ?? 0,
      subject: json['subject'] ?? 0,
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      duration: json['duration'] ?? '',
      lessonStatus: json['lesson_status'] ?? '',
      subjectName: json['subject_name'] ?? '',
      tutorName: json['tutor_name'] ?? '',
      studentName: json['student_name'] ?? '',
      day: json['day'] ?? '',
    );
  }

  // Method to convert object back to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tutor': tutor,
      'client': client,
      'client_name': clientName,
      'student': student,
      'subject': subject,
      'date': date,
      'time': time,
      'duration': duration,
      'lesson_status': lessonStatus,
      'subject_name': subjectName,
      'tutor_name': tutorName,
      'student_name': studentName,
      'day': day,
    };
  }
}
