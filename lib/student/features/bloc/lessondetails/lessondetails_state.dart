part of 'lessondetails_bloc.dart';

sealed class LessondetailsState extends Equatable {
  const LessondetailsState();

  @override
  List<Object> get props => [];
}

final class LessondetailsInitial extends LessondetailsState {}

final class LessondetailsLoading extends LessondetailsState {}

final class LessondetailsLoaded extends LessondetailsState {
  final LessonData lessonData;
  const LessondetailsLoaded(this.lessonData);

  @override
  List<Object> get props => [lessonData];
}

final class LessondetailsError extends LessondetailsState {
  final String message;
  const LessondetailsError(this.message);

  @override
  List<Object> get props => [message];
}

final class LessondetailsEmpty extends LessondetailsState {}
