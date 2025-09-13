import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wisefox/student/features/model/demolessons_model.dart';
import 'package:wisefox/student/features/repos/demolesson_repos.dart'; // Import DemoLessonRepository

part 'demo_lessons_event.dart';
part 'demo_lessons_state.dart';

class DemoLessonsBloc extends Bloc<DemoLessonsEvent, DemoLessonsState> {
  final DemoLessonRepository demoLessonRepository;

  DemoLessonsBloc(this.demoLessonRepository) : super(DemoLessonsInitial()) {
    on<FetchDemoLessons>(_onFetchDemoLessons);
  }

  Future<void> _onFetchDemoLessons(
      FetchDemoLessons event, Emitter<DemoLessonsState> emit) async {
    emit(DemoLessonsLoading());
    try {
      final demoLessons = await demoLessonRepository.fetchDemoLessons();
      emit(DemoLessonsLoaded(demoLessons));
    } catch (e) {
      emit(DemoLessonsError(e.toString()));
    }
  }
}
