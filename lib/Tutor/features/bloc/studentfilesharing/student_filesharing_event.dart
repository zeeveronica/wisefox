import 'package:wisefox/client/features/model/studentrecievedfile.dart';
import 'package:wisefox/client/features/model/studentsendfile.dart';
import 'package:equatable/equatable.dart';

// Abstract class for Student Filesharing Events
abstract class StudentFilesharingEvent extends Equatable {
  const StudentFilesharingEvent();

  @override
  List<Object?> get props => [];
}

// Event for sharing a file
class StudentFileshareEvent extends StudentFilesharingEvent {
  final int? id;
  final String receiver;
  final String sender;
  final List<String> filePath;
  final String title;
  final String notes;
  final bool isDraft;

  const StudentFileshareEvent({
    required this.id,
    required this.receiver,
    required this.sender,
    required this.filePath,
    required this.title,
    required this.notes,
    this.isDraft = false,
  });

  @override
  List<Object?> get props =>
      [id, receiver, filePath, title, notes, isDraft, sender];
}

// Initial event for file sharing
class StudentFileInitialEvent extends StudentFilesharingEvent {
  const StudentFileInitialEvent();

  @override
  List<Object?> get props => [];
}

class StudentReceivedFileEvent extends Equatable {
  const StudentReceivedFileEvent();

  @override
  List<Object?> get props => [];
}

class StudentLoadReceivedFiles extends StudentReceivedFileEvent {}

class StudentAddReceivedFile extends StudentReceivedFileEvent {
  final StudentReceivedFile studentreceivedFile;

  const StudentAddReceivedFile(this.studentreceivedFile);

  @override
  List<Object?> get props => [studentreceivedFile];
}

// Abstract class for Send File Events
abstract class StudentSendFileEvent extends Equatable {
  const StudentSendFileEvent();

  @override
  List<Object?> get props => [];
}

// Event to load sent files
class StudentLoadSendFiles extends StudentSendFileEvent {}

// Event to add a new sent file
class StudentAddSendFile extends StudentSendFileEvent {
  final StudentSendfile studentsendFile;

  const StudentAddSendFile(this.studentsendFile);

  @override
  List<Object?> get props => [studentsendFile];
}

// Event to delete a sent file
class StudentDeleteSendFile extends StudentSendFileEvent {
  final int fileId;

  const StudentDeleteSendFile(this.fileId);

  @override
  List<Object?> get props => [fileId];
}
