part of 'tutor_bloc.dart';

abstract class TutorEvent extends Equatable {
  const TutorEvent();

  @override
  List<Object> get props => [];
}

class FetchTutors extends TutorEvent {}

class SearchTutors extends TutorEvent {
  final String query;
  SearchTutors(this.query);
}
