part of 'students_bloc.dart';

abstract class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object?> get props => [];
}

class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class StudentLoaded extends StudentState {
  final List<StudentModel> students;

  const StudentLoaded(this.students);

  @override
  List<Object?> get props => [students];
}

class StudentSelected extends StudentState {
  final String selectedStudentId;

  const StudentSelected(this.selectedStudentId);

  @override
  List<Object?> get props => [selectedStudentId];
}

class StudentError extends StudentState {
  final String message;

  const StudentError(this.message);
}

class StudentDetailsLoaded extends StudentState {
  final StudentModel studentDetails;

  const StudentDetailsLoaded(this.studentDetails);

  @override
  List<Object?> get props => [studentDetails];
}
