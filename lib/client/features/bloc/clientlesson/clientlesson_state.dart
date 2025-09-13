part of 'clientlesson_bloc.dart';

abstract class ClientLessonState extends Equatable {
  const ClientLessonState();

  @override
  List<Object> get props => [];
}

class ClientLessonInitial extends ClientLessonState {}

class ClientLessonLoading extends ClientLessonState {}

class ClientLessonLoaded extends ClientLessonState {
  final List<ClientLessonModel> lessons;

  const ClientLessonLoaded(this.lessons);

  @override
  List<Object> get props => [lessons];
}

class ClientLessonError extends ClientLessonState {
  final String message;

  const ClientLessonError(this.message);

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
