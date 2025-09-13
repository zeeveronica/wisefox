part of 'studentlessondetails_bloc.dart';

abstract class StudentLessonDetailsEvent extends Equatable {
  const StudentLessonDetailsEvent();

  @override
  List<Object> get props => [];
}

final class FetchStudentLessonDetails extends StudentLessonDetailsEvent {
  final String lessonId;
  final String timezone;

  const FetchStudentLessonDetails(this.lessonId, this.timezone);

  @override
  List<Object> get props => [lessonId, timezone];
}
