import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wisefox/student/features/model/lesson_details_model.dart';
import 'package:wisefox/student/features/repos/lessondetails_repos.dart';

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
      final lessonData = await _repository.fetchLessonDetails(event.lessonId);
      emit(LessondetailsLoaded(lessonData));
    } catch (e) {
      emit(LessondetailsError(e.toString()));
    }
  }
}
