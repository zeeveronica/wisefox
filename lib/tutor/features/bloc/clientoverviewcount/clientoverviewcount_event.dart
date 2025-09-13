part of 'clientoverviewcount_bloc.dart';

abstract class ClientOverviewEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchClientOverviewCount extends ClientOverviewEvent {}
