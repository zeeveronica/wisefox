import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/model/student_model.dart';
import 'package:wisefox/client/features/repos/student_repo.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';
import 'package:equatable/equatable.dart';

part 'students_event.dart';
part 'students_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentRepository studentRepository;

  StudentBloc(this.studentRepository) : super(StudentInitial()) {
    on<FetchStudents>(_onFetchStudents);
    on<SelectStudent>(_onSelectStudent);
    on<LoadSelectedStudent>(_onLoadSelectedStudent);
    on<FetchStudentDetails>(_onFetchStudentDetails);
  }

  Future<void> _onFetchStudents(
      FetchStudents event, Emitter<StudentState> emit) async {
    emit(StudentLoading());
    try {
      log("Fetching students...");
      final students = await studentRepository.fetchStudents();
      log("Fetched students: ${students.length}");
      emit(StudentLoaded(students));
    } catch (e) {
      log("Error fetching students: $e");
      emit(StudentError(e.toString()));
    }
  }

  Future<void> _onSelectStudent(
      SelectStudent event, Emitter<StudentState> emit) async {
    emit(StudentSelected(event.studentId));
    log("Selected student ID: ${event.studentId}");

    // Save the selected student ID to SharedPreferences
    await SharedPreferencesHelper.saveData(
        "selectedStudentId", event.studentId);
    log("Saved selectedStudentId ${event.studentId}");
  }

  Future<void> _onLoadSelectedStudent(
      LoadSelectedStudent event, Emitter<StudentState> emit) async {
    final studentId =
        await SharedPreferencesHelper.getData("selectedStudentId");
    log("student id is $studentId");
    if (studentId != null) {
      // emit(StudentSelected(studentId));
      add(FetchStudentDetails(studentId
          .toString())); // Fetch student details for the selected student
    } else {
      emit(StudentError("No student selected"));
    }
  }

  Future<void> _onFetchStudentDetails(
      FetchStudentDetails event, Emitter<StudentState> emit) async {
    log("student fertch details function");
    emit(StudentLoading());
    try {
      final studentDetails =
          await studentRepository.fetchStudentById(event.studentId);
      emit(StudentDetailsLoaded(studentDetails));
    } catch (e) {
      emit(StudentError("Failed to fetch student details: ${e.toString()}"));
    }
  }
}
