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

abstract class DemoRequestState extends Equatable {
  const DemoRequestState();

  @override
  List<Object?> get props => [];
}

class DemoRequestedfilesInitial extends DemoRequestState {}

class DemoRequestedLoading extends DemoRequestState {}

class DemoRequestedfilesLoaded extends DemoRequestState {
  final List<StudentListModel> files;

  const DemoRequestedfilesLoaded(this.files);

  @override
  List<Object?> get props => [files];
}

class DemoRequestedfilesError extends DemoRequestState {
  final String error;

  const DemoRequestedfilesError(this.error);

  @override
  List<Object?> get props => [error];
}

class SentedFileDeleted extends DemoRequestState {
  final int fileId;

  SentedFileDeleted(this.fileId);

  @override
  List<Object?> get props => [fileId];
}

class StudentSearchLoaded extends DemoRequestState {
  final List<StudentListModel> students;
  final String? searchQuery; // Optional to keep track of current search

  StudentSearchLoaded(this.students, {this.searchQuery});
}
