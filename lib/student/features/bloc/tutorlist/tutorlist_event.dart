part of 'tutorlist_bloc.dart';

abstract class TutorListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTutorList extends TutorListEvent {}
