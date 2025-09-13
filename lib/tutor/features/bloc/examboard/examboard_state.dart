part of 'examboard_bloc.dart';

abstract class ExamBoardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExamBoardInitial extends ExamBoardState {}

class ExamBoardLoading extends ExamBoardState {}

class ExamBoardLoaded extends ExamBoardState {
  final List<ExamBoardModel> examBoardList;

  ExamBoardLoaded(this.examBoardList);

  @override
  List<Object?> get props => [examBoardList];
}

class ExamBoardError extends ExamBoardState {
  final String error;

  ExamBoardError(this.error);

  @override
  List<Object?> get props => [error];
}
