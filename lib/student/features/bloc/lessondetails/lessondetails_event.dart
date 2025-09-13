part of 'lessondetails_bloc.dart';

sealed class LessondetailsEvent extends Equatable {
  const LessondetailsEvent();

  @override
  List<Object> get props => [];
}

final class FetchLessonDetails extends LessondetailsEvent {
  final String lessonId;
  const FetchLessonDetails(this.lessonId);

  @override
  List<Object> get props => [lessonId];
}
