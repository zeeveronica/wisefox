part of 'tutorlist_bloc.dart';

abstract class TutorListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TutorListInitial extends TutorListState {}

class TutorListLoading extends TutorListState {}

class TutorListLoaded extends TutorListState {
  final List<TutorList> tutorList;

  TutorListLoaded(this.tutorList);

  @override
  List<Object?> get props => [tutorList];
}

class TutorListError extends TutorListState {
  final String error;

  TutorListError(this.error);

  @override
  List<Object?> get props => [error];
}
