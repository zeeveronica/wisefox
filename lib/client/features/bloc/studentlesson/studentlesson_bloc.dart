import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/model/studentlesson.dart';
import 'package:wisefox/client/features/repos/studentlessonrepository.dart';
import 'package:equatable/equatable.dart';

part 'studentlesson_event.dart';
part 'studentlesson_state.dart';

class StudentLessonBloc extends Bloc<StudentLessonEvent, StudentLessonState> {
  final StudentLessonRepository lessonRepository;
  List<StudentLessonModel> _lessons = [];

  StudentLessonBloc(this.lessonRepository) : super(StudentLessonInitial()) {
    on<FetchStudentLessons>(_onFetchStudentLessons);

    on<SetStudentSelectedDate>(_onSetStudentSelectedDate);
  }

  Future<void> _onFetchStudentLessons(
      FetchStudentLessons event, Emitter<StudentLessonState> emit) async {
    emit(StudentLessonLoading());
    try {
      _lessons = await lessonRepository.fetchLessons(event.type);
      emit(StudentLessonLoaded(_lessons));
    } catch (e) {
      emit(StudentLessonError(e.toString()));
    }
  }

  void _onSetStudentSelectedDate(
      SetStudentSelectedDate event, Emitter<StudentLessonState> emit) {
    if (state is StudentLessonLoaded) {
      final selectedDate = event.date;
      final filteredLessons = selectedDate == null
          ? _lessons
          : _lessons.where((lesson) {
              try {
                final lessonDate = DateTime.parse(lesson.date).toLocal();
                final selectedDateOnly = DateTime(
                    selectedDate.year, selectedDate.month, selectedDate.day);
                final lessonDateOnly =
                    DateTime(lessonDate.year, lessonDate.month, lessonDate.day);

                return lessonDateOnly == selectedDateOnly;
              } catch (e) {
                print('Error filtering lesson by date: $e');
                return false;
              }
            }).toList();

      emit(StudentLessonLoaded(filteredLessons));
    }
  }
}
