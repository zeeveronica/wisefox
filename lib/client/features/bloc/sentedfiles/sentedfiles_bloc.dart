import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/model/sentedfile_model.dart';
import 'package:wisefox/client/features/repos/demorequest_repos.dart';
import 'package:equatable/equatable.dart';

part 'sentedfiles_event.dart';
part 'sentedfiles_state.dart';

class DemoRequestBloc extends Bloc<DemoRequestEvent, DemoRequestState> {
  final DemoRequestRepository sentFilesRepository;

  DemoRequestBloc(this.sentFilesRepository)
      : super(DemoRequestedfilesInitial()) {
    on<FetchSentedfiles>(_onFetchSentedfiles);
    on<DeleteSentedfile>(_onDeleteSendFile);
    on<Fetchsearch>(_onFetchSearchStudents);
  }

  Future<void> _onFetchSentedfiles(
      FetchSentedfiles event, Emitter<DemoRequestState> emit) async {
    emit(DemoRequestedLoading());
    try {
      final sentFiles = await sentFilesRepository.fetchSentFiles();
      emit(DemoRequestedfilesLoaded(sentFiles));
    } catch (e) {
      emit(DemoRequestedfilesError(e.toString()));
    }
  }

  Future<void> _onFetchSearchStudents(
      Fetchsearch event, Emitter<DemoRequestState> emit) async {
    emit(DemoRequestedLoading());

    try {
      // Fetch the list of students based on the search query
      final students = await sentFilesRepository.listSearchStudents(
        searchQuery: event.searchQuery,
      );

      // Check if the search query is provided and not empty
      if (event.searchQuery != null && event.searchQuery!.trim().isNotEmpty) {
        // Emit search loaded state with the list of students and the search query
        emit(StudentSearchLoaded(students,
            searchQuery: event.searchQuery!.trim()));
      } else {
        // If search query is empty or null, emit the general loaded state
        emit(DemoRequestedfilesLoaded(students));
      }
    } catch (e) {
      // Emit failure state if any error occurs
      emit(DemoRequestedfilesError(e.toString()));
    }
  }

  Future<void> _onDeleteSendFile(
      DeleteSentedfile event, Emitter<DemoRequestState> emit) async {
    emit(DemoRequestedLoading());
    try {
      await sentFilesRepository.deleteReceivedFile(event.fileId);
      emit(SentedFileDeleted(event.fileId));
      final files = await sentFilesRepository.fetchSentFiles();
      emit(DemoRequestedfilesLoaded(files));
    } catch (e) {
      emit(DemoRequestedfilesError(
          "Failed to delete send file: ${e.toString()}"));
    }
  }
}
