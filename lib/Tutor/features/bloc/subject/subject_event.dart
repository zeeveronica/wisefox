part of 'subject_bloc.dart';

abstract class SubjectEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchSubjectList extends SubjectEvent {}
