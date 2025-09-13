part of 'examboard_bloc.dart';

abstract class ExamBoardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchExamBoardList extends ExamBoardEvent {}
