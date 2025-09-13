// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:wisefox/student/features/model/sentedfile_model.dart'; // Ensure correct model import
// import 'package:wisefox/student/features/repos/sentedfiles_repos.dart';

// part 'sentedfiles_event.dart';
// part 'sentedfiles_state.dart';

// class SentedfilesBloc extends Bloc<SentedfilesEvent, SentedfilesState> {
//   final SentFilesRepository sentFilesRepository;

//   SentedfilesBloc(this.sentFilesRepository) : super(SentedfilesInitial()) {
//     on<FetchSentedfiles>(_onFetchSentedfiles);
//   }

//   Future<void> _onFetchSentedfiles(
//       FetchSentedfiles event, Emitter<SentedfilesState> emit) async {
//     emit(SentedfilesLoading());
//     try {
//       final sentFiles = await sentFilesRepository.fetchSentFiles();
//       emit(SentedfilesLoaded(sentFiles));
//     } catch (e) {
//       emit(SentedfilesError(e.toString()));
//     }
//   }
// }
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wisefox/student/features/model/sentedfile_model.dart';
import 'package:wisefox/student/features/repos/sentedfiles_repos.dart';

part 'sentedfiles_event.dart';
part 'sentedfiles_state.dart';

class SentedfilesBloc extends Bloc<SentedfilesEvent, SentedfilesState> {
  final SentFilesRepository sentFilesRepository;

  SentedfilesBloc(this.sentFilesRepository) : super(SentedfilesInitial()) {
    on<FetchSentedfiles>(_onFetchSentedfiles);
    on<DeleteSentedfile>(_onDeleteSendFile);
  }

  Future<void> _onFetchSentedfiles(
      FetchSentedfiles event, Emitter<SentedfilesState> emit) async {
    emit(SentedfilesLoading());
    try {
      final sentFiles = await sentFilesRepository.fetchSentFiles();
      emit(SentedfilesLoaded(sentFiles));
    } catch (e) {
      emit(SentedfilesError(e.toString()));
    }
  }

  Future<void> _onDeleteSendFile(
      DeleteSentedfile event, Emitter<SentedfilesState> emit) async {
    emit(SentedfilesLoading());
    try {
      await sentFilesRepository.deleteReceivedFile(event.fileId);
      emit(SentedFileDeleted(event.fileId));
      final files = await sentFilesRepository.fetchSentFiles();
      emit(SentedfilesLoaded(files));
    } catch (e) {
      emit(SentedfilesError("Failed to delete send file: ${e.toString()}"));
    }
  }
}
