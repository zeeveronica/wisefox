part of 'clientoverviewcount_bloc.dart';

abstract class ClientOverviewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ClientOverviewLoading extends ClientOverviewState {}

class ClientOverviewLoaded extends ClientOverviewState {
  final ClientOverviewCount overviewCount;

  ClientOverviewLoaded(this.overviewCount);

  @override
  List<Object?> get props => [overviewCount];
}

class ClientOverviewError extends ClientOverviewState {
  final String message;

  ClientOverviewError(this.message);

  @override
  List<Object?> get props => [message];
}
