part of 'studenttutor_bloc.dart';

abstract class StudentTutorState extends Equatable {
  const StudentTutorState();

  @override
  List<Object> get props => [];
}

class StudentTutorInitial extends StudentTutorState {}

class StudentTutorLoading extends StudentTutorState {}

class StudentTutorLoaded extends StudentTutorState {
  final List<Tutor> tutors;
  final int tutorCount;
  final int activeTutors;
  final int onLeaveTutors;

  const StudentTutorLoaded({
    required this.tutors,
    required this.tutorCount,
    required this.activeTutors,
    required this.onLeaveTutors,
  });

  @override
  List<Object> get props => [tutors, tutorCount, activeTutors, onLeaveTutors];
}

class StudentTutorError extends StudentTutorState {
  final String message;

  const StudentTutorError(this.message);

  @override
  List<Object> get props => [message];
}
