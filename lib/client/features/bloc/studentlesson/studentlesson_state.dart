part of 'studentlesson_bloc.dart';

abstract class StudentLessonState extends Equatable {
  const StudentLessonState();

  @override
  List<Object> get props => [];
}

class StudentLessonInitial extends StudentLessonState {}

class StudentLessonLoading extends StudentLessonState {}

class StudentLessonLoaded extends StudentLessonState {
  final List<StudentLessonModel> studentlessons;

  const StudentLessonLoaded(this.studentlessons);

  @override
  List<Object> get props => [studentlessons];

  get lessons => null;
}

class StudentLessonError extends StudentLessonState {
  final String message;

  const StudentLessonError(this.message);

  @override
  List<Object> get props => [message];
}
