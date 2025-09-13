import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wisefox/student/features/repos/sendfiles_repos.dart';

part 'send_files_event.dart';
part 'send_files_state.dart';

class SendFilesBloc extends Bloc<SendFilesEvent, SendFilesState> {
  final FileRepository repository;

  SendFilesBloc(this.repository) : super(SendFilesInitial()) {
    on<ShareFileEvent>(_onFileshareevent);
  }

  Future<void> _onFileshareevent(
      ShareFileEvent event, Emitter<SendFilesState> emit) async {
    emit(SendFileLoading());

    try {
      // Loop through the files to be shared
      for (var base64File in event.filePath) {
        final response = await repository.shareFileToApi(
          id: event.id,
          receiver: event.receiver,
          file: base64File,
          title: event.title,
          notes: event.notes,
          isDraft: event.isDraft,
        );

        // If the response is not successful, emit a failure state and stop further execution
        if (response.statusCode != 200) {
          emit(ShareFileFailure(
              error:
                  'Failed to share file. Status code: ${response.statusCode}'));
          return;
        }
      }

      // Emit success state after all files are shared
      emit(SendFileSuccess());

      // Optionally, reset the state to the initial state after success
    } catch (e) {
      emit(ShareFileFailure(error: e.toString()));
    }
  }
}
