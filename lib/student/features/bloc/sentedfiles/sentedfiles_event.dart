// part of 'sentedfiles_bloc.dart';

// abstract class SentedfilesEvent extends Equatable {
//   const SentedfilesEvent();

//   @override
//   List<Object?> get props => [];
// }

// class FetchSentedfiles extends SentedfilesEvent {
//   const FetchSentedfiles();

//   @override
//   List<Object?> get props => [];
// }
part of 'sentedfiles_bloc.dart';

abstract class SentedfilesEvent extends Equatable {
  const SentedfilesEvent();

  @override
  List<Object?> get props => [];
}

class FetchSentedfiles extends SentedfilesEvent {
  const FetchSentedfiles();

  @override
  List<Object?> get props => [];
}

class DeleteSentedfile extends SentedfilesEvent {
  final int fileId;

  const DeleteSentedfile(this.fileId);

  @override
  List<Object?> get props => [fileId];
}
