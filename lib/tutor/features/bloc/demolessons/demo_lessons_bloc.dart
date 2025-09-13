import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/model/demolessons_model.dart';
import 'package:wisefox/client/features/model/studentlesson.dart';
import 'package:wisefox/client/features/repos/demolesson_repos.dart';
import 'package:equatable/equatable.dart';
// Import DemoLessonRepository

part 'demo_lessons_event.dart';
part 'demo_lessons_state.dart';

class DemoLessonsBloc extends Bloc<DemoLessonsEvent, DemoLessonsState> {
  final DemoLessonRepository demoLessonRepository;
  List<StudentLessonModel> _lessons = [];

  DemoLessonsBloc(this.demoLessonRepository) : super(DemoLessonsInitial()) {
    on<FetchDemoLessons>(_onFetchDemoLessons);
  }

  Future<void> _onFetchDemoLessons(
      FetchDemoLessons event, Emitter<DemoLessonsState> emit) async {
    emit(DemoLessonsLoading());
    try {
      _lessons = await demoLessonRepository.fetchLessons(event.type);
      emit(DemoLessonsLoaded(_lessons));
    } catch (e) {
      emit(DemoLessonsError(e.toString()));
    }
  }
}
