part of 'subject_bloc.dart';

abstract class SubjectState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubjectInitial extends SubjectState {}

class SubjectLoading extends SubjectState {}

class SubjectLoaded extends SubjectState {
  final List<SubjectModel> subjectList;

  SubjectLoaded(this.subjectList);

  @override
  List<Object?> get props => [subjectList];
}

class SubjectError extends SubjectState {
  final String error;

  SubjectError(this.error);

  @override
  List<Object?> get props => [error];
}
