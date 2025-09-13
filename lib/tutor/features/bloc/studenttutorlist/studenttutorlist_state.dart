part of 'studenttutorlist_bloc.dart';

abstract class TutorState extends Equatable {
  const TutorState();

  @override
  List<Object?> get props => [];
}

class TutorInitial extends TutorState {}

class TutorLoading extends TutorState {}

class TutorLoaded extends TutorState {
  final List<Result>
      results; // Use the Result class or appropriate data structure

  const TutorLoaded(this.results);

  @override
  List<Object?> get props => [results];
}

class TutorError extends TutorState {
  final String message;

  const TutorError(this.message);

  @override
  List<Object?> get props => [message];
}
