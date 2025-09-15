part of 'studentlesson_bloc.dart';

abstract class StudentLessonEvent extends Equatable {
  const StudentLessonEvent();

  @override
  List<Object> get props => [];
}

class FetchStudentLessons extends StudentLessonEvent {
  final String type;

  FetchStudentLessons(this.type);

  @override
  List<Object> get props => [type];
}

class SetStudentSelectedDate extends StudentLessonEvent {
  final DateTime? date;

  const SetStudentSelectedDate(this.date);

  @override
  List<Object> get props => [date ?? ''];
}
