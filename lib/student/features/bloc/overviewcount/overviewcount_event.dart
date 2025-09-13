part of 'overviewcount_bloc.dart';

abstract class OverviewEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchOverviewCount extends OverviewEvent {}
