part of 'studentoverviewcount_bloc.dart';

sealed class StudentOverviewCountState extends Equatable {
  const StudentOverviewCountState();

  @override
  List<Object> get props => [];
}

final class StudentOverviewCountInitial extends StudentOverviewCountState {}

final class StudentOverviewCountLoading extends StudentOverviewCountState {}

final class StudentOverviewCountLoaded extends StudentOverviewCountState {
  final StudentOverviewModel studentoverviewCount; // Correct type here

  StudentOverviewCountLoaded(this.studentoverviewCount);

  @override
  List<Object> get props => [studentoverviewCount];
}

final class StudentOverviewCountError extends StudentOverviewCountState {
  final String message;

  StudentOverviewCountError(this.message);

  @override
  List<Object> get props => [message];
}
