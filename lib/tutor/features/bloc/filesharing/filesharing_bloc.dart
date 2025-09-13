import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/model/Filesharing_model.dart';
import 'package:wisefox/client/features/repos/filesharing_repos.dart';
import 'package:equatable/equatable.dart';

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
