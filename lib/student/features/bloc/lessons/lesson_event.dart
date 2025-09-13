part of 'lesson_bloc.dart';

abstract class LessonEvent extends Equatable {
  const LessonEvent();

  @override
  List<Object> get props => [];
}

class FetchLessons extends LessonEvent {
  final String type;
  final String? date; // nullable

  const FetchLessons(this.type, {this.date});

  @override
  List<Object> get props => [type, date ?? '']; // handle null explicitly
}

class SetSelectedDate extends LessonEvent {
  final DateTime? date;

  const SetSelectedDate(this.date);

  @override
  List<Object> get props => [date ?? ''];
}

// part of 'lesson_bloc.dart';

// abstract class LessonEvent extends Equatable {
//   const LessonEvent();

//   @override
//   List<Object?> get props => [];
// }

// class FetchLessons extends LessonEvent {
//   final String type;

//   const FetchLessons(this.type);

//   @override
//   List<Object?> get props => [type];
// }

// class SetSelectedDate extends LessonEvent {
//   final DateTime date;

//   const SetSelectedDate(this.date);

//   @override
//   List<Object?> get props => [date];
// }
