part of 'send_files_bloc.dart';

abstract class SendFilesState extends Equatable {
  const SendFilesState();

  @override
  List<Object> get props => [];
}

class SendFilesInitial extends SendFilesState {}

class SendFileLoading extends SendFilesState {}

class SendFileSuccess extends SendFilesState {}

class ShareFileFailure extends SendFilesState {
  final String error;

  ShareFileFailure({required this.error});

  @override
  List<Object> get props => [error];
}
