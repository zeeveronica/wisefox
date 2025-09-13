part of 'student_bloc.dart'; // Updated to match the new bloc file

abstract class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object> get props => [];
}

class FetchStudents extends StudentEvent {}
