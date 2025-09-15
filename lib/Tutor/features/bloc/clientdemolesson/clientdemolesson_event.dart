part of 'clientdemolesson_bloc.dart';

abstract class ClientDemoLessonEvent extends Equatable {
  const ClientDemoLessonEvent();

  @override
  List<Object> get props => [];
}

class FetchClientDemoLessons extends ClientDemoLessonEvent {
  final String status;
  final String timezone;

  FetchClientDemoLessons(this.status, this.timezone);

  @override
  List<Object> get props => [status];
}
