import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/model/lesson_model.dart';
import 'package:wisefox/client/features/repos/clientlesson_repos.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

part 'clientlesson_event.dart';
part 'clientlesson_state.dart';

class ClientLessonBloc extends Bloc<ClientLessonEvent, ClientLessonState> {
  final ClientLessonRepository lessonRepository;
  List<ClientLessonModel> _lessons = [];

  ClientLessonBloc(this.lessonRepository) : super(ClientLessonInitial()) {
    on<FetchLessons>(_onFetchLessons);
    on<SetSelectedDate>(_onSetSelectedDate);
  }

  Future<void> _onFetchLessons(
      FetchLessons event, Emitter<ClientLessonState> emit) async {
    emit(ClientLessonLoading());
    try {
      _lessons = await lessonRepository.fetchLessons(
          event.status, event.timezone); // Fetch by type
      emit(ClientLessonLoaded(_lessons));
    } catch (e) {
      emit(ClientLessonError(e.toString()));
    }
  }

  void _onSetSelectedDate(
      SetSelectedDate event, Emitter<ClientLessonState> emit) {
    if (state is ClientLessonLoaded) {
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

      emit(ClientLessonLoaded(filteredLessons));
    }
  }
}
