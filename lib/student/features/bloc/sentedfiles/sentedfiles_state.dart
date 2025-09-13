// part of 'sentedfiles_bloc.dart';

// abstract class SentedfilesState extends Equatable {
//   const SentedfilesState();

//   @override
//   List<Object?> get props => [];
// }

// class SentedfilesInitial extends SentedfilesState {}

// class SentedfilesLoading extends SentedfilesState {}

// class SentedfilesLoaded extends SentedfilesState {
//   final List<SentedModel> files;

//   const SentedfilesLoaded(this.files);

//   @override
//   List<Object?> get props => [files];
// }

// class SentedfilesError extends SentedfilesState {
//   final String error;

//   const SentedfilesError(this.error);

//   @override
//   List<Object?> get props => [error];
// }
part of 'sentedfiles_bloc.dart';

abstract class SentedfilesState extends Equatable {
  const SentedfilesState();

  @override
  List<Object?> get props => [];
}

class SentedfilesInitial extends SentedfilesState {}

class SentedfilesLoading extends SentedfilesState {}

class SentedfilesLoaded extends SentedfilesState {
  final List<SentedModel> files;

  const SentedfilesLoaded(this.files);

  @override
  List<Object?> get props => [files];
}

class SentedfilesError extends SentedfilesState {
  final String error;

  const SentedfilesError(this.error);

  @override
  List<Object?> get props => [error];
}

class SentedFileDeleted extends SentedfilesState {
  final int fileId;

  SentedFileDeleted(this.fileId);

  @override
  List<Object?> get props => [fileId];
}
