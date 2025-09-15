part of 'filesharing_bloc.dart';

abstract class FilesharingState extends Equatable {
  const FilesharingState();

  @override
  List<Object> get props => [];
}

class FilesharingInitial extends FilesharingState {}

class FilesharingLoading extends FilesharingState {}

class FilesharingLoaded extends FilesharingState {
  final List<FilesharingModel> files;

  FilesharingLoaded(this.files);

  @override
  List<Object> get props => [files];
}

class FilesharingError extends FilesharingState {
  final String message;

  FilesharingError(this.message);

  @override
  List<Object> get props => [message];
}
