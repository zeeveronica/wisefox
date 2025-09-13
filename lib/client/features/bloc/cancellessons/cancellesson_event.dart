part of 'cancellesson_bloc.dart';

abstract class CancelLessonEvent extends Equatable {
  const CancelLessonEvent();

  @override
  List<Object?> get props => [];
}

class CancelLessonRequested extends CancelLessonEvent {
  final int id;
  final String reasonForCancellation;

  const CancelLessonRequested(
      {required this.id, required this.reasonForCancellation});

  @override
  List<Object?> get props => [id, reasonForCancellation];
}
