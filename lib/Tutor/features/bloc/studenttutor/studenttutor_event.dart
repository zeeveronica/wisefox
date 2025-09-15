part of 'studenttutor_bloc.dart';

abstract class StudentTutorEvent extends Equatable {
  const StudentTutorEvent();

  @override
  List<Object> get props => [];
}

class FetchStudentTutors extends StudentTutorEvent {}
