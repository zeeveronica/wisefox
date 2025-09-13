part of 'studentcount_bloc.dart';

abstract class StudentCountState extends Equatable {
  const StudentCountState();

  @override
  List<Object?> get props => [];
}

class StudentCountInitial extends StudentCountState {}

class StudentCountLoading extends StudentCountState {}

class StudentCountLoaded extends StudentCountState {
  final int studentCount;
  final int activeStudents;
  final int inactiveStudents;
  final int onLeaveStudents;

  const StudentCountLoaded({
    required this.studentCount,
    required this.activeStudents,
    required this.inactiveStudents,
    required this.onLeaveStudents,
  });

  @override
  List<Object?> get props =>
      [studentCount, activeStudents, inactiveStudents, onLeaveStudents];
}

class StudentCountError extends StudentCountState {
  final String error;

  const StudentCountError(this.error);

  @override
  List<Object?> get props => [error];
}
