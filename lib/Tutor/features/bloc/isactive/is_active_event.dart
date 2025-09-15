part of 'is_active_bloc.dart';

abstract class IsActiveEvent extends Equatable {
  const IsActiveEvent();

  @override
  List<Object?> get props => [];
}

class IsActiveRequested extends IsActiveEvent {
  final String studentId;
  final String status;

  const IsActiveRequested({required this.studentId, required this.status});

  @override
  List<Object?> get props => [studentId, status];
}
