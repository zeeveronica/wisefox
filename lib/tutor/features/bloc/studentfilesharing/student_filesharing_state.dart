import 'package:wisefox/client/features/model/studentrecievedfile.dart';
import 'package:wisefox/client/features/model/studentsendfile.dart';
import 'package:equatable/equatable.dart';

// Abstract class for Student Filesharing States
abstract class StudentFilesharingState extends Equatable {
  const StudentFilesharingState();

  @override
  List<Object> get props => [];
}

class StudentFileInitial extends StudentFilesharingState {}

class StudentFileLoading extends StudentFilesharingState {}

class StudentFileSuccess extends StudentFilesharingState {}

class StudentFileFailure extends StudentFilesharingState {
  final String error;

  const StudentFileFailure({required this.error});

  @override
  List<Object> get props => [error];
}

// Abstract class for Received File States
abstract class StudentReceivedFileState extends Equatable {
  const StudentReceivedFileState();

  @override
  List<Object> get props => [];
}

// Initial state
class StudentReceivedFileInitial extends StudentReceivedFileState {}

// State when files are being loaded
class StudentReceivedFileLoading extends StudentReceivedFileState {}

// State when files are loaded successfully
class StudentReceivedFileLoaded extends StudentReceivedFileState {
  final List<StudentReceivedFile> studentreceivedFiles;

  const StudentReceivedFileLoaded(this.studentreceivedFiles);

  @override
  List<Object> get props => [studentreceivedFiles];
}

// State when there's an error loading files
class StudentReceivedFileError extends StudentReceivedFileState {
  final String message;

  const StudentReceivedFileError(this.message);

  @override
  List<Object> get props => [message];
}

// Abstract class for Send File States
abstract class StudentSendFileState extends Equatable {
  const StudentSendFileState();

  @override
  List<Object> get props => [];
}

// Initial state
class StudentSendFileInitial extends StudentSendFileState {}

// State when files are being loaded
class StudentSendFileLoading extends StudentSendFileState {}

// State when files are loaded successfully
class StudentSendFileLoaded extends StudentSendFileState {
  final List<StudentSendfile> studentsendFiles;

  const StudentSendFileLoaded(this.studentsendFiles);

  @override
  List<Object> get props => [studentsendFiles];
}

// State when there's an error loading files
class StudentSendFileError extends StudentSendFileState {
  final String message;

  const StudentSendFileError(this.message);

  @override
  List<Object> get props => [message];
}

class StudentSendFileDeleted extends StudentSendFileState {
  final int fileId;

  const StudentSendFileDeleted(this.fileId);

  @override
  List<Object> get props => [fileId];
}
