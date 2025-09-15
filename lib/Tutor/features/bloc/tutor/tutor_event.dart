part of 'tutor_bloc.dart';

abstract class TutorEvent extends Equatable {
  const TutorEvent();

  @override
  List<Object> get props => [];
}

class FetchTutors extends TutorEvent {}
