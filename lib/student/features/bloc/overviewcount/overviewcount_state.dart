part of 'overviewcount_bloc.dart';

abstract class OverviewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OverviewLoading extends OverviewState {}

class OverviewLoaded extends OverviewState {
  final OverviewCount overviewCount;

  OverviewLoaded(this.overviewCount);

  @override
  List<Object?> get props => [overviewCount];
}

class OverviewError extends OverviewState {
  final String message;

  OverviewError(this.message);

  @override
  List<Object?> get props => [message];
}
