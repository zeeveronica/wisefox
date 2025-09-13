part of 'studentoverviewcount_bloc.dart';

abstract class StudentOverviewCountEvent extends Equatable {
  const StudentOverviewCountEvent();

  @override
  List<Object> get props => [];
}

final class FetchStudentOverviewCount extends StudentOverviewCountEvent {}
