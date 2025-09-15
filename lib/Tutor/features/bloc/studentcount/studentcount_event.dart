part of 'studentcount_bloc.dart';

abstract class StudentCountEvent extends Equatable {
  const StudentCountEvent();

  @override
  List<Object?> get props => [];
}

class FetchStudentCount extends StudentCountEvent {
  const FetchStudentCount();
}
