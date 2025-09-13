
import 'package:equatable/equatable.dart';

abstract class ClassesEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class FetchClassesForDate extends ClassesEvent {
  final DateTime date;

  FetchClassesForDate(this.date);
}
class FetchUpcomingClasses extends ClassesEvent {}
class FetchClasses extends ClassesEvent {
  final DateTime date;

  FetchClasses(this.date);

  @override
  List<Object> get props => [date];
}
//completed

class FetchCompletedForDate extends ClassesEvent {
  final DateTime date;

  FetchCompletedForDate(this.date);
}
class FetchCompletedClasses extends ClassesEvent {}
class FetchCompleted extends ClassesEvent {
  final DateTime date;

  FetchCompleted(this.date);

  @override
  List<Object> get props => [date];
}
//cancelled
class FetchCancellForDate extends ClassesEvent {
  final DateTime date;

  FetchCancellForDate(this.date);
}
class FetchCancellClasses extends ClassesEvent {}
class FetchCancell extends ClassesEvent {
  final DateTime date;

  FetchCancell(this.date);

  @override
  List<Object> get props => [date];
}

//cancelled
class FetchdemoDate extends ClassesEvent {
  final DateTime date;

  FetchdemoDate(this.date);
   @override
  List<Object> get props => [date];
}
class FetchdemoClasses extends ClassesEvent {}

class LoadAllocations extends ClassesEvent {}

class RefreshAllocations extends ClassesEvent {}

class LoadUser extends ClassesEvent {
}

class FetchLessonDetails extends ClassesEvent {
  final int lessonId;

  FetchLessonDetails(this.lessonId);

  @override
  List<Object> get props => [lessonId];
}
