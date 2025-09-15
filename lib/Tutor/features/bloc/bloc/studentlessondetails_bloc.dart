import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/model/lesson_details_model.dart';
import 'package:wisefox/client/features/repos/studentlessondetails_repos.dart';
import 'package:equatable/equatable.dart';

part 'studentlessondetails_event.dart';
part 'studentlessondetails_state.dart';

class StudentLessonDetailBloc
    extends Bloc<StudentLessonDetailsEvent, StudentLessonDetailsState> {
  final StudentLessonDetailsRepository _repository;

  StudentLessonDetailBloc(this._repository)
      : super(StudentLessonDetailsInitial()) {
    on<FetchStudentLessonDetails>(_onFetchLessonDetails);
  }

  Future<void> _onFetchLessonDetails(
    FetchStudentLessonDetails event,
    Emitter<StudentLessonDetailsState> emit,
  ) async {
    emit(StudentLessonDetailsLoading());
    try {
      final lessonData =
          await _repository.fetchLessonDetails(event.lessonId, event.timezone);
      emit(StudentLessonDetailsLoaded(lessonData));
    } catch (e) {
      emit(StudentLessonDetailsError(e.toString()));
    }
  }
}
