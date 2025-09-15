part of 'clientdemolesson_bloc.dart';

abstract class ClientDemoLessonState extends Equatable {
  const ClientDemoLessonState();

  @override
  List<Object> get props => [];
}

class ClientDemoLessonInitial extends ClientDemoLessonState {}

class ClientDemoLessonLoading extends ClientDemoLessonState {}

class ClientDemoLessonLoaded extends ClientDemoLessonState {
  final List<ClientLessonModel> lessons;

  const ClientDemoLessonLoaded(this.lessons);

  @override
  List<Object> get props => [lessons];
}

class ClientDemoLessonError extends ClientDemoLessonState {
  final String message;

  const ClientDemoLessonError(this.message);

  @override
  List<Object> get props => [message];
}
