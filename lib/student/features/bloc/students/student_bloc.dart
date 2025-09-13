import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wisefox/student/features/model/student_model.dart'; // Updated import
import 'package:wisefox/student/features/repos/student_repos.dart'; // Updated import

part 'student_event.dart';
part 'student_state.dart'; // Updated part file

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentRepository studentRepository;

  StudentBloc(this.studentRepository) : super(StudentInitial()) {
    on<FetchStudents>(_onFetchStudents);
  }

  Future<void> _onFetchStudents(
      FetchStudents event, Emitter<StudentState> emit) async {
    emit(StudentLoading());
    try {
      final students = await studentRepository.fetchStudents();
      print('Students fetched: $students');
      emit(StudentLoaded(students));
    } catch (e) {
      emit(StudentError(e.toString()));
    }
  }
}
