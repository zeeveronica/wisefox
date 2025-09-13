part of 'lesson_bloc.dart';

abstract class LessonState extends Equatable {
  const LessonState();

  @override
  List<Object> get props => [];
}

class LessonInitial extends LessonState {}

class LessonLoading extends LessonState {}

class LessonLoaded extends LessonState {
  final List<LessonModel> lessons;

  const LessonLoaded(this.lessons);

  @override
  List<Object> get props => [lessons];
}

class LessonError extends LessonState {
  final String message;

  const LessonError(this.message);

  @override
  List<Object> get props => [message];
}

// abstract class LessonState extends Equatable {
//   const LessonState();

//   @override
//   List<Object?> get props => [];
// }

// class LessonInitial extends LessonState {}

// class LessonLoading extends LessonState {}

// class LessonLoaded extends LessonState {
//   final List<LessonModel> lessons;
//   final List<DateTime> dates;

//   const LessonLoaded(this.lessons, this.dates);

//   @override
//   List<Object?> get props => [lessons, dates];
// }

// class LessonError extends LessonState {
//   final String message;

//   const LessonError(this.message);

//   @override
//   List<Object?> get props => [message];
// }
