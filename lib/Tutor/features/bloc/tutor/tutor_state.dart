part of 'tutor_bloc.dart';

abstract class TutorState extends Equatable {
  const TutorState();

  @override
  List<Object> get props => [];
}

class TutorInitial extends TutorState {}

class TutorLoading extends TutorState {}

class TutorLoaded extends TutorState {
  final List<Tutor> tutors;
  final int tutorCount;
  final int activeTutors;
  final int onLeaveTutors;

  const TutorLoaded({
    required this.tutors,
    required this.tutorCount,
    required this.activeTutors,
    required this.onLeaveTutors,
  });

  @override
  List<Object> get props => [tutors, tutorCount, activeTutors, onLeaveTutors];
}

class TutorError extends TutorState {
  final String message;

  const TutorError(this.message);

  @override
  List<Object> get props => [message];
}
