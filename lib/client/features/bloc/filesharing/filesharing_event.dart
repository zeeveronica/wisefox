part of 'filesharing_bloc.dart';

abstract class FilesharingEvent extends Equatable {
  const FilesharingEvent();

  @override
  List<Object> get props => [];
}

class FetchFilesharingEvent extends FilesharingEvent {}
