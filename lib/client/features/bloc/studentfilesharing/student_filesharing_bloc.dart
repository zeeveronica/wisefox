import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/bloc/studentfilesharing/student_filesharing_event.dart';
import 'package:wisefox/client/features/bloc/studentfilesharing/student_filesharing_state.dart';
import 'package:wisefox/client/features/repos/sendfiles_repos.dart';
import 'package:wisefox/client/features/repos/studentfilerepository.dart';
import 'package:wisefox/client/features/repos/studentreceivedfile_repo.dart';
import 'package:wisefox/client/features/repos/studentsendfile_repos.dart';
import 'package:equatable/equatable.dart';

class StudentShareFileBloc
    extends Bloc<StudentFilesharingEvent, StudentFilesharingState> {
  final StudentFileRepository repository;

  StudentShareFileBloc(this.repository) : super(StudentFileInitial()) {
    on<StudentFileshareEvent>(_onStudentFileshareEvent);
    on<StudentFileInitialEvent>(emitStudentInitial);
  }

  void emitStudentInitial(
      StudentFileInitialEvent event, Emitter<StudentFilesharingState> emit) {
    emit(StudentFileInitial());
  }

  Future<void> _onStudentFileshareEvent(
    StudentFileshareEvent event,
    Emitter<StudentFilesharingState> emit,
  ) async {
    emit(StudentFileLoading());

    try {
      for (var base64File in event.filePath) {
        final response = await repository.shareFileToApi(
          id: event.id,
          receiver: event.receiver,
          sender: event.sender,
          file: base64File,
          title: event.title,
          notes: event.notes,
          isDraft: event.isDraft,
        );
        log("API Response: ${response.body}");

        if (response.statusCode != 200) {
          emit(StudentFileFailure(
              error:
                  'Failed to share file. Status code: ${response.statusCode}'));
          return; // Stop processing on error
        }
      }
      emit(StudentFileSuccess());
    } catch (e) {
      emit(StudentFileFailure(error: 'Failed to share files: ${e.toString()}'));
    }
  }
}

class StudentReceivedFileBloc
    extends Bloc<StudentReceivedFileEvent, StudentReceivedFileState> {
  final ReceivedFileRepository repository;

  StudentReceivedFileBloc(this.repository)
      : super(StudentReceivedFileInitial()) {
    on<StudentLoadReceivedFiles>(_onStudentLoadReceivedFiles);

    on<StudentReceivedFileEvent>(_onStudentReceivedFileEvent);
  }

  Future<void> _onStudentLoadReceivedFiles(StudentLoadReceivedFiles event,
      Emitter<StudentReceivedFileState> emit) async {
    emit(StudentReceivedFileLoading());
    try {
      final files = await repository.getReceivedFiles();
      emit(StudentReceivedFileLoaded(files));
    } catch (e) {
      emit(StudentReceivedFileError("Failed to load received files"));
    }
  }

  Future<void> _onStudentReceivedFileEvent(StudentReceivedFileEvent event,
      Emitter<StudentReceivedFileState> emit) async {}
}

class StudentSendFileBloc
    extends Bloc<StudentSendFileEvent, StudentSendFileState> {
  final SendFileRepository repository;

  StudentSendFileBloc(this.repository) : super(StudentSendFileInitial()) {
    on<StudentLoadSendFiles>(_onStudentLoadSendFiles);
    on<StudentDeleteSendFile>(_onStudentDeleteSendFile);
  }

  Future<void> _onStudentLoadSendFiles(
      StudentLoadSendFiles event, Emitter<StudentSendFileState> emit) async {
    emit(StudentSendFileLoading());
    try {
      final files = await repository.getsendFiles();
      emit(StudentSendFileLoaded(files));
    } catch (e) {
      emit(StudentSendFileError("Failed to load sent files"));
    }
  }

  Future<void> _onStudentDeleteSendFile(
      StudentDeleteSendFile event, Emitter<StudentSendFileState> emit) async {
    emit(StudentSendFileLoading());
    try {
      await repository.deleteReceivedFile(event.fileId);
      emit(StudentSendFileDeleted(event.fileId));
      final files = await repository.getsendFiles();
      emit(StudentSendFileLoaded(files));
    } catch (e) {
      emit(StudentSendFileError("Failed to delete sent file: ${e.toString()}"));
    }
  }
}
