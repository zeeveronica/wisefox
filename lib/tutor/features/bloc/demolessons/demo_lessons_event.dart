part of 'demo_lessons_bloc.dart';

abstract class DemoLessonsEvent extends Equatable {
  const DemoLessonsEvent();

  @override
  List<Object> get props => [];
}

class FetchDemoLessons extends DemoLessonsEvent {
  final String type;

  FetchDemoLessons(this.type);

  @override
  List<Object> get props => [type];
}

class SetDemoSelectedDate extends DemoLessonsEvent {
  final DateTime? date;

  const SetDemoSelectedDate(this.date);

  @override
  List<Object> get props => [date ?? ''];
}
