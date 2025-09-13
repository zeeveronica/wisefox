// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:wisefox/student/features/model/lesson_model.dart';
// import 'package:wisefox/student/features/repos/lesson_repos.dart';

// part 'lesson_event.dart';
// part 'lesson_state.dart';

// class LessonBloc extends Bloc<LessonEvent, LessonState> {
//   final LessonRepository lessonRepository;
//   List<LessonModel> _lessons = [];

//   LessonBloc(this.lessonRepository) : super(LessonInitial()) {
//     on<FetchLessons>(_onFetchLessons);
//     on<SetSelectedDate>(_onSetSelectedDate);
//   }

//   Future<void> _onFetchLessons(
//       FetchLessons event, Emitter<LessonState> emit) async {
//     emit(LessonLoading());
//     try {
//       // Fetch lessons based on type
//       _lessons = await lessonRepository.fetchLessons(event.type);
//       emit(LessonLoaded(_lessons));
//     } catch (e) {
//       emit(LessonError(e.toString()));
//     }
//   }

//   void _onSetSelectedDate(SetSelectedDate event, Emitter<LessonState> emit) {
//     if (state is LessonLoaded) {
//       final selectedDate = event.date;
//       final filteredLessons = selectedDate == null
//           ? _lessons
//           : _lessons.where((lesson) {
//               try {
//                 final lessonDate = DateTime.parse(lesson.date);
//                 return DateUtils.isSameDay(lessonDate, selectedDate);
//               } catch (e) {
//                 return false; // Handle the case where date parsing fails
//               }
//             }).toList();
//       emit(LessonLoaded(filteredLessons));
//     }
//   }
// }
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:wisefox/student/features/model/lesson_model.dart';
import 'package:flutter/material.dart';
import 'package:wisefox/student/features/repos/lesson_repos.dart';

part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final LessonRepository lessonRepository;
  List<LessonModel> _lessons = [];

  LessonBloc(this.lessonRepository) : super(LessonInitial()) {
    on<FetchLessons>(_onFetchLessons);
    on<SetSelectedDate>(_onSetSelectedDate);
  }

  Future<void> _onFetchLessons(
      FetchLessons event, Emitter<LessonState> emit) async {
    emit(LessonLoading());
    try {
      _lessons =
          await lessonRepository.fetchLessons(event.type, event.date); // Fetch by type
      emit(LessonLoaded(_lessons));
    } catch (e) {
      emit(LessonError(e.toString()));
    }
  }

  void _onSetSelectedDate(SetSelectedDate event, Emitter<LessonState> emit) {
    if (state is LessonLoaded) {
      final selectedDate = event.date;

      final filteredLessons = selectedDate == null
          ? _lessons // Show all lessons if no date is selected
          : _lessons.where((lesson) {
              try {
                final lessonDate = DateTime.parse(lesson.date).toLocal();
                final selectedDateOnly = DateTime(
                    selectedDate.year, selectedDate.month, selectedDate.day);
                final lessonDateOnly =
                    DateTime(lessonDate.year, lessonDate.month, lessonDate.day);

                print(
                    'Comparing Lesson Date: $lessonDateOnly with Selected Date: $selectedDateOnly');
                return lessonDateOnly == selectedDateOnly;
              } catch (e) {
                print('Error filtering lesson by date: $e');
                return false; // Handle parsing errors
              }
            }).toList();

      emit(LessonLoaded(filteredLessons));
    }
  }
}
