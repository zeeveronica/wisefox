part of 'demo_lessons_bloc.dart';

abstract class DemoLessonsState extends Equatable {
  const DemoLessonsState();

  @override
  List<Object?> get props => [];
}

class DemoLessonsInitial extends DemoLessonsState {}

class DemoLessonsLoading extends DemoLessonsState {}

class DemoLessonsLoaded extends DemoLessonsState {
  final List<DemoLessonModel> demoLessons;

  const DemoLessonsLoaded(this.demoLessons);

  @override
  List<Object?> get props => [demoLessons];
}

class DemoLessonsError extends DemoLessonsState {
  final String message;

  const DemoLessonsError(this.message);

  @override
  List<Object?> get props => [message];
}
