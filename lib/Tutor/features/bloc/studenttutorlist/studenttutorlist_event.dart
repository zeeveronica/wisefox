part of 'studenttutorlist_bloc.dart';

abstract class TutorEvent extends Equatable {
  const TutorEvent();

  @override
  List<Object?> get props => [];
}

class FetchTutorList extends TutorEvent {}
