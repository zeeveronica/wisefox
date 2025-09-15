import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/model/lesson_model.dart';
import 'package:wisefox/client/features/repos/clientlesson_repos.dart';
import 'package:equatable/equatable.dart';

part 'clientdemolesson_event.dart';
part 'clientdemolesson_state.dart';

class ClientDemoLessonBloc
    extends Bloc<ClientDemoLessonEvent, ClientDemoLessonState> {
  final ClientLessonRepository lessonRepository;
  List<ClientLessonModel> _lessons = [];

  ClientDemoLessonBloc(this.lessonRepository)
      : super(ClientDemoLessonInitial()) {
    on<FetchClientDemoLessons>(_onFetchLessons);
  }

  Future<void> _onFetchLessons(
      FetchClientDemoLessons event, Emitter<ClientDemoLessonState> emit) async {
    emit(ClientDemoLessonLoading());
    try {
      _lessons =
          await lessonRepository.fetchLessons(event.status, event.timezone);
      emit(ClientDemoLessonLoaded(_lessons));
    } catch (e) {
      emit(ClientDemoLessonError(e.toString()));
    }
  }
}
