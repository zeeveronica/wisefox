part of 'cancellesson_bloc.dart';

abstract class CancelLessonState extends Equatable {
  const CancelLessonState();

  @override
  List<Object?> get props => [];
}

class CancelLessonInitial extends CancelLessonState {}

class CancelLessonLoading extends CancelLessonState {}

class CancelLessonSuccess extends CancelLessonState {}

class CancelLessonFailure extends CancelLessonState {
  final String error;

  const CancelLessonFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
