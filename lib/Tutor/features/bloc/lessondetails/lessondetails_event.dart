part of 'lessondetails_bloc.dart';

abstract class LessondetailsEvent extends Equatable {
  const LessondetailsEvent();

  @override
  List<Object> get props => [];
}

final class FetchLessonDetails extends LessondetailsEvent {
  final String lessonId;
  final String timezone;
  const FetchLessonDetails(this.lessonId, this.timezone);

  @override
  List<Object> get props => [lessonId];
}
