import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wisefox/student/features/model/filesharing_model.dart';
import 'package:wisefox/student/features/repos/filesharing_repos.dart';

part 'filesharing_event.dart';
part 'filesharing_state.dart';

class FilesharingBloc extends Bloc<FilesharingEvent, FilesharingState> {
  final FilesharingRepository filesharingRepository;

  FilesharingBloc(this.filesharingRepository) : super(FilesharingInitial()) {
    on<FetchFilesharingEvent>((event, emit) async {
      emit(FilesharingLoading());
      try {
        final files = await filesharingRepository.fetchFiles();
        emit(FilesharingLoaded(files));
      } catch (e) {
        emit(FilesharingError('Failed to load files'));
      }
    });
  }
}
