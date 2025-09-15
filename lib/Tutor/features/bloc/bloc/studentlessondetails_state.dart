part of 'studentlessondetails_bloc.dart';

abstract class StudentLessonDetailsState extends Equatable {
  const StudentLessonDetailsState();

  @override
  List<Object> get props => [];
}

final class StudentLessonDetailsInitial extends StudentLessonDetailsState {}

final class StudentLessonDetailsLoading extends StudentLessonDetailsState {}

final class StudentLessonDetailsLoaded extends StudentLessonDetailsState {
  final LessonData lessonData;

  const StudentLessonDetailsLoaded(this.lessonData);

  @override
  List<Object> get props => [lessonData];
}

final class StudentLessonDetailsError extends StudentLessonDetailsState {
  final String message;

  const StudentLessonDetailsError(this.message);

  @override
  List<Object> get props => [message];
}

final class StudentLessonDetailsEmpty extends StudentLessonDetailsState {}
