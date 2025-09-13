part of 'clientlesson_bloc.dart';

abstract class ClientLessonEvent extends Equatable {
  const ClientLessonEvent();

  @override
  List<Object> get props => [];
}

class FetchLessons extends ClientLessonEvent {
  final String status;
  final String timezone;

  FetchLessons(this.status, this.timezone);

  @override
  List<Object> get props => [status, timezone];
}

class SetSelectedDate extends ClientLessonEvent {
  final DateTime? date;

  const SetSelectedDate(this.date);

  @override
  List<Object> get props => [date ?? ''];
}
