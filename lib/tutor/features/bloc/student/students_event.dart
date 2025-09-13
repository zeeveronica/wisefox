part of 'students_bloc.dart';

abstract class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object?> get props => [];
}

class FetchStudents extends StudentEvent {}

class SelectStudent extends StudentEvent {
  final String studentId;

  const SelectStudent(this.studentId);

  @override
  List<Object?> get props => [studentId];
}

class LoadSelectedStudent extends StudentEvent {}

class FetchStudentDetails extends StudentEvent {
  final String studentId;

  const FetchStudentDetails(this.studentId);

  @override
  List<Object?> get props => [studentId];
}
