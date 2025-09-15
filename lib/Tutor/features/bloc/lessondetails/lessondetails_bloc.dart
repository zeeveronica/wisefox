import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/model/lesson_details_model.dart';
import 'package:wisefox/client/features/repos/lessondetails_repos.dart';
import 'package:equatable/equatable.dart';

part 'lessondetails_event.dart';
part 'lessondetails_state.dart';

class LessondetailsBloc extends Bloc<LessondetailsEvent, LessondetailsState> {
  final LessondetailsRepository _repository;

  LessondetailsBloc(this._repository) : super(LessondetailsInitial()) {
    on<FetchLessonDetails>(_onFetchLessonDetails);
  }

  Future<void> _onFetchLessonDetails(
    FetchLessonDetails event,
    Emitter<LessondetailsState> emit,
  ) async {
    emit(LessondetailsLoading());
    try {
      final lessonData =
          await _repository.fetchLessonDetails(event.lessonId, event.timezone);
      emit(LessondetailsLoaded(lessonData));
    } catch (e) {
      emit(LessondetailsError(e.toString()));
    }
  }
}
