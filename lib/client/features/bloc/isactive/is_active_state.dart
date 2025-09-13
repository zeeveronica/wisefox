part of 'is_active_bloc.dart';

abstract class IsActiveState extends Equatable {
  const IsActiveState();

  @override
  List<Object?> get props => [];
}

class IsActiveInitial extends IsActiveState {}

class IsActiveLoading extends IsActiveState {}

class IsActiveSuccess extends IsActiveState {
  final String newStatus; // New field to hold the updated status

  const IsActiveSuccess({required this.newStatus});

  @override
  List<Object?> get props => [newStatus];
}

class IsActiveFailure extends IsActiveState {
  final String error;

  const IsActiveFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
